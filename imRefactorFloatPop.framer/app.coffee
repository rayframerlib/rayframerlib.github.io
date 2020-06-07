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
	time: 0.4

receivedContents = [
	{
		url: './assets/received_text.png',
		width: 263,
		height: 62
	},
	{
		url: './assets/received_text_emoji.png',
		width: 200,
		height: 40
	},
	{
		url: './assets/received_long_text.png',
		width: 263,
		height: 222
	},
	{
		url: './assets/received_live.png',
		width: 174,
		height: 283
	},
	{
		url: './assets/received_product.png',
		width: 263,
		height: 92
	},
	{
		url: './assets/received_redpacket.png',
		width: 250,
		height: 92
	},
	{
		url: './assets/received_user.png',
		width: 263,
		height: 179
	},
	{
		url: './assets/received_video.png',
		width: 174,
		height: 283
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
		width: 136,
		height: 40
	},
	{
		url: './assets/sent_product.png',
		width: 263,
		height: 92
	},
	{
		url: './assets/sent_user.png',
		width: 263,
		height: 179
	},
]

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
			image: @options.content
		
		@.states.initial = 
# 			x: @options.x - 50
			opacity: 0
		
		@.states.show = 
# 			x: @options.x
			opacity: 1
			
		@content.states.initial = 
			rotation: 5
			x: @content.x - 10
			y: @content.y + 8
			
		@content.states.show =
			rotation: 0
			x: @content.x
			y: @content.y
		
		@init()
	
	init: () ->
		@.height = @content.height
		@.stateSwitch('initial')
		@content.stateSwitch('initial')
	
	show: () ->
		@.animate('show')
		@content.animate('show')

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
		
		@init()
	
	init: () ->
		@.height = @content.height
		@.stateSwitch('initial')
		@content.stateSwitch('initial')
	
	show: () ->
		@.animate('show')
		@content.animate('show')

randomInt = (min, max) ->
	Math.round(Utils.randomNumber(min, max))

newRandomReceivedMessage = () ->
	messageAmount = imFlow.children.length
	if messageAmount
		messagePositionY = imFlow.children[messageAmount-1].y + imFlow.children[messageAmount-1].height + 16
		
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
		
	
	if imFlow.children[messageAmount].y + imFlow.children[messageAmount].height + 20 >= bottomBar.y - navigationBar.height
		imFlow.height = imFlow.children[messageAmount].y + imFlow.children[messageAmount].height + 20
		setFlowConstrains()
		flowAnimateToBottom()
	
	received.show()
	
newRandomSentMessage = () ->
	messageAmount = imFlow.children.length
	if messageAmount
		messagePositionY = imFlow.children[messageAmount-1].y + imFlow.children[messageAmount-1].height + 16
		
	else
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
	
	if imFlow.children[messageAmount].y + imFlow.children[messageAmount].height + 20 >=  bottomBar.y - navigationBar.height
		imFlow.height = imFlow.children[messageAmount].y + imFlow.children[messageAmount].height + 20
		setFlowConstrains()
		flowAnimateToBottom()
	
	sent.show()

newTargetMessage = () ->
	messageAmount = imFlow.children.length
	if messageAmount
		messagePositionY = imFlow.children[messageAmount-1].y + imFlow.children[messageAmount-1].height + 16
		
	else
		messagePositionY = 20
		
	sent = new SentMessage
		superLayer: imFlow
		x: 56
		y: messagePositionY
		avatar: './assets/sender_avatar_2.png'
		contentWidth: sentContents[0].width
		contentHeight: sentContents[0].height
		content: sentContents[0].url
	
	if imFlow.children[messageAmount].y + imFlow.children[messageAmount].height + 20 >=  bottomBar.y - navigationBar.height
		imFlow.height = imFlow.children[messageAmount].y + imFlow.children[messageAmount].height + 20
		setFlowConstrains()
		flowAnimateToBottom()
	
	sent.show()

flowAnimateToBottom = () ->
	imFlow.animate
			y: bottomBar.y - imFlow.height

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
	x: jumpArea.x + 2
	y: jumpArea.y - 26
	width: 263
	borderRadius: jumpArea.borderRadius
	backgroundColor: '#e0e0e2'
	shadow1: 
		y: 4
		blur: 6
		color: 'rgba(22, 24, 35, 0.1)'
	options: 
		time: 0.15
		curve: 'Bezier(.3,0,1,.7)'

jumpArea.states.drop = 
	x: jumpArea.x + 3
	y: jumpArea.y - 94
	width: 263
	borderRadius: 4
	backgroundColor: '#242630'
	shadow1: 
		y: 0
		blur: 0
		color: 'transparent'
	options: 
		time: 0.25
		curve: 'Bezier(0,0.1,0.5,1)'

jumpText.states.initial = 
	x: jumpText.x
	y: jumpText.y
	color: jumpText.color

jumpText.states.drop =
	x: 11.5
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

areaJump = () ->
	jumpArea.backgroundColor = '#e0e0e2'
	bottomBar.animate('normal')
	area.opacity = 1
	jumpArea.animate('float').on Events.AnimationEnd, ->
		jumpText.fontSize = 16
		jumpText.width = 241
		jumpText.lineHeight = 1.4
		jumpEmoji.x= 45
		jumpEmoji.y= 36
		newTargetMessage()
		jumpArea.animate('drop').on Events.AnimationEnd, ->
			jumpArea.opacity = 0
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
	
for i in [0...5]
	newRandomReceivedMessage()
	newRandomSentMessage()


imFlow.on Events.DragStart, ->
	if keyboard.states.current.name == 'show'
		keyboardDown()
	
keyboardHitArea.on Events.Click, ->
	if bottomBar.states.current.name == 'normal' && !bottomBar.isAnimating
		bottomBar.animate('input').on Events.AnimationEnd, ->
			area.opacity = 0
			jumpText.fontSize = 15
			jumpText.width = 213
			jumpText.lineHeight = 1.2
			jumpEmoji.x= 63
			jumpEmoji.y= 32
			jumpArea.opacity = 1
			jumpArea.stateSwitch('initial')
			jumpText.stateSwitch('initial')
			
			
	else if bottomBar.states.current.name == 'input' && !bottomBar.isAnimating
		areaJump()

	
newButton.on Events.Click, ->
	newRandomReceivedMessage()

