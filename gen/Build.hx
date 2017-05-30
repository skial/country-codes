package gen;

import thx.csv.Csv;
import haxe.macro.Expr;
import uhx.types.Country;
import haxe.macro.Printer;

using StringTools;
using sys.io.File;
using haxe.io.Path;

typedef CvsData = {
    var alpha2:String;
    var alpha3:Null<String>;
    var ccTLD:Null<String>;
    var name:String;
    var languages:Null<String>;
    var emoji:Null<String>;
    var ioc:Null<String>;
    var status:String;
    var countryCallingCodes:Null<Array<String>>;
    var currencies:Null<Array<String>>;
}

class Build {

    public static function generate() {
        var fields = [];
        var data = Csv.decodeObjects('${Sys.getCwd()}/res/countries.csv.txt'.normalize().getContent());
        var output = '${Sys.getCwd()}/src/uhx/types/Countries.hx'.normalize();
        var map = new Map<String, Array<Expr>>();
        var lookup = [];
        var cc = [];

        for (i in 0...data.length) {
            var info:CvsData = cast data[i];
            var name = info.alpha2;
            var temp = macro class Temp {
                public static var $name(default, never):uhx.types.Country = {
                    name:$v{info.name}, 
                    alpha2:$v{info.alpha2},
                    status:$e{toCountryStatus(info.status)},
                    ioc:$e{info.ioc == null || info.ioc == '' ? macro haxe.ds.Option.None : macro haxe.ds.Option.Some($v{info.ioc})},
                    ccTLD:$e{info.ccTLD == null || info.ccTLD == '' ? macro haxe.ds.Option.None : macro haxe.ds.Option.Some($v{info.ccTLD.substring(1)})},
                    alpha3:$e{info.alpha3 == null || info.alpha3 == '' ? macro haxe.ds.Option.None : macro haxe.ds.Option.Some($v{info.alpha3})},
                    languages:$e{info.languages == null || info.languages == '' ? macro haxe.ds.Option.None : macro haxe.ds.Option.Some($v{info.languages.split(',')})},
                }
            }

            fields.push( temp.fields[0] );
            
            cc.push( macro $v{info.alpha2.toLowerCase()} => $i{info.alpha2} );
            if (info.ccTLD != null && info.ccTLD != '' && info.ccTLD.substring(1) != info.alpha2.toLowerCase()) cc.push( macro $v{info.ccTLD.substring(1)} => $i{info.alpha2} );

            if (!map.exists(info.name)) {
                map.set(info.name, [
                    macro $i{info.alpha2}
                ]);

            } else {
                map.get(info.name).push( macro $i{info.alpha2} );

            } 
        }

        for (key in map.keys()) lookup.push( macro $v{key} => $a{map.get(key)} );
        var td = macro class Countries {
            public static var list(default, never):Map<String, Array<uhx.types.Country>> = $a{lookup};
            public static var cc(default, never):Map<String, uhx.types.Country> = $a{cc};
        }

        td.fields = fields.concat(td.fields);
        td.pack = ['uhx', 'types'];
        output.saveContent(new Printer().printTypeDefinition(td, true));

    }

    private static function toCountryStatus(v:String):ExprOf<uhx.types.Country.Status> {
        return switch v {
            case 'assigned': macro uhx.types.Country.Status.Assigned;
            case 'reserved': macro uhx.types.Country.Status.Reserved;
            case 'user assigned': macro uhx.types.Country.Status.User;
            case 'deleted': macro uhx.types.Country.Status.Deleted;
            case _: throw 'Unkown Country status: $v';
        }
    }

}