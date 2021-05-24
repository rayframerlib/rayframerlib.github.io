Framer.Extras.Hints.disable()

mainScreen.width = 375
mainScreen.height = 812

mainScreen.clip = true
mainScreen.centerY()
mainScreen.centerX()



if Screen.width > 375
	mainScreen.scale = Screen.width / 375
mainScreen.y = (Screen.height - mainScreen.height) / 2

Framer.Defaults.Animation =
	curve: Spring(damping: 1)
	time: 0.35

receivedContents = [
	{
		url: './assets/received_text.png',
		width: 168,
		height: 40
	},
	{
		url: './assets/received_text_emoji.png',
		width: 263,
		height: 80
	},
	{
		url: './assets/received_long_text.png',
		width: 263,
		height: 64
	},
	{
		url: './assets/received_live.png',
		width: 160,
		height: 260
	},
	{
		url: './assets/received_product.png',
		width: 263,
		height: 80
	},
	{
		url: './assets/received_redpacket.png',
		width: 136,
		height: 40
	},
	{
		url: './assets/received_user.png',
		width: 158,
		height: 64
	},
	{
		url: './assets/received_video.png',
		width: 263,
		height: 80
	}
]

sentContents = [
	{
		url: './assets/sent_text_cake.png',
		width: 263,
		height: 64
	},
	{
		url: './assets/sent_text_hand.png',
		width: 120,
		height: 40
	},
	{
		url: './assets/sent_text_laugh.png',
		width: 151,
		height: 40
	},
	{
		url: './assets/sent_product.png',
		width: 160,
		height: 160
	},
	{
		url: './assets/sent_user.png',
		width: 160,
		height: 260
	},
]

jumpArea.clip = true

imFlow.draggable.enabled = true
imFlow.draggable.speedX = 0

setFlowConstrains = () ->
	imFlow.draggable.constraints = 
		x: 0
		y: bottomBar.y - imFlow.height
		width: mainScreen.width
		height: 2 * imFlow.height - (mainScreen.height -  bottomBar.height - navigationBar.height)

setFlowConstrains()

class ReceivedMessage extends Layer
	constructor: (@options={}) ->
		@options.x ?= 0
		@options.y ?= 0
		@options.width ?= 307
		@options.height ?= 40
		@options.backgroundColor ?= 'transparent'
		@options.avatar ?= '' 
		@options.content ?= ''
		@options.contentWidth ?= 200
		@options.contentHeight ?= 200
		@options.contentBoarderRadius ?= {topLeft:12, topRight:12, bottomRight:12, bottomLeft:12}
		
		super @options

		@senderAvatar = new Layer
			superLayer: @ 
			y: 2
			width: 36
			height: 36
			image: @options.avatar
		
		@content = new Layer
			superLayer: @
			x: 44
			y: 0
			width: @options.contentWidth
			height: @options.contentHeight
			backgroundColor: "rgba(22, 24, 35, 0.05)"
			image: @options.content
			borderRadius: @options.contentBoarderRadius
		
		@.states.initial = 
# 			x: @options.x - 50
			opacity: 0
		
		@.states.show = 
# 			x: @options.x
			opacity: 1
			options:
				time: 0.5
				curve: Spring(damping: 1)
			
		@content.states.initial = 
			rotation: 0
# 			x: @content.x - 10
# 			y: @content.y + 8
			
		@content.states.show =
			rotation: 0
			options:
				time: 0.5
				curve: Spring(damping: 1)
# 			x: @content.x
# 			y: @content.y
		
		@senderAvatar.states.initial = 
			opacity: 0
		
		@senderAvatar.states.show = 
			opacity: 1
			options:
				time: 0.5
				curve: Spring(damping: 1)
		
		@init()
	
	init: () ->
		@.height = @content.height
		@.stateSwitch('initial')
		@content.stateSwitch('initial')
		@senderAvatar.stateSwitch('initial')
	
	show: (mode) ->
		if mode == 'fuse'
			@.animate('show')
			@content.animate('show')
		else
			@.animate('show')
			@content.animate('show')
			@senderAvatar.animate('show')
			
	setRadius: (radius) ->
		@content.animate
			borderRadius: radius
			options:
				time: 0.2
	
a = new ReceivedMessage
	x: 200
	y: 200


class SentMessage extends Layer
	constructor: (@options={}) ->
		@options.x ?= 0
		@options.y ?= 0
		@options.width ?= 307
		@options.height ?= 40
		@options.backgroundColor ?= 'transparent'
		@options.avatar ?= '' 
		@options.content ?= ''
		@options.contentWidth ?= 200
		@options.contentHeight ?= 200
		@options.contentBoarderRadius ?= {topLeft:12, topRight:12, bottomRight:12, bottomLeft:12}
		
		super @options

		@senderAvatar = new Layer
			superLayer: @ 
			y: 2
			x: 271
			width: 36
			height: 36
			image: @options.avatar
			
		@content = new Layer
			superLayer: @
			y: 0
			width: @options.contentWidth
			height: @options.contentHeight
			image: @options.content
			borderRadius: @options.contentBoarderRadius
		
		@content.x = 263 - @content.width
		
		@.states.initial = 
# 			x: @options.x + 50
			opacity: 0	
		
		@.states.show = 
# 			x: @options.x
			opacity: 1
		
		@content.states.initial = 
# 			rotation: -10
# 			x: @content.x + 30
# 			y: @content.y + 12
			
	
		@content.states.show =
			rotation: 0
			x: @content.x
			y: @content.y
# 			options:
# 				curve: Spring(damping: 0.6)
# 				time: 0.6
		@senderAvatar.states.initial = 
			opacity: 0
		
		@senderAvatar.states.show = 
			opacity: 1
			options:
				time: 0.5
				curve: Spring(damping: 1)
		
		_self = @
		_content = @content
		@.parent.on 'change:y', ->
			screenY = _self.convertPointToLayer([0,0], mainScreen).y
			colorR = Utils.modulate(screenY,[0,380],[70,22],true)
			colorG = Utils.modulate(screenY,[0,380],[101,142],true)
			colorB = Utils.modulate(screenY,[0,380],[255,249],true)
			positionColor = 'rgba('+ colorR + ',' + colorG + ',' + colorB + ', 1)' 
			_content.backgroundColor = positionColor
		
		@init()
	
	init: () ->
		@.height = @content.height
		@.stateSwitch('initial')
		@content.stateSwitch('initial')
		@senderAvatar.stateSwitch('initial')
	
	show: (mode) ->
		if mode == 'fuse'
			@.animate('show')
			@content.animate('show')
		else
			@.animate('show')
			@content.animate('show')
			@senderAvatar.animate('show')
	
	setRadius: (radius) ->
		@content.animate
			borderRadius: radius
			options:
				time: 0.2

randomInt = (min, max) ->
	Math.round(Utils.randomNumber(min, max))

newRandomReceivedMessage = () ->
	messageAmount = imFlow.children.length
	showType = ''
	if messageAmount
		if imFlow.children[messageAmount-1].constructor.name == 'ReceivedMessage'
			messagePositionY = imFlow.children[messageAmount-1].y + imFlow.children[messageAmount-1].height + 2
			showType = 'fuse'
			lastRadius = imFlow.children[messageAmount-1].content.borderRadius
			lastRadius.bottomLeft = 2
			imFlow.children[messageAmount-1].setRadius(lastRadius)
			newRadius = {topLeft:2, topRight:12, bottomRight:12, bottomLeft:12}
		else
			messagePositionY = imFlow.children[messageAmount-1].y + imFlow.children[messageAmount-1].height + 16
			showType = 'normal'
			newRadius = {topLeft:12, topRight:12, bottomRight:12, bottomLeft:12}
		
	else
		messagePositionY = 20
	
	randomIndex = randomInt(0, receivedContents.length - 1)
		
	received = new ReceivedMessage
		superLayer: imFlow
		x: 12
		y: messagePositionY
		avatar: './assets/sender_avatar_1.png'
		contentWidth: receivedContents[randomIndex].width
		contentHeight: receivedContents[randomIndex].height
		content: receivedContents[randomIndex].url
		contentBoarderRadius: newRadius
	
	if imFlow.children[messageAmount].y + imFlow.children[messageAmount].height + 20 >= bottomBar.y - navigationBar.height
		imFlow.height = imFlow.children[messageAmount].y + imFlow.children[messageAmount].height + 20
		setFlowConstrains()
		flowAnimateToBottom()
	
	received.show(showType)
	
	
	
		
	
newRandomSentMessage = () ->
	messageAmount = imFlow.children.length
	newRadius = []
	showType = ''
	if messageAmount
		if imFlow.children[messageAmount-1].constructor.name == 'SentMessage'
			messagePositionY = imFlow.children[messageAmount-1].y + imFlow.children[messageAmount-1].height + 2
			showType = 'fuse'
			lastRadius = imFlow.children[messageAmount-1].content.borderRadius
			lastRadius.bottomRight = 0
			imFlow.children[messageAmount-1].setRadius(lastRadius)
			newRadius = {topLeft:12, topRight:0, bottomRight:12, bottomLeft:12}
		else
			messagePositionY = imFlow.children[messageAmount-1].y + imFlow.children[messageAmount-1].height + 16
			newRadius = {topLeft:12, topRight:12, bottomRight:12, bottomLeft:12}
		
	else
		showType = 'normal'
		messagePositionY = 20	
	randomIndex = randomInt(0, sentContents.length - 1)
		
	sent = new SentMessage
		superLayer: imFlow
		x: 56
		y: messagePositionY
		avatar: './assets/sender_avatar_2.png'
		contentWidth: sentContents[randomIndex].width
		contentHeight: sentContents[randomIndex].height
		content: sentContents[randomIndex].url
		contentBoarderRadius: newRadius
	
	if imFlow.children[messageAmount].y + imFlow.children[messageAmount].height + 20 >=  bottomBar.y - navigationBar.height
		imFlow.height = imFlow.children[messageAmount].y + imFlow.children[messageAmount].height + 20
		setFlowConstrains()
		flowAnimateToBottom()
	
	sent.show(showType)

newTargetMessage = () ->
	messageAmount = imFlow.children.length
	newRadius = []
	showType = ''
	if messageAmount
		if imFlow.children[messageAmount-1].constructor.name == 'SentMessage'
			messagePositionY = imFlow.children[messageAmount-1].y + imFlow.children[messageAmount-1].height + 2
			showType = 'fuse'
			lastRadius = imFlow.children[messageAmount-1].content.borderRadius
			lastRadius.bottomRight = 2
			imFlow.children[messageAmount-1].setRadius(lastRadius)
			newRadius = {topLeft:12, topRight:2, bottomRight:12, bottomLeft:12}
		else
			messagePositionY = imFlow.children[messageAmount-1].y + imFlow.children[messageAmount-1].height + 16
			newRadius = {topLeft:12, topRight:12, bottomRight:12, bottomLeft:12}
		
	else
		showType = 'normal'
		messagePositionY = 20
		
	sent = new SentMessage
		superLayer: imFlow
		x: 56
		y: messagePositionY
		avatar: './assets/sender_avatar_2.png'
		contentWidth: sentContents[0].width
		contentHeight: sentContents[0].height
		content: sentContents[0].url
		contentBoarderRadius: newRadius
		
	
	if imFlow.children[messageAmount].y + imFlow.children[messageAmount].height + 20 >=  bottomBar.y - navigationBar.height
		imFlow.height = imFlow.children[messageAmount].y + imFlow.children[messageAmount].height + 20
		setFlowConstrains()
		flowAnimateToBottom()
		imFlow.animate
			y: bottomBar.y - imFlow.height
			options: 
				time: 0.3
				curve: Spring(damping: 1)
	
	Utils.delay 0.1, ->
		sent.show(showType)
# 	sent.children[1].opacity = 0
	return sent

flowAnimateToBottom = () ->
	imFlow.animate
		y: bottomBar.y - imFlow.height
		options: 
			time: 0.5
			curve: Spring(damping: 1)

flowAnimateToTop = () ->
	imFlow.animate
		y: 302 + navigationBar.height

jumpArea.states.initial = 
	x: jumpArea.x
	y: jumpArea.y
	width: jumpArea.width
	borderRadius: jumpArea.borderRadius
	backgroundColor: jumpArea.backgroundColor
	shadow1: 
		y: 0
		blur: 0
		color: 'transparent'

jumpArea.states.float = 
	x: jumpArea.x + 72
	y: jumpArea.y - 25
	scale: 0.95
	width: 240
	height: 64
	borderRadius: jumpArea.borderRadius
	backgroundColor: 'rgba(22, 142, 249, 1)'
	shadow1: 
		y: 4
		blur: 6
		color: 'rgba(255, 255, 255, 0.1)'
	options: 
		time: 0.1
		curve: 'Bezier(.3,0,1,.9)'

jumpArea.states.drop = 
	x: jumpArea.x + 45
	y: jumpArea.y - 97
	width: 263
	borderRadius: 12
	backgroundColor: 'rgba(22, 142, 249, 1)'
	scale:1
	shadow1: 
		y: 0
		blur: 0
		color: 'transparent'
	options: 
		time: 0.2
		curve: 'Bezier(0,0.1,0.5,1)'

jumpArea.states.dropBounce = 
	scale:1
	options: 
		time: 0.4
		curve: Spring(damping: 1)


jumpText.states.initial = 
	x: jumpText.x
	y: jumpText.y
	color: jumpText.color
	
jumpText.states.float = 
	x: 12
	width: 220
	color: 'rgba(255, 255, 255, 0.9)'

jumpText.states.drop =
	x: 11
	y: 10
	color: 'rgba(255, 255, 255, 0.9)'

bottomBar.states.input = 
	y: bottomBar.y
	height: bottomBar.height

bottomBar.states.normal = 
	y: bottomBar.y + 18
	height: bottomBar.height - 18
	
bottomBar.stateSwitch('input')

area.opacity = 0

area.states.initial = 
	borderRadius: 22

area.states.input = 
	borderRadius: 22

areaJump = () ->
	jumpArea.backgroundColor = 'rgba(22, 24, 35, 0.05)'
	bottomBar.animate('normal')
	area.animate('initial')
	area.opacity = 1
	jumpText.animate('float')
	jumpEmoji.x = 60
	jumpArea.animate('float').on Events.AnimationEnd, ->
		
		jumpText.x = 10
		jumpText.fontSize = 16
		jumpText.width = 240
		jumpText.lineHeight = 1.4
		jumpEmoji.x= 44
		jumpEmoji.y= 36
		sent = newTargetMessage()
		jumpArea.animate('drop').on Events.AnimationEnd, ->
			Utils.delay 0.07, ->
				jumpArea.opacity = 0
			jumpArea.animate('dropBounce').on Events.AnimationEnd, ->
# 				sent.children[1].opacity = 1
			
		jumpText.animate('drop')


flowWraper.states.initial = 
	y: 0

flowWraper.states.keyboard = 
	y: -302

# keyboardUp = () ->
# 	if keyboard.states.current.name == 'initial'
# 		keyboard.animate('show')
# 		bottomBar.animate('high')
# 		lightBar.animate('show')
# 		darkBar.animate('vanish')
# 		flowWraper.animate('keyboard')
# 		
# 		if imFlow.children.length
# 			visibleFlowHeight = imFlow.children[imFlow.children.length - 1].y + imFlow.children[imFlow.children.length - 1].height + 20
# 		else
# 			visibleFlowHeight = 0
# 			
# 		if visibleFlowHeight <= 413 - navigationBar.height
# 			flowAnimateToTop()
# 		else if visibleFlowHeight < 626
# 			imFlow.height = imFlow.children[imFlow.children.length - 1].y + imFlow.children[imFlow.children.length - 1].height + 20
# 			flowAnimateToBottom()
# 		else
# 			flowAnimateToBottom()

# keyboardDown = () ->
# 	keyboard.animate('initial')
# 	bottomBar.animate('low')
# 	lightBar.animate('vanish')
# 	darkBar.animate('show')
# 	flowWraper.animate('initial')
# 	if imFlow.height < 626
# 		imFlow.height = 626
# 		imFlow.draggable.constraints.height = 626
# 		imFlow.draggable.constraints.y = 88
# 		flowAnimateToTop()


imFlow.on Events.DragStart, ->
	if keyboard.states.current.name == 'show'
		keyboardDown()
	
keyboardHitArea.on Events.Click, ->
	if bottomBar.states.current.name == 'normal' && !bottomBar.isAnimating 
		area.animate('input')
		bottomBar.animate('input').on Events.AnimationEnd, ->
			area.opacity = 0
			jumpText.fontSize = 15
			jumpText.width = 173
			jumpText.lineHeight = 1.2
			jumpEmoji.x= 140
			jumpEmoji.y= 32
			jumpArea.opacity = 1
			jumpArea.stateSwitch('initial')
			jumpText.stateSwitch('initial')
			
			
	else if bottomBar.states.current.name == 'input' && !bottomBar.isAnimating
		areaJump()

for i in [0...10 ]
	newRandomReceivedMessage()
	newRandomSentMessage()
	
newButton.on Events.Click, ->
	newRandomReceivedMessage()

