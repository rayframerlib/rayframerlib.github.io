BodymovinLayer = require 'lottieLayer'

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
# 			x: @options.x - 50
			opacity: 0
		
		@.states.show = 
			x: @options.x
			opacity: 1
# 			options:
# 				curve: Spring(damping: 1)
# 				time: 0.6
		
		@init()
	
	init: () ->
		@.height = @content.height
		@.stateSwitch('initial')
	
	show: () ->
		@.animate('show')

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
# 			x: @options.x + 50
			opacity: 0	
		
		@.states.show = 
			x: @options.x
			opacity: 1
	
# 			options:
# 				curve: Spring(damping: 1)
# 				time: 0.6
		
		@init()
	
	init: () ->
		@.height = @content.height
		@.stateSwitch('initial')
	
	show: () ->
		@.animate('show')

class SentHeart extends Layer
	
	constructor: (@options={}) ->
		@options.x ?= 0
		@options.y ?= 0
		@options.width ?= 307
		@options.height ?= 50
		@options.avatar ?= '' 
		@options.backgroundColor ?= 'transparent'
		@type = 'heart'
		
		super @options
		
		@senderAvatar = new Layer
			superLayer: @ 
			y: 7
			x: 271
			width: 36
			height: 36
			image: @options.avatar
		
		@playerContainer = new Layer
			superLayer: @
			x: 213
			width: 50
			height: 50
			backgroundColor: 'transparent'
			

		@player = new BodymovinLayer
			superLayer: @playerContainer
			width: 120
			height: 120
			jsonPath: './assets/lightReply.json'
			looping: false
			autoplay: false
		
		@player.center()
		
		@.states.initial = 
# 			x: @options.x + 50
			opacity: 0	
		
		@.states.show = 
			x: @options.x
			opacity: 1
	
# 			options:
		
		@init()
		
		@.on Events.Click, ->
			@player.anim.goToAndPlay(0, true)
	
	init: () ->
		@.stateSwitch('initial')
		
	
	show: () ->
		@.animate('show')

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


heartButtonSend = () ->
	(heartButton.animate
		scale: 1.4
		y: heartButton.y - 20
		options: 
			time: 0.125
			curve: 'ease-in'
	).on Events.AnimationEnd, ->
		(heartButton.animate
			rotation: -30
			options:
				time: 0.15
				curve:'ease-in-out'
		).on Events.AnimationEnd, ->
			heartButton.animate
				rotation: 0
				options:
					time: 0.15
					curve:'ease-in-out'
		(heartButton.animate
			scale: 0.3
			y: heartButton.y - 66
			options:
				time: 0.3
				curve: 'ease-out'
		).on Events.AnimationEnd, ->
			heartButton.opacity = 0
	
	(heartButton.animate
		x: heartButton.x - 60
		options: 
			time: 0.425
			curve: 'ease-in-out'
	).on Events.AnimationEnd, ->
		Utils.delay 0.01, ->
			heartButton.y = 18
			heartButton.x = 335
			heartButton.animate
				scale: 1
				opacity: 1
				options:
					time: 0.3
					curve: Spring(damping: 0.6)


heartButtonActive = () ->
	heartButtonCore.animate
		scale: 1.7
		y: -30
		options: 
			time: 0.2
			curve: 'ease-in-out'

heartButtonNormal = () ->
	heartButtonCore.animate
		scale: 1
		y: 0
		options: 
			time: 0.125
			curve: 'ease-in-out'

newHeartMessage = () ->
	messageAmount = imFlow.children.length
	if messageAmount
		messagePositionY = imFlow.children[messageAmount-1].y + imFlow.children[messageAmount-1].height + 16
		if imFlow.children[messageAmount - 1].type == 'heart'
			imFlow.children[messageAmount - 1].player.anim.goToAndPlay(0, true)
			flowAnimateToBottom()
		else
			heartButtonSend()
			
			heart = new SentHeart 
				superLayer: imFlow
				x: 56
				y: messagePositionY
				avatar: './assets/sender_avatar_2.png'
			
			Utils.delay 0.3, ->
				heart.player.anim.play()
			
			heart.show()
			
			if imFlow.children[messageAmount].y + imFlow.children[messageAmount].height + 20 >=  bottomBar.y - navigationBar.height
				imFlow.height = imFlow.children[messageAmount].y + imFlow.children[messageAmount].height + 20
				setFlowConstrains()
				flowAnimateToBottom()
	else
		messagePositionY = 20
		heartButtonFloat()
		heart = new SentHeart 
			superLayer: imFlow
			x: 56
			y: messagePositionY
			avatar: './assets/sender_avatar_2.png'
		
		heart.show()



	

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
	
	

bottomBarHitArea.on Events.Click, ->
	keyboardUp()

imFlow.on Events.DragStart, ->
	if keyboard.states.current.name == 'show'
		keyboardDown()


keyboardHitArea.on Events.Click, ->
	newRandomSentMessage()

heartHandler.on Events.Click, ->
	newHeartMessage()

heartHandler.draggable.constraints = heartHandler.frame
heartHandler.draggable.enabled = false
heartHandler.draggable.overdragScale = 1

heartHandler.on Events.LongPress, ->
	messageAmount = imFlow.children.length
	if messageAmount
		if imFlow.children[messageAmount - 1].type == 'heart'
		else
			heartHandler.draggable.enabled = true
			heartButtonActive()
	else
		heartHandler.draggable.enabled = true
		heartButtonActive()

heartHandler.on Events.LongPressEnd, ->
	heartButtonNormal()
	heartHandler.draggable.enabled = false
	heartHandler.x = 335
	heartHandler.y = 18

heartHandler.on "change:point", ->
	if heartHandler.draggable.isDragging
		heartButton.x = heartHandler.x
		heartButton.y = heartHandler.y
	
	
newButton.on Events.Click, ->
	newRandomReceivedMessage()

resetButton.on Events.Click, ->
	reset()

for i in [0...5]
	newRandomReceivedMessage()
