# Import file "forframer"
skt = Framer.Importer.load("imported/forframer@1x")

skt.mainScreen.clip = true
skt.mainScreen.height = 1334
skt.mainScreen.width = 750
screenWidth = screen.width * window.devicePixelRatio
screenHeight = screen.height * window.devicePixelRatio

if Utils.isPhone()
	Framer.Device.fullScreen = true
	if screenWidth > 750
		skt.mainScreen.scale = screenWidth/900
		skt.mainScreen.y = (screenHeight - 64*devicePixelRatio - skt.mainScreen.height)/2
	else
		skt.mainScreen.y = (screenHeight - skt.mainScreen.height)/2
	skt.mainScreen.x = (screenWidth - skt.mainScreen.width)/2

story2states = 0
story3states = 0

BodymovinLayer = require 'Bodymovin'

skt.flow.y = 148

story2 = new Layer
	superLayer: skt.mainScreen
	width: 750
	height: 1334
	image: "images/IMG_1489.PNG"
	opacity: 0
	scale: 0.05
	x: -310
	y: skt.flow.y - 10
	
story3 = new Layer
	superLayer: skt.mainScreen
	width: 750
	height: 1334
	image: "images/IMG_1489.PNG"
	opacity: 0
	scale: 0.05
	x: -310
	y: skt.flow.y + 505

circle1 = new BodymovinLayer
	jsonPath: "circle.json"
	superLayer: skt.circleArea3
	looping: false
	autoplay: false
	width: 100
	height: 100
	
circle3 = new BodymovinLayer
	jsonPath: "circle.json"
	superLayer: skt.circleArea2
	looping: false
	autoplay: true
	width: 100
	height: 100
	
skt.flow.draggable.enabled = true
skt.flow.draggable.speedX = 0
skt.flow.draggable.constraints = 
	x: 0
	y: -590
	width: 900
	height: 2400

story2.states.full = 
	x: 0
	y: 0
	width: 750
	height: 1334
	scale: 1
	opacity: 1
	animationOptions:
		time: 0.1
		curve:"ease-in-out"

story3.states.full = 
	x: 0
	y: 0
	width: 750
	height: 1334
	scale: 1
	opacity: 1
	animationOptions:
		time: 0.1
		curve:"ease-in-out"

skt.flow.on "change:y", ->
	if story2states == 0
		story2.y = skt.flow.y - 10
		story2.states.default.y = skt.flow.y - 10
	if story3states == 0
		story3.y = skt.flow.y + 505
		story3.states.default.y = skt.flow.y + 505
	if @.y < -100
		circle1.anim.play()

story2.on Events.Click, ->
	if story2states == 0
		story2.animate("full")
		story2states = 1
	else if story2states == 1
		story2.animate("default", time: 0.1, curve: "ease-in-out")
		story2states = 0

story3.on Events.Click, ->
	if story3states == 0
		story3.animate("full")
		story3states = 1
	else if story3states == 1
		story3.animate("default", time: 0.1, curve: "ease-in-out")
		story3states = 0
	