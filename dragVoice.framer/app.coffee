
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
	
maxHeight = 125
maxX = 350
minX = 25

imFlow.draggable.enabled = true
imFlow.draggable.speedX = 0

handlerOriginX = dragHandler.x
handlerOriginY = dragHandler.y

curveEffect.classList.add("svgBox")
curveEffect.html = """
	<svg viewBox='0 -72 375 375' version = "1.1">
		<linearGradient id="grad1" x1="0%" y1="0%" x2="0%" y2="100%">
			<stop offset="0%" style="stop-color:rgb(64, 66, 82);stop-opacity:1" />
			<stop offset="100%" style="stop-color:rgb(22, 24, 35);stop-opacity:1" />
		</linearGradient>
		<path id ="curve1" d ="M 0 0 q 187.5 0 375 0 l 0 98 l -375 0" fill="url(#grad1)"/>
	</svg>
"""

curveEffectCover.classList.add("svgBox")
curveEffectCover.html = """
	<svg viewBox='0 -72 375 375' version = "1.1">
		<linearGradient id="grad2" x1="0%" y1="0%" x2="0%" y2="100%">
			<stop offset="0%" style="stop-color:rgb(22, 24, 35);stop-opacity:1" />
			<stop offset="100%" style="stop-color:rgb(22, 24, 35);stop-opacity:1" />
		</linearGradient>
		<path id ="curve2" d ="M 0 0 q 187.5 0 375 0 l 0 98 l -375 0" fill="url(#grad2)"/>
	</svg>
"""


curveEffect.backgroundColor = "transparent"

dragEffect.states.vanish = 
	y: 740
	opacity: 0
	options: 
		time: 0.3
		curve: "ease-in-out"

dragEffect.states.show = 
	y: 642
	opacity: 1
	options: 
		time: 0.3
		curve: "ease-in-out"

dragEffect.stateSwitch("vanish")

light.states.show = 
	opacity: 1

light.states.vanish = 
	opacity: 0

curveEffectCover.states.show = 
	opacity: 1

curveEffectCover.states.vanish = 
	opacity: 0

curveEffectCover.stateSwitch('vanish')

popYHandler = () ->
	deltaY = 0
	if  handlerOriginY - dragArea.y >= 0
		deltaY = handlerOriginY - dragArea.y
	else 
		deltaY = 0
# 	print deltaY
	if voicePop.isSync
		voicePopWrap.y = -Utils.modulate(deltaY, [0, 812], [0, 250])

effectHandler = () ->
	xVal = dragHandler.x - handlerOriginX + 187.5
	yVal = Math.min(Math.max(dragHandler.y - handlerOriginY, -118), 0)
	document.querySelector('.svgBox #curve1').setAttribute('d','M 0 0 q '+xVal+' '+yVal+' 375 0 l 0 98 l -375 0')
	document.querySelector('.svgBox #curve2').setAttribute('d','M 0 0 q '+xVal+' '+yVal+' 375 0 l 0 98 l -375 0')
# 	print dragHandler.x - handlerOriginX
	light.x = dragHandler.x + 7
	light.y = yVal + Utils.modulate(yVal,[0, -118],[130, 200],false)
	
dragArea.draggable.enabled = true
dragArea.draggable.constraints = dragHandler.frame
dragArea.draggable.overdragScale = 1

eventDelegate = new Layer
	visible: false



changeHandler = () ->
	if dragArea.y >= 600
		eventDelegate.x = 0
		dragHandler.animate
			y: dragArea.y
			x: dragArea.x
			options: 
				time: 0.1
				curve: 'linear'
	else
		eventDelegate.x = 1


blueLight.states.vanish = 
	opacity: 0
	options: 
		time: 1
		curve: 'linear'
blueLight.states.show = 
	opacity: 1
	options: 
		time: 1
		curve: 'linear'

pinkLight.states.vanish = 
	opacity: 0
	options: 
		time: 1
		curve: 'linear'
pinkLight.states.show = 
	opacity: 1
	options: 
		time: 1
		curve: 'linear'

blueLight.stateSwitch('vanish')

class VoiceBar extends Layer
	constructor: (@options={}) ->
		@options.x ?= 0
		@options.y ?= 0
		@options.width ?= 2
		@options.height ?= 2
		@options.backgroundColor ?= 'white'
		@options.borderRadius ?= 1
		
		
		super @options
		
		@on Events.AnimationEnd, ->
			@startAnimation()
		
	startAnimation: () ->
		targetBarHeight = Utils.randomNumber(2, 18)
		targetBarY = @y - (targetBarHeight - @height)/2
		@animate
			y: targetBarY
			height: targetBarHeight
			options: 
				time: 0.1
				curve: 'linear'

class VoicePop extends Layer
	constructor: (@options={}) ->
		@options.width ?= 92
		@options.height ?= 40
		@options.backgroundColor ?= '#242630'
		@options.borderColor ?= 'rgba(255, 255, 255, 0.06)'
		@options.borderWidth ?= 1
		@options.borderRadius ?= 4
		@options.opacity ?= 0
		
		super @options
		
		@isSync = true
		
		@centerX()
		
		@redLayer = new Layer
			superLayer: @
			size: @.size
			borderRadius: @.borderRadius
			backgroundColor: 'CD2F1F'
			opacity: 0
		
		for i in [0...12]
			bar = new VoiceBar
				superLayer: @
				x: 4 * i + 23
			
			bar.centerY()
			bar.startAnimation()
			
	toDeleteState: () ->
		@redLayer.animate
			opacity: 1
			options: 
				time: 0.3
	
	toNormalState: () ->
		@redLayer.animate
			opacity: 0
			options: 
				time: 0.3
				
	popOut: () ->
		@centerX()
		@y = 772
		@opacity = 0
		@scaleX = 1
		@animate
			y: @y - 300
			opacity: 1
			options:
				time: 0.4
				curve: Spring(damping: 1)
	
	deleteState: () ->
		
		(@animate
			scaleX: 0
			opacity: 0
			options:
				time: 0.4
				curve: Spring(damping: 1)).on Events.AnimationEnd, -> voicePop.isSync = true
	
	sentState: (sent) ->
		mainLayer = @
		(@animate
			x: 224
			y: 660
			opacity: 1
			options: 
				time: 0.3
				curve: 'ease-in-out').on Events.AnimationEnd, ->
					sent.messageShow()
					mainLayer.animate
						opacity: 0
						options: 
							time: 0.4

class TextHint extends Layer
	constructor: (@options={}) ->
		@options.width ?= 120
		@options.height ?= 22
		@options.backgroundColor ?= 'transparent'
		@options.opacity ?= 0
		
		super @options
		
		@centerX()
		
		@releaseToSend = new TextLayer
			superLayer: @
			text: '松开发送'
			fontSize: 15
			color: 'rgba(255, 255, 255, 0.5)'
		
		@releaseToDelete = new TextLayer
			superLayer: @
			text: '松开取消发送' 
			fontSize: 15
			color: 'rgba(255, 255, 255, 0.5)'
			opacity: 0
		
		@releaseToSend.center()
		@releaseToDelete.center()
	
	show: () ->
		@animate
			opacity: 1
			time: 0.2
	
	vanish: () ->
		@animate
			opacity: 0
			time: 0.2
	
	deleteHint: () ->
		@releaseToSend.opacity = 0
		@releaseToDelete.opacity = 1
	
	sendHint: () ->
		@releaseToSend.opacity = 1
		@releaseToDelete.opacity = 0

class VoiceMessage extends Layer
	constructor: (@options={}) ->
		@options.width ?= 375
		@options.height ?= 40
		@options.backgroundColor ?= 'transparent'
		
		super @options
		
		@centerX()
		
		@Head = new Layer
			superLayer: @
			size: 36
			x: @width - 36 - 14
			image: './assets/sender_avatar.png'
			
		@message = new Layer
			superLayer: @
			width: 92
			height: 40
			x: @width - 92 - 58
			image: './assets/sent_voice.png'
		
		@Head.centerY()
		
		@states.vanish = 
			opacity: 0
		
		@states.show = 
			opacity: 1
			options: 
				time: 0.3
				curve: 'linear'
		
		@message.states.vanish = 
			opacity: 0
		
		@message.states.show = 
			opacity: 1
		
		@message.stateSwitch('vanish')
		@stateSwitch('vanish')
		
	show: () ->
		@animate('show')
	
	messageShow: () ->
		@message.animate('show')
		


a = new VoiceMessage



flowAnimateToBottom = () ->
	imFlow.animate
			y: (mainScreen.height - bottomBar.height) - imFlow.height
			options:
				time: 0.5
				curve: Spring(damping: 1)

setFlowConstrains = () ->
	imFlow.draggable.constraints = 
		x: 0
		y: bottomBar.y - imFlow.height
		width: mainScreen.width
		height: 2 * imFlow.height - (mainScreen.height -  bottomBar.height - navigationBar.height)

newTargetMessage = Utils.throttle 0.1, () ->
	messageAmount = imFlow.children.length
	if messageAmount
		messagePositionY = imFlow.children[messageAmount-1].y + imFlow.children[messageAmount-1].height + 16
		
	else
		messagePositionY = 1726
		
	sent = new VoiceMessage
		superLayer: imFlow
		y: messagePositionY
	
	if imFlow.children[messageAmount].y + imFlow.children[messageAmount].height + 20 >=  bottomBar.y - navigationBar.height
		imFlow.height = imFlow.children[messageAmount].y + imFlow.children[messageAmount].height + 20
		setFlowConstrains()
		flowAnimateToBottom()
		imFlow.animate
			y: bottomBar.y - imFlow.height
			options: 
				time: 0.35
				curve: Spring(damping: 1)
	
	sent.show()
# 	sent.children[1].opacity = 0
	return sent



setFlowConstrains()

# flowAnimateToBottom()

voicePopWrap = new Layer
	superLayer: mainScreen
	size: mainScreen.size
	backgroundColor: 'transparent'

voicePop = new VoicePop
	superLayer: voicePopWrap
	y: 772

textHint = new TextHint
	superLayer: voicePop
	y: 54


mask.opacity = 0

mask.states.vanish = 
	opacity: 0
	options: 
		time: 0.3

mask.states.show =
	opacity: 1
	options: 
		time: 0.3


dragArea.on "change:y", ->
	changeHandler()
	popYHandler()
			
dragArea.on "change:x", ->
	changeHandler()
	popYHandler()

eventDelegate.on "change:x", ->
	if @x == 1
		light.animate('vanish')
		curveEffectCover.animate('show')
		voicePop.toDeleteState()
		textHint.deleteHint()
		dragHandler.animate
			x: 52
			y: 724
	else if @x == 0
		light.animate('show')
		voicePop.toNormalState()
		textHint.sendHint()
		curveEffectCover.animate('vanish')

dragHandler.on "change:y", ->
	effectHandler()

dragHandler.on "change:x", ->
	effectHandler()

mouseDownTimeOffset = 0

dragArea.on Events.MouseDown, (event)->
	voicePop.popOut()
	mask.animate('show')
	dragEffect.animate('show')
	textHint.show()
		
dragArea.on Events.MouseUp, (event)->
	mask.animate('vanish')
	dragEffect.animate('vanish')
	voicePop.isSync = false
	textHint.vanish()
	if eventDelegate.x == 1
		voicePop.deleteState()
	else if eventDelegate.x == 0
		voicePop.isSync = true
		sent = newTargetMessage()
		voicePop.sentState(sent)
		
# 		voicePop.sentState()

# dragArea.on Events.LongPressEnd, ->
# 	mask.animate('vanish')
# 	dragEffect.animate('vanish')
# 	textHint.vanish()
# 	if eventDelegate.x == 1
# 		voicePop.deleteState()
# 	else if eventDelegate.x == 0
# 		voicePop.isSync = true
# 		sent = newTargetMessage()
# 		voicePop.sentState(sent)

pinkLight.on Events.AnimationEnd, ->
	if pinkLight.states.current.name == 'vanish'
		pinkLight.animate('show')
	else if pinkLight.states.current.name == 'show'
		pinkLight.animate('vanish')

blueLight.on Events.AnimationEnd, ->
	if blueLight.states.current.name == 'vanish'
		blueLight.animate('show')
	else if blueLight.states.current.name == 'show'
		blueLight.animate('vanish')

pinkLight.animate('vanish')
blueLight.animate('show')
