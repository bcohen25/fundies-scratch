use context starter2024
orange-triangle = triangle(35,"solid","orange")
orange-triangle

side_length=10
color = "red"
#we are back to square 1
square1 = square(side_length, "solid", color)
square1
square(10, "solid", "red")
shadow side_length=11
yellow_circle=circle(10, "solid", "yellow")
black_rect=rectangle(100, 50, "solid", "black")
overlay(yellow_circle, black_rect)
twocircles = overlay-xy(yellow_circle, 30,0,yellow_circle)
above(twocircles ,black_rect)