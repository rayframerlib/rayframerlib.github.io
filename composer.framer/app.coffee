# Import file "composerForFramer4Row"
skt = Framer.Importer.load("imported/composerForFramer4Row@1x")

skt.mainScreen.center()

# print Canvas.width
skt.mainScreen.center()
ratio = window.devicePixelRatio
skt.mainScreen.scale = ratio/2

skt.mainScreen.clip = true

originRow1Y = skt.p1b1.y
originRow2Y = skt.p1b5.y
originUpunitY = skt.upUnit.y
originCancelX = skt.cancel.x
originPlusX = skt.plus.x

upTime = 1/6
delayTime = 0.03
downTime = 0.2
pageTime = 0.2

maskBg = new Layer
	superLayer: skt.mask
	width: 750
	height: 1334
	image: "images/mask.png"

maskBg.placeBehind(skt.cancel)
maskBg.opacity = 0

skt.selecter.opacity = 0

# skt.back.opacity = 0

page1ButtonsRow1 = [skt.p1b1, skt.p1b2, skt.p1b3, skt.p1b4]
page1ButtonsRow2 = [skt.p1b5, skt.p1b6, skt.p1b7, skt.p1b8]

for layer in page1ButtonsRow1
	layer.y = originRow1Y + 476
	layer.opacity = 0

for layer in page1ButtonsRow2
	layer.y = originRow2Y + 476
	layer.opacity = 0

skt.upUnit.y = originUpunitY - 308
skt.upUnit.opacity = 0

skt.cancel.x = originCancelX + 43
skt.cancel.rotationZ = 45
skt.cancel.opacity = 0

page = new PageComponent
	width: 750
	height: 1334
	scrollVertical: false
page.superLayer = skt.mask
page.placeBehind(skt.cancel)

p1 = new Layer
	width: 750
	height: 1334
	backgroundColor: "transparent"
	parent: page.content
p2 = new Layer
	width: 750
	height: 1334
	backgroundColor: "transparent"

page.content.ignoreEvents = true
page.addPage(p2, "right")

skt.buttonPage1.superLayer = p1
skt.buttonPage2.superLayer = p2
# pageOne = new Layer
#     width: page.width
#     height: page.height
#     parent: page.content
#     backgroundColor: "transparent"
# 
# pageTwo = new Layer
#     width: page.width
#     height: page.height
#     backgroundColor: "transparent"

# page.addPage(skt.buttonPage1, "right")


# 出现相关动画

plusMoveVanish = new Animation
	layer: skt.plus
	properties: {x: originPlusX - 43, opacity: 0}
	time: 0.15
	curve: "ease"

plusIconRoll = new Animation
	layer: skt.plusIcon
	properties: {rotationZ: -45}
	time: 0.15
	curve: "ease"
	
cancelMoveShow = new Animation
	layer: skt.cancel
	properties: {x: originCancelX, opacity: 1, rotationZ: 0}
	time: 0.15
	curve: "ease"
	
maskShow = new Animation
	layer: maskBg
	properties: {opacity: 1}
	time: 0.15
	curve: "ease"

upUnitShow = new Animation
	layer: skt.upUnit
	properties: {y: originUpunitY}
	time: 0.35
	curve: "ease-out"

upUnitOpShow = new Animation
	layer: skt.upUnit
	properties: {opacity: 1}
	time: 0.2
	curve: "ease-in"
	
selecterShow = new Animation
	layer: skt.selecter
	properties: {opacity: 1}
	time: downTime
	curve: "ease-out"
	
#消失相关动画

plusMoveShow = new Animation
	layer: skt.plus
	properties: {x: originPlusX, opacity: 1}
	time: 0.15
	curve: "ease"

plusIconRollBack = new Animation
	layer: skt.plusIcon
	properties: {rotationZ: 0}
	time: 0.15
	curve: "ease"
	
cancelMoveVanish = new Animation
	layer: skt.cancel
	properties: {x: originCancelX + 43, opacity: 0, rotationZ: 45}
	time: 0.15
	curve: "ease"
	
backVanish = new Animation
	layer: skt.back
	properties: {opacity: 0}
	time: 0.15
	curve: "ease"
	
maskVanish = new Animation
	layer: maskBg
	properties: {opacity: 0}
	time: 0.15
	curve: "ease"

upUnitVanish = new Animation
	layer: skt.upUnit
	properties: {y: originUpunitY - 308}
	time: 0.35
	curve: "ease-in"

upUnitOpVanish = new Animation
	layer: skt.upUnit
	properties: {opacity: 0}
	time: 0.2
	curve: "ease-out"

selecterVanish = new Animation
	layer: skt.selecter
	properties: {opacity: 0}
	time: downTime
	curve: "ease-in"

#button 时差

buttonUp1 = new Animation
	layer: skt.p1b1
	properties: {y: originRow1Y - 40}
	time: upTime
	curve: "ease-out"

buttonUp2 = new Animation
	layer: skt.p1b2
	properties: {y: originRow1Y - 40}
	time: upTime
	curve: "ease-out"

buttonUp3 = new Animation
	layer: skt.p1b3
	properties: {y: originRow1Y - 40}
	time: upTime
	curve: "ease-out"

buttonUp4 = new Animation
	layer: skt.p1b4
	properties: {y: originRow1Y - 40}
	time: upTime
	curve: "ease-out"

buttonUp5 = new Animation
	layer: skt.p1b5
	properties: {y: originRow2Y - 40}
	time: upTime
	curve: "ease-out"

buttonUp6 = new Animation
	layer: skt.p1b6
	properties: {y: originRow2Y - 40}
	time: upTime
	curve: "ease-out"

buttonUp7 = new Animation
	layer: skt.p1b7
	properties: {y: originRow2Y - 40}
	time: upTime
	curve: "ease-out"

buttonUp8 = new Animation
	layer: skt.p1b8
	properties: {y: originRow2Y - 40}
	time: upTime
	curve: "ease-out"

buttonDown1 = new Animation
	layer: skt.p1b1
	properties: {y: originRow1Y}
	time: upTime
	curve: "ease-in-out"

buttonDown2 = new Animation
	layer: skt.p1b2
	properties: {y: originRow1Y}
	time: upTime
	curve: "ease-in-out"

buttonDown3 = new Animation
	layer: skt.p1b3
	properties: {y: originRow1Y}
	time: upTime
	curve: "ease-in-out"

buttonDown4 = new Animation
	layer: skt.p1b4
	properties: {y: originRow1Y}
	time: upTime
	curve: "ease-in-out"
	
buttonDown5 = new Animation
	layer: skt.p1b5
	properties: {y: originRow2Y}
	time: upTime
	curve: "ease-in-out"

buttonDown6 = new Animation
	layer: skt.p1b6
	properties: {y: originRow2Y}
	time: upTime
	curve: "ease-in-out"

buttonDown7 = new Animation
	layer: skt.p1b7
	properties: {y: originRow2Y}
	time: upTime
	curve: "ease-in-out"

buttonDown8 = new Animation
	layer: skt.p1b8
	properties: {y: originRow2Y}
	time: upTime
	curve: "ease-in-out"

buttonOp1 = new Animation
	layer: skt.p1b1
	properties: {opacity: 1}
	time: 2 * upTime
	curve: "ease-out"

buttonOp2 = new Animation
	layer: skt.p1b2
	properties: {opacity: 1}
	time: 2 * upTime
	curve: "ease-out"

buttonOp3 = new Animation
	layer: skt.p1b3
	properties: {opacity: 1}
	time: 2 * upTime
	curve: "ease-out"

buttonOp4 = new Animation
	layer: skt.p1b4
	properties: {opacity: 1}
	time: 2 * upTime
	curve: "ease-out"

buttonOp5 = new Animation
	layer: skt.p1b5
	properties: {opacity: 1}
	time: 2 * upTime
	curve: "ease-out"

buttonOp6 = new Animation
	layer: skt.p1b6
	properties: {opacity: 1}
	time: 2 * upTime
	curve: "ease-out"

buttonOp7 = new Animation
	layer: skt.p1b7
	properties: {opacity: 1}
	time: 2 * upTime
	curve: "ease-out"

buttonOp8 = new Animation
	layer: skt.p1b8
	properties: {opacity: 1}
	time: 2 * upTime
	curve: "ease-out"

buttonVan1 = new Animation
	layer: skt.p1b1
	properties: {y: originRow1Y + 476, opacity: 0}
	time: downTime
	curve: "ease-in"

buttonVan2 = new Animation
	layer: skt.p1b2
	properties: {y: originRow1Y + 476, opacity: 0}
	time: downTime
	curve: "ease-in"

buttonVan3 = new Animation
	layer: skt.p1b3
	properties: {y: originRow1Y + 476, opacity: 0}
	time: downTime
	curve: "ease-in"

buttonVan4 = new Animation
	layer: skt.p1b4
	properties: {y: originRow1Y + 476, opacity: 0}
	time: downTime
	curve: "ease-in"

buttonVan5 = new Animation
	layer: skt.p1b5
	properties: {y: originRow2Y + 476, opacity: 0}
	time: downTime
	curve: "ease-in"

buttonVan6 = new Animation
	layer: skt.p1b6
	properties: {y: originRow2Y + 476, opacity: 0}
	time: downTime
	curve: "ease-in"

buttonVan7 = new Animation
	layer: skt.p1b7
	properties: {y: originRow2Y + 476, opacity: 0}
	time: downTime
	curve: "ease-in"

buttonVan8 = new Animation
	layer: skt.p1b8
	properties: {y: originRow2Y + 476, opacity: 0}
	time: downTime
	curve: "ease-in"

buttonVan9 = new Animation
	layer: skt.p2b1
	properties: {y: originRow1Y + 476, opacity: 0}
	time: downTime
	curve: "ease-in"

buttonVan10 = new Animation
	layer: skt.p2b2
	properties: {y: originRow1Y + 476, opacity: 0}
	time: downTime
	curve: "ease-in"

buttonVan11 = new Animation
	layer: skt.p2b3
	properties: {y: originRow1Y + 476, opacity: 0}
	time: downTime
	curve: "ease-in"

buttonVan12 = new Animation
	layer: skt.p2b4
	properties: {y: originRow1Y + 476, opacity: 0}
	time: downTime
	curve: "ease-in"

buttonVan13 = new Animation
	layer: skt.p2b5
	properties: {y: originRow2Y + 476, opacity: 0}
	time: downTime
	curve: "ease-in"

buttonVan14 = new Animation
	layer: skt.p2b6
	properties: {y: originRow2Y + 476, opacity: 0}
	time: downTime
	curve: "ease-in"

buttonVan15 = new Animation
	layer: skt.p2b7
	properties: {y: originRow2Y + 476, opacity: 0}
	time: downTime
	curve: "ease-in"

buttonVan16 = new Animation
	layer: skt.p2b8
	properties: {y: originRow2Y + 476, opacity: 0}
	time: downTime
	curve: "ease-in"


buttonUp1.on Events.AnimationEnd, ->
	buttonDown1.start()
buttonUp2.on Events.AnimationEnd, ->
	buttonDown2.start()
buttonUp3.on Events.AnimationEnd, ->
	buttonDown3.start()
buttonUp4.on Events.AnimationEnd, ->
	buttonDown4.start()
buttonUp5.on Events.AnimationEnd, ->
	buttonDown5.start()
buttonUp6.on Events.AnimationEnd, ->
	buttonDown6.start()
buttonUp7.on Events.AnimationEnd, ->
	buttonDown7.start()
buttonUp8.on Events.AnimationEnd, ->
	buttonDown8.start()

buttonVan9.on Events.AnimationEnd, ->
	skt.p2b8.y = originRow2Y
	skt.p2b7.y = originRow2Y
	skt.p2b6.y = originRow2Y
	skt.p2b5.y = originRow2Y
	skt.p2b4.y = originRow1Y
	skt.p2b3.y = originRow1Y
	skt.p2b2.y = originRow1Y
	skt.p2b1.y = originRow1Y
	skt.p2b1.opacity = 1
	skt.p2b2.opacity = 1
	skt.p2b3.opacity = 1
	skt.p2b4.opacity = 1
	skt.p2b5.opacity = 1
	skt.p2b6.opacity = 1
	skt.p2b7.opacity = 1
	skt.p2b8.opacity = 1
	page.snapToPage(p1, false)
# 
openComposer = ->	
	selecterShow.start()
	page.content.ignoreEvents = false
	plusMoveVanish.start()
	plusIconRoll.start()
	cancelMoveShow.start()
	maskShow.start()
	upUnitShow.start()
	Utils.delay 0.15, ->
		upUnitOpShow.start()
	skt.plus.ignoreEvents = true
	skt.cancel.ignoreEvents = false
	buttonUp1.start()
	buttonOp1.start()
	Utils.delay delayTime, ->
		buttonUp2.start()
		buttonOp2.start()
	Utils.delay 2 * delayTime, ->
		buttonUp3.start()
		buttonOp3.start()
	Utils.delay 3 * delayTime, ->
		buttonUp4.start()
		buttonOp4.start()
	Utils.delay 4 * delayTime, ->
		buttonUp5.start()
		buttonOp5.start()
	Utils.delay 5 * delayTime, ->
		buttonUp6.start()
		buttonOp6.start()
	Utils.delay 6 * delayTime, ->
		buttonUp7.start()
		buttonOp7.start()
	Utils.delay 7 * delayTime, ->
		buttonUp8.start()
		buttonOp8.start()

closeComposer = ->
	selecterVanish.start()
	page.content.ignoreEvents = true
	plusMoveShow.start()
	plusIconRollBack.start()
	cancelMoveVanish.start()
	Utils.delay downTime,->
		maskVanish.start()
	upUnitVanish.start()
	upUnitOpVanish.start()
	skt.cancel.ignoreEvents = true
	skt.plus.ignoreEvents = false
	Utils.delay 7 * delayTime, ->
		buttonVan1.start()
		buttonVan9.start()
	Utils.delay 6 * delayTime, ->
		buttonVan2.start()
		buttonVan10.start()
	Utils.delay 5 * delayTime, ->
		buttonVan3.start()
		buttonVan11.start()
	Utils.delay 4 * delayTime, ->
		buttonVan4.start()
		buttonVan12.start()
	Utils.delay 3 * delayTime, ->
		buttonVan5.start()
		buttonVan13.start()
	Utils.delay 2 * delayTime, ->
		buttonVan6.start()
		buttonVan14.start()
	Utils.delay 1 * delayTime, ->
		buttonVan7.start()
		buttonVan15.start()
	Utils.delay 0 * delayTime, ->
		buttonVan8.start()
		buttonVan16.start()

page.content.on "change:x", ->
	if page.closestPage == p1
		skt.selected.x = 0
		skt.normal.x = 32
	else
		skt.selected.x = 32
		skt.normal.x = 0
	

skt.plus.on Events.Click, openComposer
skt.cancel.on Events.Click, closeComposer
skt.cancel.ignoreEvents = true

# skt.more.on Events.Click, ->
# 	skt.buttonPage1.states.switch("change")
# 	skt.buttonPage2.states.switch("change")
# 	skt.back.states.switch("change")

# skt.back.on Events.Click, ->
# 	skt.buttonPage1.states.switch("default")
# 	skt.buttonPage2.states.switch("default")
# 	skt.back.states.switch("default")
