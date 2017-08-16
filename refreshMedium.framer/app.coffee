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
h = false
feedOriginY = skt.feed.y

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


skt.dragArea.draggable.enabled = true
skt.dragArea.draggable.speedX = 0
skt.dragArea.draggable.constraints = 
	x: 0
	y: -1198
	width: 1000
	height: 4000
	

skt.icon.opacity = 0
skt.notice.opacity = 0

feedback = new Animation skt.dragArea,
	y: 2
	options:
		time: 0.5
		curve: Spring(damping: 1)

skt.tipVisualArea.states.vanish =
	width: 0
	x: 375
	y: 130

skt.tipVisualArea.states.show =
	width: 750
	x: 0
	options:
		time: 0.3
		curve: "ease-in-out"

opDown = new Animation skt.tipVisualArea,
	opacity: 0
	y: 56
	options:
		time: 0.5
		curve: "ease-in-out"

skt.tip.states.vanish =
	x: -375

skt.tip.states.show =
	x: 0
	options:
		time: 0.3
		curve: "ease-in-out"

skt.tipVisualArea.clip = true
skt.tipVisualArea.opacity = 0

skt.feed.states.down = 
	y: 116
	options:
		time: 0.5
		curve: "ease-in-out"
		
skt.feed.states.mid = 
	y: 72
	options:
		time: 0.5
		curve: "ease-in-out"

skt.feed.states.normal = 
	y: 3
	options:
		time: 0.5
		curve: "ease-in-out"

skt.loading.opacity = 0

skt.tipVisualArea.stateSwitch("vanish")
skt.tip.stateSwitch("vanish")

skt.dragArea.on "change:y", ->
	if @.y < -1000 && i == false
		skt.notice.opacity = 0
		bodymovinIconP1.anim.play()
		i = true
		Utils.delay 1, ->
			skt.notice.opacity = 1
			
skt.jsonArea.on Events.Click, ->
	if i
		skt.notice.opacity = 0
		bodymovinIconP2.opacity = 1
		bodymovinIconP1.opacity = 0
		bodymovinIconP2.anim.play()
		skt.dragArea.draggable.enabled = false
		feedback.start()
		skt.feed.animate("down")
		skt.loading.opacity = 1
		Utils.delay 1, ->
			skt.loading.opacity = 0
			skt.tipVisualArea.opacity = 1
			skt.tipVisualArea.animate("show")
			skt.tip.animate("show")
			skt.feed.animate("mid")
		Utils.delay 3, ->
			opDown.start()
			skt.feed.animate("normal")

feedback.on Events.AnimationEnd, ->
	i = false
	bodymovinIconP2.opacity = 0
	bodymovinIconP1.opacity = 1
	bodymovinIconP1.anim.goToAndStop(0)
	bodymovinIconP2.anim.goToAndStop(0)
	skt.dragArea.draggable.enabled = true

opDown.on Events.AnimationEnd, ->
	skt.tipVisualArea.stateSwitch("vanish")
	skt.tip.stateSwitch("vanish")