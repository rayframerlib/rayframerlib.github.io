skt = Framer.Importer.load("imported/forFramer@1x")

Framer.Extras.Hints.disable()

skt.sc.clip = true
skt.sc.height = 1334
skt.sc.width = 750
screenWidth = screen.width * window.devicePixelRatio
screenHeight = screen.height * window.devicePixelRatio

if Utils.isPhone()
	Framer.Device.fullScreen = true
	if screenWidth > 750
		skt.sc.scale = screenWidth/900
		skt.sc.y = (screenHeight - 64*devicePixelRatio - skt.sc.height)/2
	else
		skt.sc.y = (screenHeight - skt.sc.height)/2
	skt.sc.x = (screenWidth - skt.sc.width)/2

skt.hot.opacity = 0

skt.groupMenu.y = -277
skt.groupMenu.opacity = 0

skt.sc.backgroundColor = "#f2f2f2"
skt.sc.clip = true

skt.tabColorPad.height = 6

skt.favGroup.scale = 1.058

holder = new Layer
	x:0
	y:0
	width: 0
	height: 0

tabMark = new Layer
	superLayer: skt.tab
	width: 48
	height: 6
	borderRadius: 3
	x: 12
	y: 53
	clip: true
	
skt.tabColorPad.superLayer = tabMark
skt.tabColorPad.y = 0
skt.tabColorPad.x = 0

page = new PageComponent
	width: 750
	height: 1334
	scrollVertical: false

page.superLayer = skt.sc
page.placeBehind(skt.groupMenu)
page.content.draggable.overdrag = false
page.animationOptions = 
	curve: Spring(damping: 1)
	time: 0.5

mainFeed = new Layer
	width: page.width
	height: page.height
	parent: page.content
	backgroundColor: "transparent"
	
hotFeed = new Layer
	width: page.width
	height: page.height
	backgroundColor: "transparent"


page.addPage(hotFeed, "right")

skt.mainFeedContent.superLayer = mainFeed

skt.mainHotContent.superLayer = hotFeed

markToMain = new Animation
	layer: tabMark
	properties: {x: 12}
	time: 0.25
	curve: "ease"

colorToMain = new Animation
	layer: skt.tabColorPad
	properties: {x: 0}
	time: 0.25
	curve: "ease"

markToHot = new Animation
	layer: tabMark
	properties: {x: 169}
	time: 0.25
	curve: "ease"

colorToHot = new Animation
	layer: skt.tabColorPad
	properties: {x: -152}
	time: 0.25
	curve: "ease"

skt.favGroup.states.bigger =
	scale: 1.058
	animationOptions:
		time: 0.25
		curve: "ease"

skt.favGroup.states.normal =
	scale: 1
	animationOptions:
		time: 0.25
		curve: "ease"
		
skt.hotGroup.states.bigger =
	scale: 1.058
	animationOptions:
		time: 0.25
		curve: "ease"

skt.hotGroup.states.normal =
	scale: 1
	animationOptions:
		time: 0.25
		curve: "ease"
		
skt.hot.states.show =
	opacity: 1
	animationOptions:
		time: 0.25
		curve: "ease"

skt.hot.states.vanish =
	opacity: 0
	animationOptions:
		time: 0.25
		curve: "ease"

skt.fav.states.show =
	opacity: 1
	animationOptions:
		time: 0.25
		curve: "ease"

skt.fav.states.vanish =
	opacity: 0
	animationOptions:
		time: 0.25
		curve: "ease"

skt.fav.states.stateOff =
	opacity: 0

skt.hot.states.stateOn = 
	opacity: 1


markScrollControl = ->
	if page.content.x <= 0 && page.content.x >= -375
		tabMark.width = Utils.modulate(page.content.x, [0, -375], [48, 204])
		tabMark.x = 12
		skt.tabColorPad.x = 0
		skt.fav.opacity = Utils.modulate(page.content.x, [0, -375], [1, 0.5])
		skt.hot.opacity = Utils.modulate(page.content.x, [0, -375], [0, 0.5])
		skt.hotGroup.scale = Utils.modulate(page.content.x, [0, -375], [1, 1.029])
		skt.favGroup.scale = Utils.modulate(page.content.x, [0, -375], [1.058, 1.029])
		
	else if page.content.x < -375 && page.content.x >= -750
		tabMark.width = Utils.modulate(page.content.x, [-375, -750], [204, 48])
		tabMark.x = Utils.modulate(page.content.x, [-375, -750], [12, 169])
		skt.tabColorPad.x = Utils.modulate(page.content.x, [-375, -750], [0, -142])
		skt.fav.opacity = Utils.modulate(page.content.x, [-375, -750], [0.5, 0])
		skt.hot.opacity = Utils.modulate(page.content.x, [-375, -750], [0.5, 1])
		skt.hotGroup.scale = Utils.modulate(page.content.x, [-375, -750], [1.029, 1.068])
		skt.favGroup.scale = Utils.modulate(page.content.x, [-375, -750], [1.029, 1])

skt.fav.on Events.Click, ->
	page.content.off "change:x"
	page.snapToPage(mainFeed,false)
	markToMain.start()
	colorToMain.start()
	skt.fav.animate("show")
	skt.favGroup.animate("bigger")
	skt.hot.animate("vanish")
	skt.hotGroup.animate("normal")

skt.hot.on Events.Click, ->
	page.content.off "change:x"
	page.snapToPage(hotFeed,false)
	markToHot.start()
	colorToHot.start()
	skt.hot.animate("show")
	skt.hotGroup.animate("bigger")
	skt.fav.animate("vanish")
	skt.favGroup.animate("normal")

page.content.on "change:x", -> markScrollControl()
# page.content.on Events.AnimationEnd, ->
# 	page.content.on "change:x", -> markScrollControl()
markToMain.on Events.AnimationEnd, -> 
	page.content.on "change:x", -> markScrollControl()
markToHot.on Events.AnimationEnd, ->
	page.content.on "change:x", -> markScrollControl()