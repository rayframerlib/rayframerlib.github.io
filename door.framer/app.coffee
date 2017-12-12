# Import file "forframer"
skt = Framer.Importer.load("imported/forframer@1x")
#整体布局初始化

skt.mainScreen.frame = {width: 750, height: 1334}
skt.mainScreen.clip = true
skt.mainScreen.scale = window.devicePixelRatio / 2
skt.mainScreen.center()

animationOp = 
	time: 0.6
	curve: "ease"

init = () ->
	skt.secondFloor.frame = {x: 0, y: 0, width: 750, height: 1334}
	skt.bgColor.frame = {x: 0, y: 0}
	skt.planet.frame = {x: 0, y: 280}
	skt.stars.centerX()
	skt.trail.centerX()
	skt.packs.centerX()
	skt.main.centerX()
	skt.main.y = 250
	
	skt.navi.frame = {x: 0, y: 0}
	skt.dragArea.frame = {x: 0, y: 128}
	skt.stat.frame = {x: 12, y: 6}
	skt.h5Page.frame = {x: 0, y: 0}
	
	skt.texts.x = 304
	skt.texts.y = skt.dragArea.x - 10
	skt.refreshed.opacity = 0
	skt.getPack.opacity = 0
	skt.whiteStat.opacity = 0
	skt.blackStat.opacity = 1
	skt.h5Page.opacity = 0

	skt.main.scale = 0.56
	skt.main.y = 720
	skt.stars.y = 800
	skt.packs.scale = 0
	skt.packs.y = -300
	skt.trail.scale = 0
	skt.trail.y = -400
	
	skt.h5Page.ignoreEvents = true
	
init()

packGo = new Animation skt.packs,
	scale: 1
	y: 227
	options:animationOp

trailGo = new Animation skt.trail,
	scale: 1
	y: 164
	options:animationOp

mainUp = new Animation skt.main,
	scale: 1
	y: 250
	options:animationOp

starsUp = new Animation skt.stars,
	y: 0
	options:animationOp

planetUP = new Animation skt.planet,
	y: 200
	options:animationOp

	
#Feed 拖动初始化
skt.dragArea.draggable.speedX = 0
skt.dragArea.draggable.constraints ={x:0,y: 128}
	
skt.dragArea.on "change:y", ->
	skt.secondFloor.y = skt.dragArea.y - 1334
	skt.texts.y = skt.dragArea.y - 78
	if skt.dragArea.y < 250
		skt.arrow.animate
			properties: 
				rotationZ: 0
			time: 0.1
		skt.refreshed.opacity = 0
		skt.getPack.opacity = 0
		skt.refresh.opacity = 1
	
	else if skt.dragArea.y < 500 && skt.dragArea.y >= 250
		skt.arrow.animate
			properties: 
				rotationZ: 180
			time: 0.1
		skt.refresh.opacity = 0
		skt.refreshed.opacity = 1
		skt.getPack.opacity = 0
		skt.arrow.opacity = 1
	
	else if skt.dragArea.y >= 500
		skt.refresh.opacity = 0
		skt.refreshed.opacity = 0
		skt.getPack.opacity = 1
		skt.arrow.opacity = 0


#overDrag 后响应
feedDown = new Animation
	layer: skt.dragArea
	properties: {y: 1334}
	time: 0.35
	curve: "ease-out"
	
naviOut = new Animation
	layer: skt.navi
	properties: {y: -132}
	time: 0.3

textsOut = new Animation
	layer: skt.getPack
	properties: 
		opacity: 0
	time: 0.1

skt.dragArea.on Events.DragEnd, ->
	if skt.dragArea.y > 500
		skt.dragArea.draggable.enabled = false
		feedDown.start()

feedDown.on Events.AnimationEnd, ->
	skt.blackStat.opacity = 0
	skt.whiteStat.opacity = 1
	naviOut.start()
	textsOut.start()
	mainUp.start()
	packGo.start()
	starsUp.start()
	trailGo.start()
	planetUP.start()

skt.h5Page.on Events.Click, ->
	init()
	skt.h5Page.opacity = 0
	skt.dragArea.draggable.enabled = true
# 			skt.h5Page.off Events.Click

mainUp.on Events.AnimationEnd, ->
	Utils.delay 0.8, ->
		skt.h5Page.ignoreEvents = false
		skt.h5Page.opacity = 1
		
	

