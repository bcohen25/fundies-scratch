use context dcic2024
include data-source
include csv
orders = table: time, amount
  row: "08:00", 10.50
  row: "09:30", 5.75
  row: "10:15", 8.00
  row: "11:00", 3.95
  row: "14:00", 4.95
  row: "16:45", 7.96
end

fun is-high-value(o :: Row) -> Boolean:
  o["amount"] >= 8.00
where:
  is-high-value(orders.row-n(2)) is true
  is-high-value(orders.row-n(3)) is false
end
new-high-orders = filter-with(orders, is-high-value)
filter-with(orders, lam(o): o["amount"] >= 8.0 end)
order-by(orders, "amount", true)


fun is-morning(o :: Row) -> Boolean:
  doc: "Takes a row and checks if the time coloumn is before 12:00 (thus checking if it's in the morning)"
  o["time"] < "12:00"
where:
  is-morning(orders.row-n(0)) is true
  is-morning(orders.row-n(3)) is true
  is-morning(orders.row-n(4)) is false
end

morning-only = filter-with(orders, is-morning)
filter-with(orders, lam(o):o["time"] < "12:00" end)
last-to-first=order-by(orders, "time", false)
last-to-first.row-n(0)["amount"]

pictures = load-table: Location :: String, Subject :: String, Date :: String
  source: csv-table-url("https://raw.githubusercontent.com/neu-pdi/cs2000-public-resources/refs/heads/main/static/support/7-photos.csv", default-options)
end
filter-with(pictures, lam(a):a["Subject"] == "Forest" end)
order-by(pictures, "Date", false).row-n(0)["Location"]
order-by(count(pictures, "Location"), "count", false)

freq-bar-chart(pictures, "Location")
pictures
