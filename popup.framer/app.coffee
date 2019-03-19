mainScreen.y = 0
mainScreen.centerX()
mainScreen.clip = true
mainScreen.width = 414
mainScreen.height = 736

Framer.Defaults.Animation = 
	time: 0.5
	curve: Spring(damping: 1)

content.draggable.enabled = true
content.draggable.constraints = 
	x: 0
	y: mainScreen.height - bottom.height - content.height
	height: content.height * 2 - (mainScreen.height - (header.height + bottom.height))
	width: 414
content.draggable.speedX = 0

marker = new Layer
	visible: false
	x: 0

content.on "change:y", ->
	if this.y >= -564
		marker.x = 0
	else
		marker.x = 1

marker.on "change:x", ->
	if marker.x == 1
		pop.animate("up")

pop.states.up =
	y: pop.y
	opacity: 1

pop.states.down = 
	y: bottom.y
	opacity:  0

pop.stateSwitch("down")

cancel.on Events.Click, ->
	pop.animate("down")


