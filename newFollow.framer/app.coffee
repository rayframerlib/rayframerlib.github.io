Framer.Extras.Hints.disable()

mainScreen.width = 375
mainScreen.height = 812

mainScreen.clip = true
mainScreen.centerY()
mainScreen.centerX()

isShow = false

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

onLive.draggable.enabled = true
onLive.draggable.speedY = 0
onLive.draggable.constraints = 
	x: onLiveContainer.width - onLive.width - 12
	y: 0
	width: onLive.width * 2 - onLiveContainer.width + 24
	height: onLiveContainer.height

oftenWatch.draggable.enabled = true
oftenWatch.draggable.speedY = 0
oftenWatch.draggable.constraints = 
	x: oftenWatchContainer.width - oftenWatch.width - 12
	y: 0
	width: oftenWatch.width * 2 - oftenWatchContainer.width + 24
	height: oftenWatchContainer.height

videoTop.states.normal =
	y: 0
	options:
		time: 0.35
		curve: 'ease-in-out'
videoTop.states.show = 
	y: 408
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
	backgroundColor: 'rgba(41, 41, 41, 0.34)'
	options: 
		time: 0.35
		curve: 'ease-in-out'

buble.states.show = 
	y: 429
	backgroundColor: 'rgba(0, 0, 0, 0.34)'
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

pageHandler.content.on Events.DragEnd, ->
	if pageHandler.content.y >= 200
		topShow()

pageHandler.content.on "change:y", ->
	if @y > 0
		topMask.y = @y - 2
		buble.y = Utils.modulate(@y, [0, 408], [106, 429])

topShow = () ->
	isShow = true
	videoTop.animate('show')
	arrow.animate('show')
	buble.animate('show')
	topMask.visible = true
	topMask.animate('show')
	headMask.animate('show')
	bubleText.text = '上划观看视频'
	oftenWatch.x = 12
	onLive.x = 12


topNormal = () ->
	isShow = false
	videoTop.animate('normal')
	arrow.animate('normal')
	buble.animate('normal')
	headMask.animate('normal')
	topMask.animate('normal').on Events.AnimationEnd, ->
		topMask.visible = false
	bubleText.text = '直播・常看的人'

buble.on Events.Click, ->
	if isShow
		topNormal()
	else
		topShow()


