package uhx.types;

import haxe.ds.Option;

@:enum @:forward abstract Status(String) from String to String {
    public var Assigned = 'assigned';
    public var Reserved = 'reserved';
    public var User = 'user assigned';
    public var Deleted = 'deleted';
}

@:structInit class Country {

    // The english name for the country
    public var name:String;
    // The ISO 3166-1 alpha 2 code
    public var alpha2:String;
    // The ISO status of the entry.
    public var status:Status;
    // The International Olympic Committee country code
    public var ioc:Option<String>;
    // The country code top-level domain 
    public var ccTLD:Option<String>;
    // The ISO 3166-1 alpha 3 code
    public var alpha3:Option<String>;
    // An array of ISO 639-2 codes for languages (may not be complete).
    public var languages:Option<Array<String>>;

}