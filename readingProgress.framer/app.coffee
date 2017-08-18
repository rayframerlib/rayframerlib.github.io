# Import file "readingProgress" (sizes and positions are scaled 1:2)
skt = Framer.Importer.load("imported/readingProgress@2x")
skt.FEED_Copy.backgroundColor = "transparent"

prog = 0
temp = skt.feed.y

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

saver = new Layer
	superLayer: skt.mainScreen
	visible: false
	x: prog

progressBg = new Layer
	superLayer: skt.mainScreen
	x: 750 - 76 - 24
	y: 1334 - 76 - 90 - 24
	width: 76
	height: 76
	opacity: 0
	borderRadius: 36
	backgroundColor: "rgba(255, 255, 255, 0.9)"
	borderWidth: 1
	borderColor: "rgba(99, 99, 99, 0.5)"

progress = new TextLayer
	superLayer: progressBg
	text: "#{prog}%"
	fontSize: 20
	color: "#636363"
	width: 72
	textAlign: "center"

finishText = new TextLayer
	superLayer: progressBg
	text: "本次更新已经阅读完"
	fontSize: 24
	color: "#636363"
	width: 272
	textAlign: "center"
	opacity: 0

reset = new Layer
	superLayer: skt.mainScreen
	size: 88
	html: "Reset"
	color: "#888"
	visible: false

skt.guide.opacity = 0

reset.centerY()
finishText.centerY()
progress.center()

skt.feed.draggable.enabled = true
skt.feed.draggable.speedX = 0
skt.feed.draggable.constraints = 
	x: 0
	y: -1206
	width: 1000
	height: 3800

progressBg.states.long = 
	width: 272
	x: 454
	animationOptions:
		curve: "ease-in-out"
		time: 0.3

progress.states.vanish =
	opacity: 0
	animationOptions:
		curve: "linear"
		time: 0.15

finishText.states.show = 
	opacity: 1
	animationOptions:
		curve: "linear"
		delay: 0.2
		time: 0.1

progressBg.states.show = 
	opacity: 1
	animationOptions:
		curve: "linear"
		time: 0.2

progressBg.states.vanish = 
	opacity: 0
	animationOptions:
		curve: "linear"
		time: 0.4

skt.guide.states.vanish = 
	opacity: 0
	animationOptions:
		curve: "linear"
		time: 0.2

skt.guide.states.show = 
	opacity: 1
	animationOptions:
		curve: "linear"
		time: 0.2

skt.feed.on "change:y", ->
	if skt.feed.y < temp
		if skt.feed.y >= -1207
			temp = skt.feed.y
		else
			temp = -1207
	prog = Math.floor(Utils.modulate(temp, [-1207, 148], [100, 0]), true)
	progress.text = "#{prog}%"
	saver.x = prog


saver.on "change:x", ->
	if @.x == 100
		Utils.delay 0.2, ->
			progressBg.animate("long")
			progress.animate("vanish")
			finishText.animate("show")
		Utils.delay 2, ->
			progressBg.animate("vanish")
		Utils.delay 2.5, ->
			reset.visible = true

skt.feed.on Events.DragStart, ->
	if prog ==0
		skt.guide.animate("show")
		Utils.delay 3, ->
			skt.guide.animate("vanish")
	if prog != 100
		progressBg.animate("show")

skt.feed.on Events.DragAnimationEnd, ->
	if prog != 100
		progressBg.animate("vanish")

reset.on Events.Click, ->
	reset.visible = false
	skt.feed.y = 148
	temp = 148
	prog = 0
	progress.stateSwitch("default")
	finishText.stateSwitch("default")
	progressBg.stateSwitch("default")
	progress.text = "0%"



