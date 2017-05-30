# Country Codes

## Data

[`countries.cvs.txt`](https://github.com/OpenBookPrices/country-data/blob/master/data/countries.csv) is from [country-data](https://github.com/OpenBookPrices/country-data) repo. _MIT Licensed_. This is used to build
`uhx.types.Countries.hx`.

## Api

### [Status](https://github.com/skial/country-codes/blob/master/src/uhx/types/Country.hx) API

```haxe
@:enum abstract Status(String) from String to String {
    public var Assigned;
    public var Reserved;
    public var User;
    public var Deleted;
}
```

### [Country](https://github.com/skial/country-codes/blob/master/src/uhx/types/Country.hx) API

```haxe
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
```

### [Countries](https://github.com/skial/country-codes/blob/master/src/uhx/types/Countries.hx) API

```haxe
class Countries {
    public static var cc:Map<String, Country>;
    public static var list:Map<String, Array<Country>>;

    public static var AF(default, never):Country;
    public static var AL(default, never):Country;
    // Access all countries directly via their two character country code.
}
```