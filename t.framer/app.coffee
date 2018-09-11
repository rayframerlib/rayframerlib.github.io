holder = new Layer
	visible: false

Framer.Defaults.Animation =
	time: 0.4
	curve: Spring(damping: 1)
area.draggable.enabled = true
area.draggable.constraints = area.frame
menu.opacity = 0

area.on Events.DragStart, ->
	menu.animate
		opacity: 1
	

area.on Events.Drag, (event)->
	y = event.pointY
	area.backgroundColor = "red"
	if 0 < y < Screen.height / 3
		holder.x = 1
	else if Screen.height / 3 < y < Screen.height * 2 / 3
		holder.x = 2
	else if Screen.height * 2 / 3 < y < Screen.height
		holder.x = 3

area.on Events.DragEnd, ->
	area.backgroundColor = "#00AAFF"
	menu.animate
		opacity: 0
	holder.x = 0

f1.states.active = 
	backgroundColor: "red"
	scale: 1.2
	
f2.states.active = 
	backgroundColor: "red"
	scale: 1.2

f3.states.active = 
	backgroundColor: "red"
	scale: 1.2

holder.on "change:x", ->
	switch @.x
		when 1
			f1.animate("active") 
			f2.animate("default")
			f3.animate("default")
		when 2
			f1.animate("default") 
			f2.animate("active")
			f3.animate("default")
		when 3
			f1.animate("default") 
			f2.animate("default")
			f3.animate("active")
		when 0
			f1.animate("default") 
			f2.animate("default")
			f3.animate("default")
	

