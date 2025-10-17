use context dcic2024
include csv
include data-source
#Plan: Fix the carrier column by converting all to upper case

flights = load-table: rownames :: Number, dep_time :: Number, sched_dep_time :: Number, dep_delay :: Number, arr_time :: Number, sched_arr_time :: Number, arr_delay :: Number, carrier :: String, flight :: Number, tailnum :: String, origin :: String, dest :: String, air_time :: Number, distance :: Number, hour :: Number, minute :: Number, time_hour :: String
  source: csv-table-file("flights_sample53.csv", default-options)
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

#Cleans null tail nums
cleaned-tail-nums=transform-column(flights, "tailnum", lam(tailnum :: String):
    if tailnum == "":
      "UNKNOWN"
    else:
      tailnum
  end end)

#cleans negative delays
clean-dep-delay=transform-column(cleaned-tail-nums, "dep_delay", lam(delay :: Number): if delay < 0:
  0 else: delay end end)
clean-delayed-flights=transform-column(clean-dep-delay, "arr_delay", lam(delay :: Number): if delay < 0: 0 else: delay end end)

fun trim(s :: String) -> String:
  doc: "Remove spaces from the given string."
  n = string-length(s)
  if n == 0:
    ""
  else:
    string-replace(s, " ", "")
  end
end

fun time-to-string(n :: Number) -> String block:
  doc: "Accepts number as string and returns as formatted string per specifications."
  hour = num-floor(n / 100)
  minute=num-modulo(n, 100)
  
  hour2 = if hour < 10:
    "0" + num-to-string(hour)
  else:
    num-to-string(hour)
  end
  minute2 = if minute < 10:
    "0" + num-to-string(minute)
  else:
    num-to-string(minute)
  end
  hour2 + ":" + minute2
end

#creates a key with the flight, carrier, and dep time
dedup_key = build-column(clean-delayed-flights, "dedup_key", lam(n :: Row): num-to-string(n["flight"]) + "-" + string-to-upper(trim(n["carrier"])) + "-" + time-to-string(n["dep_time"]) end)

group(dedup_key, "dedup_key")
count(dedup_key, "dedup_key")

airline-names=build-column(flights, "airline", lam(n :: Row) block:
    name = n["carrier"]
    if name == "UA":
      "United Airlines"
    else if name == "AA":
        "American Airlines"
    else if name == "B6":
          "JetBlue"
    else if name == "DL":
            "Delta Air Lines"
    else if name == "EV":
              "ExpressJet"
    else if name == "WN":
                "Southwest Airlines"
    else if name == "OO":
                  "SkyWest Airlines"
    else if name == "US":
      #This was my "home" airline before they merged with AA so I had to include it :)"
                    "US Airways"
    else:
                    "Other"
                  end
  end)
airline-names
    
#removes outlier data
clean-distance = filter-with(clean-delayed-flights, lam(n :: Row): if n["distance"] > 5000: false else: true end end)
clean-air-time = filter-with(clean-distance, lam(n :: Row): if n["air_time"] < 500: true else: false end end)

clean-air-time
freq-bar-chart(airline-names, "airline")
histogram(clean-air-time, "distance", 5)
scatter-plot(clean-air-time, "air_time", "distance")

distance = clean-air-time.get-column("distance")
var totaldistance = 0
for each(n from distance):
  totaldistance := totaldistance + n
end
avgdist = totaldistance / length(distance)
avgdist
maxdist=order-by(clean-air-time, "distance", false)
maxdist.row-n(0)["distance"]