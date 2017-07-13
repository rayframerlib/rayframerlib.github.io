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

i = false

BodymovinLayer = require 'Bodymovin'

bodymovinIconP1 = new BodymovinLayer
	superLayer: skt.jsonArea
	jsonPath: "data1.json"
	width: 80
	height: 80
	looping: false
	autoplay: false
	renderer: "canvas"

bodymovinIconP2 = new BodymovinLayer
	superLayer: skt.jsonArea
	jsonPath: "data2.json"
	width: 80
	height: 80
	looping: false
	autoplay: false
	renderer: "canvas"
	opacity: 0


skt.feed.draggable.enabled = true
skt.feed.draggable.speedX = 0
skt.feed.draggable.constraints = 
	x: 0
	y: -1848
	width: 1000
	height: 5000

skt.icon.opacity = 0
skt.notice.opacity = 0

feedback = new Animation skt.feed,
	y: 151
	options:
		time: 0.5
		curve: Spring(damping: 1)
	

skt.feed.on "change:y", ->
	if @.y < -1000 && i == false
		bodymovinIconP1.anim.play()
		i = true
		Utils.delay 5/6, ->
			skt.notice.opacity = 1

skt.jsonArea.on Events.Click, ->
	if i
		skt.notice.opacity = 0
		bodymovinIconP2.opacity = 1
		bodymovinIconP1.opacity = 0
		bodymovinIconP2.anim.play()
		skt.feed.draggable.enabled = false
		feedback.start()

feedback.on Events.AnimationEnd, ->
	i = false
	bodymovinIconP2.opacity = 0
	bodymovinIconP1.opacity = 1
	bodymovinIconP1.anim.goToAndStop(0)
	bodymovinIconP2.anim.goToAndStop(0)
	skt.feed.draggable.enabled = true