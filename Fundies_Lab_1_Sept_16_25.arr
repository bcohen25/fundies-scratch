use context starter2024
include image
#T-Shirt Shop
"5 T-Shirts are £" + tostring(((5 * 12) + 3))
"7 T-Shirts are £" + tostring(((7 * 12) + 3))

#Posters
perimeter= 2 * (420 + 594)
"The poster costs £" + num-to-string-digits(((0.10 * perimeter)), 2)

#Saving a tagline
"Designs for everyone!"
#Restoring the quotation mark fixes the error. Without it, pyret doesn't know it's a string, and tries to interpret it as a variable, but errors out since we didn't assign any values, since we want it to be a string!

#Color Inventory
"red" + "blue"
tostring(1) + "blue"
#you can only append two statements of the same type together, so for this to work you have to convert the integer to a string.

#Traffic Light
frame1 = rectangle(40, 120, "solid", "black")
red = circle(20, "outline", "red")
yellow = circle(20, "outline", "yellow")
green = circle(20, "solid", "green")
trafficlight=overlay-align("center", "bottom", above(red, above( yellow, green)), frame1)
trafficlight
pole = rectangle(20, 100, "solid", "black")
above(trafficlight, pole)

#| Goal: A rectangle with width 50 and height 20, solid black

rectangle(50, "solid", 20, "black")
   
   The error was in the formatting, rectangle expects the length, then the width, whether it's solid or outline, then then color, and it must be in that order. |#

rectangle(50, 20, "solid", "black")

#|circle(30, solid, "red")
   The issue here is that solid is not in quotation marks, so pyret doesn't know to interpret it as a string. |#
      
circle(30, "solid", "red")

#flag
flagbase=rectangle(160, 90, "solid", "blue")
centerstripe=rectangle(160, 30, "solid", "green")
star1 = star(18, "solid", "red")
overlay-align("center","center", text("Flagtown, USA", 25, "Blue"), overlay-align("center","bottom", star1, overlay-align("center","top",star1, overlay-align("center", "center", centerstripe, flagbase))))
#would there have been a better way to implement this?