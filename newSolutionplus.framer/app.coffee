# Import file "newsolution" (sizes and positions are scaled 1:2)
skt = Framer.Importer.load("imported/newsolution@2x")

skt.MainScreen.clip = true
skt.MainScreen.height = 1334
skt.MainScreen.width = 750
screenWidth = screen.width * window.devicePixelRatio
screenHeight = screen.height * window.devicePixelRatio

if Utils.isPhone()
	Framer.Device.fullScreen = true
	if screenWidth > 750
		skt.MainScreen.scale = screenWidth/900
		skt.MainScreen.y = (screenHeight - 64*devicePixelRatio - skt.MainScreen.height)/2
	else
		skt.MainScreen.y = (screenHeight - skt.MainScreen.height)/2
	skt.MainScreen.x = (screenWidth - skt.MainScreen.width)/2

skt.lineContainer.height = 144
skt.lineContainer.clip = true

maskOY = skt.lines.y
time = 0

skt.feed.draggable = true
skt.feed.draggable.speedX = 0
skt.feed.draggable.constraints =
	x: 0
	y: 148
	width: 0
	height: 1000
	

animShort = 
	curve: "liner"
	time: 2.5

animLong = 
	curve: "liner"
	time: 5

skt.lines.states.one = 
	y: maskOY - 48
	animationOptions: animShort

skt.lines.states.two = 
	y: maskOY - 48 - 48
	animationOptions: animShort
	
skt.lines.states.three = 
	y: maskOY - 48 - 48 - 96
	animationOptions: animLong

skt.lines.animate("one")
skt.lines.on Events.AnimationEnd, ->
	if skt.lines.states.current.name == "one"
		Utils.delay time, ->
			skt.lines.animate("two")
	if skt.lines.states.current.name == "two"
		Utils.delay time, ->
			skt.lines.animate("three")
	if skt.lines.states.current.name == "three"
		Utils.delay time, ->
			skt.lines.stateSwitch("default")
			skt.lines.animate("one")