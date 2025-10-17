use context dcic2024
include csv
include data-source

#imports flights.csv into pyret and sanitizes columns of type Number
flights = load-table: rownames :: Number, dep_time :: Number, sched_dep_time :: Number, dep_delay :: Number, arr_time :: Number, sched_arr_time :: Number, arr_delay :: Number, carrier :: String, flight :: Number, tailnum :: String, origin :: String, dest :: String, air_time :: Number, distance :: Number, hour :: Number, minute :: Number, time_hour :: String
  source: csv-table-file("flights.csv", default-options)
  sanitize rownames using num-sanitizer
  sanitize dep_time using num-sanitizer
  sanitize sched_dep_time using num-sanitizer
  sanitize dep_delay using num-sanitizer
  sanitize arr_time using num-sanitizer
  sanitize sched_arr_time using num-sanitizer
  sanitize arr_delay using num-sanitizer
  sanitize flight using num-sanitizer
  sanitize air_time using num-sanitizer
  sanitize distance using num-sanitizer
  sanitize hour using num-sanitizer
  sanitize minute using num-sanitizer
end

fun is_long_flight(row :: Row) -> Boolean:
  doc: "Accepts a row, and checks if the flight in that row is longer than 1,500 miles, returning the answer as a boolean."
  row["distance"] >= 1500
where: 
  is_long_flight(flights.row-n(0)) is false
  is_long_flight(flights.row-n(36)) is true
end
#creates a new table called long-flights that only includes flights over 1,500 miles. Those poor passengers!
long-flights=filter-with(flights, lam(row :: Row): is_long_flight(row) end)
#creates a new table with the same values as long-flights, but ordered by longest to shortest based on air time.
ordered-long-flights=order-by(long-flights, "air_time", false)
#identifies the longest domestic flight from New York
ordered-long-flights.row-n(0)["carrier"]
ordered-long-flights.row-n(0)["origin"]
ordered-long-flights.row-n(0)["dest"]

fun is_delayed_dep(row :: Row) -> Boolean:
  doc: "Checks if a flight was delayed by more than 30 mins."
  row["dep_delay"] > 29
where:
  is_delayed_dep(flights.row-n(52)) is false
  is_delayed_dep(flights.row-n(104)) is true
end

fun is_morning_flight(row :: Row) -> Boolean:
  doc: "Checks if flight is scheduled to leave before noon."
  row["sched_dep_time"] < 1200
end

#creates a table of flights delayed by ≥ 30 mins
delayed-flights=filter-with(flights, lam(row :: Row): is_delayed_dep(row) end)
#filters out non morning flights from delayed-flights
morning-delayed-flights=filter-with(delayed-flights, lam(row :: Row): is_morning_flight(row) end)
#orders morning-delayed-flights starting at the worst delay
worst-morning-delays=order-by(morning-delayed-flights, "dep_delay", false)
worst-morning-delays.row-n(0)["flight"]
worst-morning-delays.row-n(0)["origin"]
worst-morning-delays.row-n(0)["dep_delay"]

#clean early flights by replacing negative delays with 0
clean-dep-delay=transform-column(flights, "dep_delay", lam(delay :: Number): if delay < 0:
  0 else: delay end end)
clean-delayed-flights=transform-column(clean-dep-delay, "arr_delay", lam(delay :: Number): if delay < 0: 0 else: delay end end)
#adds speed to table
flights-with-speed=build-column(flights, "effective_speed", lam(row :: Row): if row["air_time"] < 0: 0 else: row["distance"] / (row["air_time"] / 60)end end)
fastest-flights=order-by(flights-with-speed, "effective_speed", false)
fastest-flights.row-n(0)["carrier"]
fastest-flights.row-n(0)["origin"]
fastest-flights.row-n(0)["dest"]

fun apply-arrival-discount(nycflights :: Table) -> Table:
  doc: "reduces arrival delay by 20% when delayed between 0 and 45 minutes."
  transform-column(nycflights, "arr_delay", lam(r :: Number): if (r >= 0) and (r <= 45): r * 0.8 else: r end end)
  where:
  apply-arrival-discount(table: arr_delay :: Number
  row: -10
  row: 0 
  row: 30 
  row: 60 end) is (table: arr_delay :: Number row: -10 row: 0 row:24 row: 60 end)
end
apply-arrival-discount(flights)

fun calc_score(dep_delay :: Number, arr_delay :: Number, air_time :: Number) -> Number:
    doc: "Calculates the score for the flight based on the specifications."

 
    score = 100 - (dep_delay - arr_delay) - (air_time / 30)
  if score == 0:
    0
  else:
    score
  end end 
#uses already cleaned data to calculate the score per specifications
on-time-score=build-column(clean-delayed-flights, "on_time_score", lam(r :: Row): calc_score(r["dep_delay"], r["arr_delay"], r["air_time"]) end)
most-on-time=order-by(on-time-score, "on_time_score", false)
most-on-time-tiebreak=order-by(most-on-time, "distance", true)
most-on-time-tiebreak.row-n(0)["carrier"]
most-on-time-tiebreak.row-n(0)["flight"]
most-on-time-tiebreak.row-n(0)["origin"]
most-on-time-tiebreak.row-n(0)["dest"]
most-on-time-tiebreak.row-n(1)["carrier"]
most-on-time-tiebreak.row-n(1)["flight"]
most-on-time-tiebreak.row-n(1)["origin"]
most-on-time-tiebreak.row-n(1)["dest"]
#PHL is my home airport :) We do have trains to New York though...