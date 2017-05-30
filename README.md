# Country Codes

## Data

[`countries.cvs.txt`](https://github.com/OpenBookPrices/country-data/blob/master/data/countries.csv) is from [country-data](https://github.com/OpenBookPrices/country-data) repo. _MIT Licensed_. This is used to build
`uhx.types.Countries.hx`.

## Usage

Access each country entry via its uppercase two character representation. Or access
using the countries _English_ name, its two character representation in either upper or lower 
case via `Countries.list` which is of type `Map<String, Array<Country>>`.

```haxe
package ;

import uhx.types.Countries;

class Main {

    public static function main() {
        var uk = Countries.UK;
        var ug = Countries.list.get('Uganda');
    }

}