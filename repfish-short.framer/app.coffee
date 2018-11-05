marker = new Layer
	x: 0
	visible: false

Framer.Defaults.Animation =
	curve: Spring(damping: 1)
	time: 0.4

mainScreen.width = 375
mainScreen.height = 667
mainScreen.clip = true
mainScreen.center()

feedContent.draggable.enabled = true
feedContent.draggable.speedX = 0
feedContent.draggable.constraints = {
	x: 0
	y: -1356
	width: 375
	height: 3500
}

redExtended.opacity = 0

redGroup.states.extend =
	scale: 2
	x: redGroup.x - redGroup.width / 2
	y: redGroup.y - redGroup.height / 2

redButton.states.extend = 
	opacity: 0

redExtended.states.extend =
	opacity: 1

redPage.states.show = 
	x: 0
	options: 
		curve: Spring(damping: 1)
		time: 0.5

extend = ()->
	redGroup.animate("extend")
	redButton.animate("extend")
	redExtended.animate("extend")

normal = ()->
	redGroup.animate("default")
	redButton.animate("default")
	redExtended.animate("default")

extend()

feedContent.on "change:y", ->
	if this.y >= 64
		marker.x = 0
	else
		marker.x = 1

marker.on "change:x", ->
	if this.x == 1
		normal()
	if this.x == 0 
		extend()

# redButton.on Events.Click, ->
# 	extend()
# 	Utils.delay 0.4 , ->
# 		marker.x = 0

redGroup.on Events.Click, ->
	redPage.animate("show")

redPage.on Events.Click, ->
	redPage.stateSwitch("default")
	