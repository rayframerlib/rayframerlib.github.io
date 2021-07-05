Framer.Extras.Hints.disable()

mainScreen.width = 375
mainScreen.height = 812

mainScreen.clip = true
mainScreen.centerY()
mainScreen.centerX()

videoLayer = new VideoLayer
	superLayer: mainScreen
	width: 410
	height: 729
	video: "images/v0d00fg10000c2lh4i8uir6pcjfu5sr0.mp4"

videoLayer.centerX()
videoLayer.placeBehind(bar)

videoLayer.player.play()
videoLayer.player.loop = false

covers.draggable.enabled = true
covers.draggable.speedY = false

covers.draggable.constraints = 
	{
		x: list.width - covers.width - 40
		y: 0
		width: 2 * covers.width - list.width + 52
	}


bar.states.normal = 
	backgroundColor: 'rgba(41, 41, 41, 0.34)'
	height: 40
	options: 
		time: 0.25
		curve: 'ease-in-out'

bar.states.extend = 
	backgroundColor: 'rgba(0, 0, 0, 0.9)'
	height: 233
	options: 
		time: 0.25
		curve: 'ease-in-out'

text.states.normal = 
	opacity: 1
	y: text.y
	options: 
		time: 0.25
		curve: 'ease-in-out'

text.states.extend = 
	opacity: 0
	y: text.y - 50
	options: 
		time: 0.25
		curve: 'ease-in-out'

cancelArrow.states.normal = 
	opacity: 0
	options: 
		time: 0.25
		curve: 'ease-in-out'

cancelArrow.states.extend = 
	opacity: 1
	options: 
		time: 0.25
		curve: 'ease-in-out'
		
barArrow.states.normal = 
	opacity: 1
	options: 
		time: 0.25
		curve: 'ease-in-out'

barArrow.states.extend = 
	opacity: 0
	options: 
		time: 0.25
		curve: 'ease-in-out'

list.states.normal = 
	opacity: 0
	options: 
		time: 0.25
		curve: 'ease-in-out'

list.states.extend = 
	opacity: 1
	options: 
		time: 0.25
		curve: 'ease-in-out'

extend = () ->
	bar.animate('extend')
	text.animate('extend')
	cancelArrow.animate('extend')
	barArrow.animate('extend')
	list.animate('extend')

normal = () ->
	bar.animate('normal')
	text.animate('normal')
	cancelArrow.animate('normal')
	barArrow.animate('normal')
	list.animate('normal')

bar.on Events.Click, ->
	if bar.states.current.name != 'extend'
		Utils.delay 0.01, ->
			extend()

cancelArrow.on Events.Click, ->
	if bar.states.current.name == 'extend'
		Utils.delay 0.01, ->
			normal()
		
Events.wrap(videoLayer.player).on "pause", ->
	videoLayer.player.play()
	extend()
	Utils.delay 7, ->
		normal()