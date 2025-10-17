use context dcic2024

include data-source
include csv
items = table: item :: String, x-coordinate :: Number, y-coordinate :: Number
  row: "Sword of Dawn",           23,  -87
  row: "Healing Potion",         -45,   12
  row: "Dragon Shield",           78,  -56
  row: "Magic Staff",             -9,   64
  row: "Elixir of Strength",      51,  -33
  row: "Cloak of Invisibility",  -66,    5
  row: "Ring of Fire",            38,  -92
  row: "Boots of Swiftness",     -17,   49
  row: "Amulet of Protection",    82,  -74
  row: "Orb of Wisdom",          -29,  -21
end

fun movecloser(location :: Number) -> Number:
  doc: "Moves the location closer by 10%"
  location * 0.9
end

closer-items-x = transform-column(items, "x-coordinate", movecloser)
closer-items = transform-column(closer-items-x, "y-coordinate", movecloser)
fun calc-distance(r :: Row) -> Number:
  doc: "calculates distance to origin from fields 'x-coordinate' and 'y-coordinate'"
  num-sqrt(
    num-sqr(r["x-coordinate"]) + num-sqr(r["y-coordinate"]))
where:
  calc-distance(items.row-n(0)) is-roughly
    num-sqrt(num-sqr(23) + num-sqr(-87))
      
  calc-distance(items.row-n(3)) is-roughly
    num-sqrt(num-sqr(-9) + num-sqr(64))
end
items
closer-items
closer-items-w-dist=build-column(closer-items, "distance", calc-distance)
closer-items-w-dist-exact = transform-column(closer-items-w-dist, "distance", num-to-rational)
order-by(closer-items-w-dist-exact, "distance", true).row-n(0)["item"]

fun replace-w-x(string :: String) -> String:
  string-repeat("x", string-length(string))
where:
  replace-w-x("Hi") is "xx"
  replace-w-x("Hello there") is "xxxxxxxxxxx"
end

closer-items-xed = transform-column(items, "item", replace-w-x)
closer-items-xed

fun obfuscate-table(table :: Table) -> Table:
  transform-column(table, "item", replace-w-x)
end

new-table=table: item :: String
  row: "Banana"
  row: "orange"
  row: "MacBook Air"
  row: "Boeing 747"
end
check:
  obfuscate-table(new-table) is table: item :: String
    row: "xxxxxx"
    row: "xxxxxx"
    row: "xxxxxxxxxxx"
    row: "xxxxxxxxxx"
  end
end

fun add-PHL-sales-tax(table :: Table)->Table:
  doc: "Accepts a table of pre-tax sales and adds a new column called Total that includes the 8% sales tax applicable in the City of Philadelphia."
  build-column(table, "total", lam(n): n["price"] * 1.08 end)
where:
  add-PHL-sales-tax(table: price :: Number
      row: 100
      row: 10
      row: 0
    end) is table: price :: Number, total :: Number
    row: 100, 108
    row: 10, 10.8
  row: 0, 0 end
end

cpi=load-table: Code :: String, Indicies :: Number, Aug-24 :: Number, Sep-24 :: Number, Oct-24 :: Number, Nov-24 :: Number, Dec-24 :: Number, Jan-25 :: Number, Feb-25 :: Number, Mar-25 :: Number, Apr-25 :: Number, May-25 :: Number, Jun-25 :: Number, Jul-25 :: Number, Aug-25 :: Number
  source: csv-table-file("cpi.csv", default-options)
  sanitize Aug-24 using num-sanitizer
  sanitize Sep-24 using num-sanitizer
  sanitize Oct-24 using num-sanitizer
  sanitize Nov-24 using num-sanitizer
  sanitize Dec-24 using num-sanitizer
  sanitize Jan-25 using num-sanitizer
  sanitize Feb-25 using num-sanitizer
  sanitize Mar-25 using num-sanitizer
  sanitize Apr-25 using num-sanitizer
  sanitize May-25 using num-sanitizer
  sanitize Jun-25 using num-sanitizer
  sanitize Jul-25 using num-sanitizer
  sanitize Aug-25 using num-sanitizer
end

cpi-difference=build-column(cpi, "difference", lam(n): n["Aug-25"] - n["Aug-24"] end)
cpi-difference
cpi-pct-diff=build-column(cpi-difference, "pct-difference", lam(n): (num-abs(n["Aug-24"] - n["difference"]) / ((n["Aug-24"] + n["difference"]) / 2)) end)
cpi-pct-diff