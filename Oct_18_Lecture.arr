use context starter2024
data MobileRecord: phone(title :: String, model :: String, color :: String, storage :: Number) end
phone-1 = phone("iPhone", "13 Pro", "Blue", 64)
phone-2 = phone("iPhone", "17 Pro", "Orange", 512)

fun price_phone(phone1 :: MobileRecord) -> Number block:
  doc: "Calculates price based on storage and model"
  var price = 0
  if phone1.model == "13 Pro":
    price := 700
  else if phone1.model == "17 Pro":
    price := 1000
  end
  price := price + (phone1.storage * 2.5)
  price
end

"The phone costs $" + num-to-string(price_phone(phone-2))

data Priority:
  | low
  | medium
  | high
end
task-1-priority = low
task-2-priority = high
task-3-priority = medium

check:
  is-Priority(task-1-priority) is true
end

data Task:
  | task(description :: String, priority :: Priority)
  | note(description :: String)
end

task-1=note("test")
task-2=task("testing", high)
task-2.description

fun describe(t :: Task) -> String:
  cases (Task) t:
    | task(d, p) => 
      priority-text = cases(Priority) p:
        | low => "Low"
        | high => "High"
        | medium => "Medium"
      end
      " Task: " + d + " Priority: " + priority-text
    | note(d) => d
  end
end

describe(task-2)