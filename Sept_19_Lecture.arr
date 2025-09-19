use context starter2024
fun welcome(name :: String) -> String:
  doc: "Takes a name as a string and returns a string appending welcome... + name."
  #Takes a name and appends it to the welcome string.
  "A very warm welcome to class, " + name
end
welcome("Ben")

fun area(width :: Number, height :: Number) -> Number:
  doc: "width :: Number, height :: Number; returns the Area as a number"
  width * height
where:
  area(5, 2) is 10
end
check:
 area(10, 10) is 100
end

fun tshirt(numshirts :: Number, message :: String) -> Number:
  doc: "Accepts the number of shirts into the integer variable numshirts, and the message as a string variable message. Returns the price as an Number."
  (numshirts) * (5 + (0.1 * string-length(message)))
where:
  tshirt(1,"Hi") is 5.2
end

"Your order for 100 T-Shirts stating 'Go Phillies!' will cost $" + num-to-string-digits(tshirt(100, "Go Phillies!"),2) + "."

fun c-to-f(c :: Number) -> Number:
  doc: "Accepts the celsius value as a number into the variable c and calculates then returns the value in fahrenheit as a Number."
  (c * 9/5) + 32
end
fun f-to-c(f :: Number) -> Number:
  doc: "Accepts the fahrenheit value as a number into the variable f and calculates then returns the value in celsius as a Number."
  (f - 32) * 5/9
end

check:
  c-to-f(0) is 32
  f-to-c(32) is 0
  c-to-f(20) is 68
  f-to-c(68) is 20
end


fun flag1(base, middle):
  flagbase=rectangle(160, 90, "solid", base)
  centerstripe=rectangle(160, 30, "solid", middle)
star1 = star(18, "solid", "red")
overlay-align("center","center", text("Flagtown, USA", 25, "Blue"), overlay-align("center","bottom", star1, overlay-align("center","top",star1, overlay-align("center", "center", centerstripe, flagbase))))
end

flag1("orange","yellow")