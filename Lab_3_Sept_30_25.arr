use context dcic2024
include data-source
include csv
import statistics as S

fun check_leap_year(year :: Number) -> Boolean:
  doc: "Accepts a year as an integer, returns whether the input is a leap year as a boolean."
  if num-modulo(year, 400) == 0:
    true
  else if (num-modulo(year, 4) == 0) and not(num-modulo(year, 100) == 0):
    true
  else:
    false
   end
where:
  check_leap_year(2025) is false
  check_leap_year(2000) is true
  check_leap_year(1844) is true
  check_leap_year(2006) is false
end

check_leap_year(2008)
  
fun tick(seconds :: Number) -> Number:
  doc: "Accepts seconds as a interger. Returns the value increased by 1, unless input was 59, then it would return 0."
  if (seconds == 59):
    0
  else:
    seconds + 1
  end
where:
  tick(0) is 1
  tick(59) is 0
  tick(30) is 31
end

fun rock_paper_scissors(player1 :: String, player2 :: String) -> String:
  doc: "Accepts player1 and player2 as strings, checks if they are valid inputs, compares them per the rules of rock paper scissors, return winner or tie as string."
  block:
  string-tolower(player1)
  string-tolower(player2)
    if not((string-equal(player1, "rock")) or ((string-equal(player1, "paper"))) or (string-equal(player1, "scissors")) or (string-equal(player2, "rock")) or (string-equal(player2, "paper")) or (string-equal(player2, "scissors"))):
    "invalid choice"
      
  else if (player1 == player2):
    "tie"
  else if (((player1 == "rock") and (player2 == "scissors")) or ((player1 == "paper") and (player2 == "rock")) or ((player1 == "scissors") and (player2 == "paper"))):
    "player 1"
  else:
    "player 2"
   end
  end
  where:
  rock_paper_scissors("a", "b") is "invalid choice"
  rock_paper_scissors("rock", "rock") is "tie"
  rock_paper_scissors("rock", "paper") is "player 2"
  rock_paper_scissors("paper", "rock") is "player 1"
end

  
planet = table: Planet :: String, Distance :: Number
  row: "Mercury", 0.39
  row: "Venus", 0.72
  row: "Earth", 1
  row: "Mars", 1.52
  row: "Jupiter", 5.2
  row: "Saturn", 9.54
  row: "Uranus", 19.2
  row: "Neptune", 30.06
end
mars = planet.row-n(3)
mars["Distance"]
something = load-table: Year :: Number, Day :: Number, Month :: String, Rate :: Number
  source: csv-table-file("boe_rates.csv", default-options)
  sanitize Year using num-sanitizer
  sanitize Day using num-sanitizer
  sanitize Rate using num-sanitizer
end

something.length()
rateColumn=something.get-column("Rate")
S.median(rateColumn)
S.mode-smallest(rateColumn)
order-by(something, "Rate", false)
order-by(something, "Rate", true)