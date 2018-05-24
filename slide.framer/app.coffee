# Import file "forFramer"
skt = Framer.Importer.load("imported/forFramer@1x", scale: 0.5)


ratio = window.devicePixelRatio
if ratio == 2
	skt.mainScreen.scale = ratio/2
else
	skt.mainScreen.scale = ratio/3
skt.mainScreen.clip = true
skt.mainScreen.center()

tabContentTexts = ["热门", "附近", "明星", "搞笑", "社会", "电影", "电视剧"]

pageIndexEnd = 2 + (tabContentTexts.length - 1) - 1

previousHot = null

skt.findButton.opacity = 0
skt.storyButton.opacity = 0

#顶导配置
skt.hot.opacity = 0
skt.tabColorPad.height = 3
skt.favGroup.scale = 1.058

holder = new Layer
	x:0
	y:0
	width: 0
	height: 0

tabMark = new Layer
	superLayer: skt.tab
	width: 24
	height: 3
	borderRadius: 3
	backgroundColor: "transparent"
	x: 6
	y: 26
	clip: true

skt.tabColorPad.superLayer = tabMark
skt.tabColorPad.y = 0
skt.tabColorPad.x = 0

#顶导动画
markToMain = new Animation
	layer: tabMark
	properties: {x: 6}
	time: 0.0
	curve: "ease"

colorToMain = new Animation
	layer: skt.tabColorPad
	properties: {x: 0}
	time: 0.0
	curve: "ease"

markToHot = new Animation
	layer: tabMark
	properties: {x: 84}
	time: 0.0
	curve: "ease"

colorToHot = new Animation
	layer: skt.tabColorPad
	properties: {x: -76}
	time: 0.0
	curve: "ease"

#顶导状态
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

#顶导控制函数
markScrollControl = (controllerX) ->
	value = Utils.modulate(controllerX, [-750, -375], [-750, 0])
	
	if value <= 0 && value >= -375
		tabMark.width = Utils.modulate(value, [0, -375], [24, 102])
		tabMark.x = 6
		skt.tabColorPad.x = 0
		skt.fav.opacity = Utils.modulate(value, [0, -375], [1, 0.5])
		skt.hot.opacity = Utils.modulate(value, [0, -375], [0, 0.5])
		skt.hotGroup.scale = Utils.modulate(value, [0, -375], [1, 1.029])
		skt.favGroup.scale = Utils.modulate(value, [0, -375], [1.058, 1.029])
		
	else if value < -375 && value >= -750
		tabMark.width = Utils.modulate(value, [-375, -750], [102, 24])
		tabMark.x = Utils.modulate(value, [-375, -750], [6, 84])
		skt.tabColorPad.x = Utils.modulate(value, [-375, -750], [0, -71])
		skt.fav.opacity = Utils.modulate(value, [-375, -750], [0.5, 0])
		skt.hot.opacity = Utils.modulate(value, [-375, -750], [0.5, 1])
		skt.hotGroup.scale = Utils.modulate(value, [-375, -750], [1.029, 1.068])
		skt.favGroup.scale = Utils.modulate(value, [-375, -750], [1.029, 1])

#二级导航初始化
tabContents = new Layer
	superLayer: skt.secondTab
	height: 42
	backgroundColor: "transparent"

tabContents.placeBefore(skt.secondTabBg)

for i in [0...tabContentTexts.length]
	contentsText = new TextLayer
		fontSize: 15
		color: "#333333"
		text: tabContentTexts[i]
	
	contents = new Layer
		height: 42
		width: contentsText.width + 32
		backgroundColor: "transparent"
		
	cx = 0
	if i >= 0
		for num in [0...i]
			cx += tabContents.subLayers[num].width
	
	contentsText.superLayer = contents
	contentsText.center()
	contents.superLayer = tabContents
	contents.x = cx

skt.secondTab.clip = true
tabContents.width = tabContents.subLayers[tabContentTexts.length - 1].x + tabContents.subLayers[tabContentTexts.length - 1].width

tabContents.draggable.enabled = true
tabContents.draggable.speedY = 0

tabContents.draggable.constraints = {
	x: 375 - 40 - tabContents.width
	y: 0
	width: 2 * tabContents.width - (375 - 40)
	height: 80
}

#二级导航控制
tabContents.subLayers[0].subLayers[0].color = "#ff8200"
tabContents.subLayers[0].subLayers[0].fontWeight = 500

textChange = (page) ->
	tabContentIndex = page - 2
	if 0 <= tabContentIndex <= pageIndexEnd - 1
		for i in [0...pageIndexEnd]
			if i == tabContentIndex
				tabContents.subLayers[i].subLayers[0].color = "#ff8200"
				tabContents.subLayers[i].subLayers[0].fontWeight = 500
			else
				tabContents.subLayers[i].subLayers[0].color = "333333"
				tabContents.subLayers[i].subLayers[0].fontWeight = 400
		
		if 187 <= tabContents.subLayers[tabContentIndex].x + tabContents.subLayers[tabContentIndex].width / 2 && tabContents.width - (tabContents.subLayers[tabContentIndex].x + tabContents.subLayers[tabContentIndex].width / 2) >= 187 - 40
			tabContents.animate
				x: 187 - (tabContents.subLayers[tabContentIndex].x + tabContents.subLayers[tabContentIndex].width / 2)
				options: 
					time: 0.5
					curve: Spring(damping: 1)
		else if tabContents.subLayers[tabContentIndex].x + tabContents.subLayers[tabContentIndex].width / 2 < 187
			tabContents.animate
				x: 0
				options: 
					time: 0.5
					curve: Spring(damping: 1)
		else
			tabContents.animate
				x: 375 - tabContents.width - 40
				options: 
					time: 0.5
					curve: Spring(damping: 1)
	

#滑动控制初始化
scrollControllerPage = new PageComponent
	x: 0
	y: 137
	width: 375
	height: 486
	parent: skt.mainScreen

scrollControllerPage.content.draggable.speedY = 0
scrollControllerPage.content.draggable.overdrag = false

for layers in skt.slideController.subLayers
	layers.opacity = 0
	scrollControllerPage.addPage(layers, "right")

scrollControllerPage.snapToPage(skt.slidePage1, false)

#补丁辣鸡代码
tabContents.subLayers[0].on Events.Click, ->
	scrollControllerPage.snapToPage(skt.slidePage2)

tabContents.subLayers[1].on Events.Click, ->
	scrollControllerPage.snapToPage(skt.slidePage3)

tabContents.subLayers[2].on Events.Click, ->
	scrollControllerPage.snapToPage(skt.slidePage4)

tabContents.subLayers[3].on Events.Click, ->
	scrollControllerPage.snapToPage(skt.slidePage5)

tabContents.subLayers[4].on Events.Click, ->
	scrollControllerPage.snapToPage(skt.slidePage6)

tabContents.subLayers[5].on Events.Click, ->
	scrollControllerPage.snapToPage(skt.slidePage7)

tabContents.subLayers[6].on Events.Click, ->
	scrollControllerPage.snapToPage(skt.slidePage8)
	
scrollControllerPage.content.on "change:x", ->
	controllerX = scrollControllerPage.content.x
	if  -375 < controllerX <= 0
		skt.storyScheme.x = controllerX
		skt.feedScheme.x = controllerX + 375
		
	
	if -750 < controllerX <= -375
		skt.storyScheme.x = -375
		skt.feedScheme.x = 0
		skt.follow.x = controllerX + 375
		skt.hotFeed.x = controllerX + 750
		skt.secondTab.x = controllerX + 750
		markScrollControl(controllerX)
	
	if -3000 < controllerX <= -750
		skt.findScheme.x = 375
		skt.feedScheme.x = 0
		skt.secondTab.x = 0
		skt.follow.x = -375
		skt.hotFeed.x = controllerX + 750
	
	if -3375 <= controllerX <= -3000
		skt.feedScheme.x = controllerX + 3000
		skt.findScheme.x = controllerX + 3375

scrollControllerPage.on "change:currentPage", ->
	page = scrollControllerPage.content.subLayers.indexOf(scrollControllerPage.currentPage)	
	textChange(page)

skt.fav.on Events.Click, ->
	previousHot = scrollControllerPage.currentPage
	scrollControllerPage.snapToPage(skt.slidePage1, false)
	markToMain.start()
	colorToMain.start()
	skt.fav.animate("show")
	skt.favGroup.animate("bigger")
	skt.hot.animate("vanish")
	skt.hotGroup.animate("normal")

skt.hot.on Events.Click, ->
	if previousHot != null
		scrollControllerPage.snapToPage(previousHot, false)
		previousHot = null
	else
		scrollControllerPage.snapToPage(skt.slidePage2, false)
	markToHot.start()
	colorToHot.start()
	skt.hot.animate("show")
	skt.hotGroup.animate("bigger")
	skt.fav.animate("vanish")
	skt.favGroup.animate("normal")
	
skt.storyButton.on Events.Click, ->
	scrollControllerPage.snapToPage(skt.slidePage0, false)

skt.findButton.on Events.Click, ->
	scrollControllerPage.snapToPage(skt.slidePage9, false)
		
		
		
		
		
		
		
		
		