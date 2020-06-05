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
	time: 0.55

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
		y: mainScreen.height - bottomBar.height - imFlow.height
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
			x: @options.x - 50
			opacity: 0
		
		@.states.show = 
			x: @options.x
			opacity: 1
			
		@content.states.initial = 
			rotation: 5
			x: @content.x - 50
			y: @content.y + 8
			
		@content.states.show =
			rotation: 0
			x: @content.x
			y: @content.y
# 			options:
# 				curve: Spring(damping: 1)
# 				time: 0.6
		
		@init()
	
	init: () ->
		@.height = @content.height
		@.stateSwitch('initial')
		@content.stateSwitch('initial')
	
	show: () ->
		@.animate('show')
		@content.animate('show')

# a = new ReceivedMessage
# 	x: 200
# 	y: 200


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
			x: @options.x + 50
			opacity: 0	
		
		@.states.show = 
			x: @options.x
			opacity: 1
		
		@content.states.initial = 
			rotation: -5
			x: @content.x + 50
			y: @content.y + 8
			
		@content.states.show =
			rotation: 0
			x: @content.x
			y: @content.y
# 			options:
# 				curve: Spring(damping: 1)
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

flowAnimateToBottom = () ->
	imFlow.animate
			y: (mainScreen.height - bottomBar.height) - imFlow.height

flowAnimateToTop = () ->
	imFlow.animate
		y: 302 + navigationBar.height
		
keyboard.states.initial = 
	y: mainScreen.height

keyboard.states.show = 
	y: mainScreen.height - keyboard.height

keyboard.stateSwitch('initial')

bottomBar.states.low = 
	y: bottomBar.y
	backgroundColor: 'rgba(22, 24, 35, 0.9)'
	
bottomBar.states.high = 
	y: mainScreen.height - keyboard.height - 64
	backgroundColor: 'rgba(255, 255, 255, 0.9)'

flowWraper.states.initial = 
	y: 0

flowWraper.states.keyboard = 
	y: -302

lightBar.states.vanish = 
	opacity: 0

lightBar.states.show = 
	opacity: 1

darkBar.states.vanish = 
	opacity: 0

darkBar.states.show = 
	opacity: 1

keyboardUp = () ->
	if keyboard.states.current.name == 'initial'
		keyboard.animate('show')
		bottomBar.animate('high')
		lightBar.animate('show')
		darkBar.animate('vanish')
		flowWraper.animate('keyboard')
		
		if imFlow.children.length
			visibleFlowHeight = imFlow.children[imFlow.children.length - 1].y + imFlow.children[imFlow.children.length - 1].height + 20
		else
			visibleFlowHeight = 0
			
		if visibleFlowHeight <= 413 - navigationBar.height
			flowAnimateToTop()
		else if visibleFlowHeight < 626
			imFlow.height = imFlow.children[imFlow.children.length - 1].y + imFlow.children[imFlow.children.length - 1].height + 20
			flowAnimateToBottom()
		else
			flowAnimateToBottom()

keyboardDown = () ->
	keyboard.animate('initial')
	bottomBar.animate('low')
	lightBar.animate('vanish')
	darkBar.animate('show')
	flowWraper.animate('initial')
	if imFlow.height < 626
		imFlow.height = 626
		imFlow.draggable.constraints.height = 626
		imFlow.draggable.constraints.y = 88
		flowAnimateToTop()

reset = () ->
	for i in [0...imFlow.children.length]
		imFlow.children[0].destroy()
	imFlow.height = mainScreen.height - navigationBar.height - bottomBar.height
	imFlow.y = navigationBar.height
	setFlowConstrains()
	keyboard.stateSwitch('initial')
	bottomBar.stateSwitch('low')
	lightBar.stateSwitch('vanish')
	darkBar.stateSwitch('show')
	flowWraper.stateSwitch('initial')
	
	

bottomBar.on Events.Click, ->
	keyboardUp()

imFlow.on Events.DragStart, ->
	if keyboard.states.current.name == 'show'
		keyboardDown()
	
keyboardHitArea.on Events.Click, ->
	newRandomSentMessage()
	
newButton.on Events.Click, ->
	newRandomReceivedMessage()

resetButton.on Events.Click, ->
	reset()

