
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

dragArea.draggable.enabled = true
dragArea.draggable.constraints = dragHandler.frame
dragArea.draggable.overdragScale = 1
dragArea.draggable.bounceOptions =
	friction: 50,
	tension: 600,
	tolerance: 0.0001

eventDelegate = new Layer
	visible: false

changeHandler = () ->
	if dragArea.y >= 550
		eventDelegate.x = 0
		
	else
		eventDelegate.x = 1

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
		targetBarHeight = Utils.randomNumber(2, 36)
		targetBarY = @y - (targetBarHeight - @height)/2
		@animate
			y: targetBarY
			height: targetBarHeight
			options: 
				time: 0.15
				curve: 'linear'

class SoundWave extends Layer
	constructor: (@options={}) ->
		@options.x ?= 0
		@options.y ?= 0
		@options.width ?= 166
		@options.height ?= 36
		@options.backgroundColor ?= 'transparent'
		super @options
		
		for i in [0...42]
			bar = new VoiceBar
				superLayer: @
				x: i * 4
			bar.centerY()
			bar.startAnimation()

class ButtonEffect extends Layer
	constructor: (@options={}) ->
		@options.x ?= 0
		@options.y ?= 0
		@options.width ?= 270
		@options.height ?= 142
		@options.backgroundColor ?= 'transparent'
		super @options
		
		@followUser = true
		
		blueGradient = new Gradient
			start: "rgba(148,242,255,1)"
			end: "rgba(26,143,208,.5)"
			angle: 180
		
		redGradient = new Gradient
			start: "rgba(255, 124, 150, 1)"
			end: "rgba(254, 44, 85, .5)"
			angle: 180
				
		
		@buttonWrap = new Layer
			name: 'buttonWrap'
			superLayer: @
			width: @options.width
			height: @options.height
			backgroundColor: 'transparent'
		
		@buttonContent = new Layer
			superLayer: @buttonWrap
			name: 'buttonContent'
			borderRadius: 22
			width: @options.width
			height: @options.height
			backgroundBlur: 5
			
		@shadowWrap = new Layer
			superLayer: @buttonWrap
			name: 'shadowWrap'
			borderRadius: 22
			width: @options.width
			height: @options.height
			backgroundColor: 'transparent'
		
		@shadowRedWrap = new Layer
			superLayer: @buttonWrap
			name: 'shadowRedWrap'
			borderRadius: 22
			width: @options.width
			height: @options.height
			backgroundColor: 'transparent'
		
		@shadow = new Layer
			superLayer: @shadowWrap
			name: 'shadow'
			borderRadius: 22
			width: @options.width
			height: @options.height
			shadowY: 4
			shadowBlur: 20
			shadowColor: 'rgba(80, 177, 226, .6)'
			gradient: blueGradient
		
		@shadowRed = new Layer
			superLayer: @shadowRedWrap
			name: 'shadowRed'
			borderRadius: 22
			width: @options.width
			height: @options.height
			shadowY: 4
			shadowBlur: 20
			shadowColor: 'rgba(255, 56, 95, .6)'
			gradient: redGradient
		
		@soundWave = new SoundWave
			name: 'soundWave'
			superLayer: @buttonWrap
			y: 20
		
		@hint = new TextHint
			name: 'hint'
			superLayer: @buttonWrap
			y: 60
		
		_buttonWrap = @buttonWrap
		_buttonContent = @buttonContent
		_shadow = @shadow
		_shadowRed = @shadowRed
		_soundWave = @soundWave
		_hint = @hint
		_shadowWrap = @shadowWrap
		_shadowRedWrap = @shadowRedWrap
		
		_shadow.states.extend = 
			shadowColor: 'rgba(80, 177, 226, .3)'
			options: 
				time: 0.8
				curve: 'linear'
		
		_shadow.states.shrink = 
			shadowColor: 'rgba(80, 177, 226, .9)'
			options: 
				time: 0.8
				curve: 'linear'
		
		_shadowRed.states.extend = 
			shadowColor: 'rgba(255, 56, 95, .3)'
			options: 
				time: 0.8
				curve: 'linear'
		
		_shadowRed.states.shrink = 
			shadowColor: 'rgba(255, 56, 95, .9)'
			options: 
				time: 0.8
				curve: 'linear'
		
		_shadow.animate('shrink')
		
		_shadowRed.animate('shrink')
		
		_shadow.on Events.AnimationEnd, ->
			if @states.current.name == 'shrink'
				@animate('extend')
			else
				@animate('shrink')
		
		_shadowRed.on Events.AnimationEnd, ->
			if @states.current.name == 'shrink'
				@animate('extend')
			else
				@animate('shrink')
		
		_buttonWrap.states.toList =
			x: 174
			y: 30
			options: 
				time: 0.3
				curve: 'ease-in-out'
		
		_buttonContent.on "change:height", ->
			_shadow.height = @height
			_shadowRed.height = @height
		
		_buttonContent.on "change:width", ->
			_shadow.width = @width
			_shadowRed.width = @width
		
		_buttonContent.on "change:y", ->
			_shadow.y = @y
			_shadowRed.y = @y

		_buttonContent.states.extend = 
			y: 0
			height: 142
			width: @options.width
			backgroundColor: 'transparent'
			borderRadius: 22
			options: 
				time: 0.3
				curve: 'ease-in-out'
				
		_buttonContent.states.shrink = 
			y: 98
			height: 44
			width: @options.width
			borderRadius: 22
			backgroundColor: '#2B2C36'
		
		_buttonContent.states.toList = 
			y: 0
			height: 40
			width: 92
			borderRadius: 4
			backgroundColor: '#2B2C36'
			options: 
				time: 0.3
				curve: 'ease-in-out'
		
		_buttonContent.states.delete = 
			height: 0
			y: 71
			options: 
				time: 0.3
				curve: 'ease-in-out'
		
		_shadowWrap.states.show = 
			opacity: 1
			options: 
				time: 0.2
				curve: 'linear'
				
		_shadowWrap.states.vanish = 
			opacity: 0
			options: 
				time: 0.2
				curve: 'linear'

				
		_shadowRedWrap.states.show = 
			opacity: 1
			options: 
				time: 0.2
				curve: 'linear'
				
		_shadowRedWrap.states.vanish = 
			opacity: 0
			options: 
				time: 0.2
				curve: 'linear'
		
		
		_soundWave.states.extend = 
			x: 52
			y: 20
			opacity: 1
			scaleX: 1
			options: 
				time: 0.5
				curve: Spring(damping: 1)
		
		_soundWave.states.shrink = 
			x: 52
			y: 116
			scaleY: 1
			scaleX: 1
			opacity: 0
		
		_soundWave.states.toList = 
			x: 10
			y: 10
			scaleY: 1
			scaleX: 0.4
			opacity: 0
			options: 
				time: 0.2
				curve: 'ease-in-out'
		
		_soundWave.states.delete = 
			y: 0
			scaleY: 0
			opacity: 0
			options: 
				time: 0.2
				curve: 'ease-in-out'
		
		_hint.states.extend = 
			x: 35
			y: 60
			opacity: 1
			options: 
				time: 0.5
				curve: Spring(damping: 1)
	
		_hint.states.shrink = 
			x: 35
			y: 103
			scaleY: 1
			opacity: 1
		
		_hint.states.toList =
			y: 12
			x: 0
			scaleY: 1
			opacity: 0
			optiones:
				time: 0.3
				curve: 'ease-in-out'
		
		_hint.states.delete =
			y: 0
			scaleY: 0
			opacity: 0
			optiones:
				time: 0.3
				curve: 'ease-in-out'
		
		_soundWave.centerX()
	
	setButtonOffsetX: (x) ->
		if @followUser
			@buttonWrap.x = x
	
	setButtonOffsetY: (y) ->
		if @followUser
			@buttonWrap.y = y
	
	shrink: () ->
		@buttonContent.stateSwitch('shrink')
		@shadowWrap.stateSwitch('vanish')
		@shadowRedWrap.stateSwitch('vanish')
		@soundWave.stateSwitch('shrink')
		@hint.stateSwitch('shrink')
		@hint.jumpToTap()
		@buttonWrap.y = 0
		@buttonWrap.x = 0
	
	extend: () ->
		main = this
		@buttonContent.animate('extend')
		@shadowWrap.stateSwitch('show')
		@shadowRedWrap.animate('vanish')
		@soundWave.animate('extend')
		@hint.animate('extend')
		@hint.toSend()
	
	toList: (message) ->
		main = this
		@followUser = false
		@shadowWrap.animate('vanish')
		@shadowRedWrap.animate('vanish')
		@buttonContent.animate('toList')
		@soundWave.animate('toList')
		@hint.animate('toList')
		message.show()
		@buttonWrap.animate('toList').on Events.AnimationEnd, -> 
			main.shrink()
			main.followUser = true
			message.messageShow()
	
	animateToShrink: () ->
		@buttonContent.animate('shrink')
		@shadowWrap.animate('vanish')
		@shadowRedWrap.animate('vanish')
		@soundWave.animate('shrink')
		@hint.animate('shrink')
		@hint.jumpToTap()
	
	toDelete: () ->
		main = this
		@followUser = false
		@soundWave.animate('delete')
		@hint.animate('delete')
		@buttonContent.animate('delete').on Events.AnimationEnd, ->
			main.shrink()
			main.followUser = true
# 		@buttonWrap.animate('delete')
# 		@shadowWrap.animate('vanish')
# 		@shadowRedWrap.animate('vanish')
	
	cancel: () ->
		main = this
		@shadowRedWrap.animate('show').on Events.AnimationEnd, ->
			main.shadowWrap.animate('vanish')
		@hint.toCancel()
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		

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
		@message.stateSwitch('show')
	
	

class TextHint extends Layer
	constructor: (@options={}) ->
		@options.width ?= 200
		@options.height ?= 32
		@options.backgroundColor ?= 'transparent'
			
		super @options
		
		@centerX()
		
		@releaseToSend = new TextLayer
			superLayer: @
			text: '松开发送，上划取消'
			fontSize: 15
			color: 'rgba(255, 255, 255, .7)'
			opacity: 0
		
		@releaseToCancel = new TextLayer
			superLayer: @
			text: '松开取消发送'
			fontSize: 15
			color: 'rgba(255, 255, 255, .7)'
			opacity: 0
		
		@tapToStart = new TextLayer
			superLayer: @
			text: '按住说话'
			fontSize: 15
			color: 'rgba(255, 255, 255, 1)'
			opacity: 1
		
		@releaseToSend.center()
		@releaseToCancel.center()
		@tapToStart.center()
		
		
	toSend: () ->
		@releaseToSend.animate
			opacity: 1
			options:
				time: 0.1
				curve: 'linear'
		
		@releaseToCancel.animate
			opacity: 0
			options:
				time: 0.1
				curve: 'linear'
		
		@tapToStart.animate
			opacity: 0
			options:
				time: 0.1
				curve: 'linear'
	
	toCancel: () ->
		@releaseToSend.animate
			opacity: 0
			options:
				time: 0.1
				curve: 'linear'
		
		@releaseToCancel.animate
			opacity: 1
			options:
				time: 0.1
				curve: 'linear'
		
		@tapToStart.animate
			opacity: 0
			options:
				time: 0.1
				curve: 'linear'

	toTap: () ->
		@releaseToSend.animate
			opacity: 0
			options:
				time: 0.1
				curve: 'linear'
		
		@releaseToCancel.animate
			opacity: 0
			options:
				time: 0.1
				curve: 'linear'
		
		@tapToStart.animate
			opacity: 1
			options:
				time: 0.1
				curve: 'linear'

	jumpToTap: () ->
		@releaseToSend.opacity = 0
		
		@releaseToCancel.opacity = 0
		
		@tapToStart.opacity = 1
		

# a = new VoiceMessage

effect = new ButtonEffect
	superLayer: mainScreen
	x: 53
	y: 626

effect.placeBehind(dragArea)

effect.shrink()
# effect.extend()


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
	
# 	sent.show()
# 	sent.children[1].opacity = 0
	return sent


setFlowConstrains()

flowAnimateToBottom()

mask.opacity = 0

mask.states.vanish = 
	opacity: 0
	options: 
		time: 0.3

mask.states.show =
	opacity: 1
	options: 
		time: 0.3

voiceButton.states.show = 
	opacity: 1
	options: 
		time: 0.2
		curve: 'linear'

voiceButton.states.vanish =
	opacity: 0
	options: 
		time: 0.2
		curve: 'linear'

voiceButton.stateSwitch('vanish')

dragArea.on "change:y", ->
	dragHandler.y = dragArea.y
	changeHandler()
			
dragArea.on "change:x", ->
	dragHandler.x = dragArea.x
	changeHandler()

eventDelegate.on "change:x", ->
	if @x == 1
		effect.cancel()
		
	else if @x == 0
		if dragArea.draggable.isDragging
			effect.extend()

dragHandler.on "change:y", ->
	dragOffset = @y - 724
	targetOffset = Utils.modulate(dragOffset, [-120, 120], [-100, 100])
	effect.setButtonOffsetY(targetOffset)

dragHandler.on "change:x", ->
	dragOffset = @x - 52
	targetOffset = Utils.modulate(dragOffset, [-500, 500], [-56, 56])
	effect.setButtonOffsetX(targetOffset)

mouseDownTimeOffset = 0

holdMessage = ''

dragArea.on Events.MouseDown, (event)->
	effect.extend()
	mask.animate('show')
	holdMessage = newTargetMessage()
	voiceButton.stateSwitch('vanish')
	

dragArea.on Events.MouseUp, (event)->
	mask.animate('vanish')
	
	if eventDelegate.x == 1
		holdMessage.destroy()
		messageAmount = imFlow.children.length
		imFlow.height = imFlow.children[messageAmount - 1].y + imFlow.children[messageAmount - 1].height + 20
		setFlowConstrains()
		flowAnimateToBottom()
		effect.toDelete()
		voiceButton.animate('show')
		
	else if eventDelegate.x == 0
		voiceButton.animate('show')
		effect.toList(holdMessage)
		
		
