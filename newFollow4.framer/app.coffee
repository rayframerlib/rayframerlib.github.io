Framer.Extras.Hints.disable()

mainScreen.width = 375
mainScreen.height = 812

mainScreen.clip = true
mainScreen.centerY()
mainScreen.centerX()

isShow = false
justFreshed = false

pageHandler = new PageComponent
	superLayer: videoTop
	width: videoTop.width
	height: videoTop.height
	scrollHorizontal: false
	backgroundColor: 'transparent'

topMask.placeBefore(pageHandler)

pageHandler.animationOptions =
	curve: 'ease-in-out'
	time: 0.35

for number in [0...3]
	pageContent = new Layer
		width: pageHandler.width
		height: pageHandler.height
		y: pageHandler.height * number
		backgroundColor: Utils.randomColor()
		parent: pageHandler.content
	intereaction = new Layer
		y: pageHandler.height - 361
		width: pageHandler.width
		height: 361
		superLayer: pageContent
		image: inter.image

pageHandler.content.draggable.overdragScale = 1

# onLive.draggable.enabled = true
# onLive.draggable.speedY = 0
# onLive.draggable.constraints = 
# 	x: onLiveContainer.width - onLive.width - 12
# 	y: 0
# 	width: onLive.width * 2 - onLiveContainer.width + 24
# 	height: onLiveContainer.height

videoTop.states.normal =
	y: 0
	options:
		time: 0.35
		curve: 'ease-in-out'
videoTop.states.show = 
	y: 346
	options:
		time: 0.35
		curve: 'ease-in-out'

arrow.states.normal = 
	rotation: 0
	options: 
		time: 0.35
		curve: 'ease-in-out'

arrow.states.show = 
	rotation: 180
	options:
		time: 0.35
		curve: 'ease-in-out'

buble.states.normal = 
	y: 106
# 	backgroundColor: 'rgba(41, 41, 41, 0.34)'
	options: 
		time: 0.35
		curve: 'ease-in-out'

buble.states.show = 
	y: 370
# 	backgroundColor: 'rgba(0, 0, 0, 0.34)'
	options: 
		time: 0.35
		curve: 'ease-in-out'

enterButton.states.normal = 
	backgroundColor: 'rgba(41, 41, 41, 0.34)'
	y: 4
	opacity: 1
	scaleX: 1
	scaleY: 1
	options: 
		time: 0.35
		curve: 'ease-in-out'
		
enterButton.states.show = 
	backgroundColor: 'rgba(0, 0, 0, 0.34)'
	y: 4
	opacity: 1
	scaleX: 1
	scaleY: 1
	options: 
		time: 0.35
		curve: 'ease-in-out'

enterButton.states.refreshVanish = 
	backgroundColor: 'rgba(0, 0, 0, 0.34)'
	scaleX: 0.9
	scaleY: 0.7
	y: 36
	opacity: 0
	options: 
		time: 0.35
		curve: 'ease-in-out'

topMask.states.normal = 
	opacity: 0
	options: 
		time: 0.35
		curve: 'ease-in-out'

topMask.states.show = 
	opacity: 1
	options: 
		time: 0.35
		curve: 'ease-in-out'

topMask.stateSwitch('normal')

topMask.on Events.Click, ->
	topNormal()
topMask.visible = false

headMask.states.normal = 
	opacity: 1
	options: 
		time: 0.35
		curve: 'ease-in-out'

headMask.states.show = 
	opacity: 0
	options: 
		time: 0.35
		curve: 'ease-in-out'

tip.states.vanish = 
	opacity: 0
	scaleX: 0.9
	scaleY: 0.7
	y: -30
	options: 
		time: 0.35
		curve: 'ease-in-out'
		
tip.states.show = 
	opacity: 1
	scaleX: 1
	scaleY: 1
	y: 0
	options: 
		time: 0.35
		curve: 'ease-in-out'

tip.stateSwitch('vanish')

pageHandler.content.on Events.DragEnd, ->
	if pageHandler.content.y >= 200
		topShow()

pageHandler.content.on "change:y", ->
	if @y > 0
		topMask.y = @y - 2
		buble.y = Utils.modulate(@y, [0, 407], [106, 431])
		containerChange()

videoTop.on "change:y", ->
	containerChange()

containerChange = () ->
	pageHandlerY = Utils.modulate(pageHandler.content.y,[0, 346],[0, 346],true)
	container.y = Utils.modulate(videoTop.y + pageHandlerY,[0, 346],[-346, 0],true)
	container.opacity = Utils.modulate(videoTop.y + pageHandlerY,[0, 346],[0, 1],true)
	container.scale = Utils.modulate(videoTop.y + pageHandlerY,[0, 346],[1, 1],true)

topShow = () ->
	isShow = true
	videoTop.animate('show')
	arrow.animate('show')
	buble.animate('show')
	enterButton.animate('show')
	topMask.visible = true
	topMask.animate('show')
	headMask.animate('show')
	bubleText.text = '上划关闭'
	arrow.x = bubleText.x + bubleText.width
	enterButton.width = arrow.x + arrow.width + 7
	enterButton.centerX()


topNormal = () ->
	isShow = false
	videoTop.animate('normal')
	arrow.animate('normal')
	buble.animate('normal')
	enterButton.animate('normal')
	headMask.animate('normal')
	topMask.animate('normal').on Events.AnimationEnd, ->
		topMask.visible = false
	bubleText.text = '常看的人'
	arrow.x = bubleText.x + bubleText.width
	enterButton.width = arrow.x + arrow.width + 7
	enterButton.centerX()
	if justFreshed
		justFreshed = false
		Utils.delay 0.3, ->
			tip.animate('show')
			enterButton.animate('refreshVanish')
		Utils.delay 4, ->
			tip.animate('vanish')
			enterButton.animate('normal')
			

refresh = () ->
	Utils.delay 1, ->
		topShow()
		justFreshed = true
# 		Utils.delay 0.3, ->
# 			tip.animate('show')
# 			enterButton.animate('refreshVanish')
# 		Utils.delay 4, ->
# 			tip.animate('vanish')
# 			enterButton.animate('show')
		pageHandler.snapToPage(pageHandler.content.subLayers[0],false)
	

buble.on Events.Click, ->
	if isShow
		topNormal()
	else
		topShow()

bottomHitArea.on Events.Click, ->
	refresh()
