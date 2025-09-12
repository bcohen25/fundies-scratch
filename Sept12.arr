use context starter2024
"hello world"
string-toupper("hello cs2000")
c=circle(15, "solid", "blue")
r=rectangle(50, 30, "solid", "yellow")
c
r
overlay-align("center", "top", c, r)
green=rectangle(50, 60, "solid", "green")
purple=rectangle(50, 30, "solid", "purple")
overlay-align("center", "bottom", purple, green)
red=rectangle(100, 20,"solid","red")
red
rotate(180, red)
stopsign=regular-polygon(50,8,"solid","red")
overlay-align("center","center", text("STOP",40,"white"),stopsign)
redcircle=circle(50,"solid","red")
whiterect=rectangle(90, 20, "solid", "white")
overlay(whiterect, redcircle)