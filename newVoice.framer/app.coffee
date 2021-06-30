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
	time: 0.4
	
maxHeight = 125
maxX = 350
minX = 25

imFlow.draggable.enabled = true
imFlow.draggable.speedX = 0

# handlerOriginX = dragHandler.x
# handlerOriginY = dragHandler.y

dragArea.draggable.enabled = true
dragArea.draggable.constraints = 
	x: 0 
	y: 0
	width: 70
	height: 70
dragArea.draggable.overdragScale = 1
dragArea.draggable.bounceOptions =
	friction: 50,
	tension: 600,
	tolerance: 0.0001

dragArea.states.toDelete = 
	x: -120
	y: 0
	options:
		curve: 'ease-in-out'
		time: 0.3

dragArea.states.toConvert = 
	x: 112
	y: 0
	options:
		curve: 'ease-in-out'
		time: 0.3

# dragArea.toDelete = () ->
# 	dragArea.animate('toDelete')
# 	dragArea.draggable.enabled = false

dragArea.toConvert = () ->
	dragArea.animate('toConvert')
	dragArea.draggable.enabled = false

dragArea.ready = () ->
	dragArea.animate('toDelete')
	dragArea.draggable.enabled = true

eventDelegate = new Layer
	visible: false


changeHandler = () ->
	if dragArea.x <= -62.5
		eventDelegate.x = -1
	else if dragArea.x <= 62.5
		eventDelegate.x = 0
	else
		eventDelegate.x = 1


class SoundWave extends Layer
	constructor: (@options={}) ->
		@options.x ?= 0
		@options.y ?= 0
		@options.width ?= 162
		@options.height ?= 36
		@options.backgroundColor ?= 'transparent'
		super @options

class ButtonEffect extends Layer
	constructor: (@options={}) ->
		@options.x ?= 0
		@options.y ?= 0
		@options.width ?= 70
		@options.height ?= 70
		@options.backgroundColor ?= 'transparent'
		super @options
		
		@followUser = true
		
		blueGradient = new Gradient
			start: "rgba(0, 210, 220, 1)"
			end: "rgba(69, 151, 222, 0.75)"
			angle: 150
		
		redGradient = new Gradient
			start: "rgba(235, 74, 138, 1)"
			end: "rgba(229, 95, 95, 0.75)"
			angle: 150
		
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
			backgroundBlur: 10
		
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
		
		@shadowDimWrap = new Layer
			superLayer: @buttonWrap
			name: 'shadowDimWrap'
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
			shadowBlur: 24
			shadowColor: 'rgba(40, 207, 254, 0.0)'
			gradient: blueGradient
		
		@shadowRed = new Layer
			superLayer: @shadowRedWrap
			name: 'shadowRed'
			borderRadius: 22
			width: @options.width
			height: @options.height
			shadowY: 4
			shadowBlur: 24
			shadowColor: 'rgba(250, 97, 123, 0.0)'
			gradient: redGradient
		
		@shadowDim = new Layer
			superLayer: @shadowDimWrap
			name: 'shadowDim'
			borderRadius: 22
			width: @options.width
			height: @options.height
			shadowY: 4
			shadowBlur: 24
			shadowColor: 'rgba(250, 97, 123, 0.0)'
			gradient: blueGradient
		
		@soundWave = new SoundWave
			name: 'soundWave'
			superLayer: @buttonWrap
			y: 20
			opacity: 0.7
		
		
		@hint = new TextHint
			name: 'hint'
			superLayer: @buttonWrap
			y: 60
		
		@trash = new BodymovinLayer
			name: 'trash'
			superLayer: @buttonWrap
			jsonPath:'./assets/trash.json'
			y: 14
			width: 44
			height: 44
			autoplay: false
			looping: false
			opacity: 0.7
		
		@trash.centerX()
		
		_buttonWrap = @buttonWrap
		_buttonContent = @buttonContent
		_shadow = @shadow
		_shadowRed = @shadowRed
		_soundWave = @soundWave
		_hint = @hint
		_shadowWrap = @shadowWrap
		_shadowRedWrap = @shadowRedWrap
		_shadowDim = @shadowDim
		_shadowDimWrap = @shadowDimWrap
		_trash = @trash
		
		_shadow.states.extend = 
			shadowColor: 'rgba(40, 207, 254, 0.0)'
			options: 
				time: 0.8
				curve: 'linear'
		
		_shadow.states.shrink = 
			shadowColor: 'rgba(40, 207, 254, 0.0)'
			options: 
				time: 0.8
				curve: 'linear'
		
		_shadowRed.states.extend = 
			shadowColor: 'rgba(250, 97, 123, 0.0)'
			options: 
				time: 0.8
				curve: 'linear'
		
		_shadowRed.states.shrink = 
			shadowColor: 'rgba(250, 97, 123, 0.0)'
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
			_shadowDim.height = @height
		
		_buttonContent.on "change:width", ->
			_shadow.width = @width
			_shadowRed.width = @width
			_shadowDim.width = @width
		
		_buttonContent.on "change:y", ->
			_shadow.y = @y
			_shadowRed.y = @y
			_shadowDim.y = @y
		
		_buttonContent.on "change:x", ->
			_shadow.x = @x
			_shadowRed.x = @x
			_shadowDim.x = @x
		
		_buttonContent.on "change:borderRadius", ->
			_shadow.borderRadius = @borderRadius
			_shadowRed.borderRadius = @borderRadius
			_shadowDim.borderRadius = @borderRadius

		_buttonContent.states.extend = 
			x: 0
			y: 0
			opacity: 1
			height: 142
			width: @options.width
			backgroundColor: 'transparent'
			borderRadius: 22
			backgroundBlur: 5
			options: 
				time: 0.3
				curve: 'ease-in-out'
				
		_buttonContent.states.shrink = 
			x: 0
			y: 98
			opacity: 1
			height: 44
			width: @options.width
			borderRadius: 22
			backgroundColor: '#2B2C36'
			backgroundBlur: 5
		
		_buttonContent.states.toList = 
			x: 0
			y: 0
			opacity: 1
			height: 40
			width: 92
			borderRadius: 4
			backgroundColor: '#2B2C36'
			backgroundBlur: 5
			options: 
				time: 0.3
				curve: 'ease-in-out'
		
		_buttonContent.states.delete = 
			height: .1
			width: .1
			x: 135
			y: -18
			opacity: 0
			backgroundBlur: 5
			options: 
				time: 0.3
				curve: 'ease-in-out'
		
		_buttonContent.states.cancel = 
			height: 72
			width: 72
			x: 99
			y: -29
			borderRadius: 64
		
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
		
		_shadowDimWrap.states.show = 
			opacity: 1
			options: 
				time: 0.2
				curve: 'linear'
				
		_shadowDimWrap.states.vanish = 
			opacity: 0
			options: 
				time: 0.2
				curve: 'linear'
		
		_shadowDim.states.dim = 
			opacity: 0.85
			options:
				time: 0.2
				curve: 'linear'
		
		_shadowDim.states.normal = 
			opacity: 1
			options:
				time: 0.5
				curve: 'linear'
		
		_shadowDim.animate('dim')
		
		_shadowDim.on Events.AnimationEnd, ->
			if _shadowDim.states.current.name == 'dim'
				_shadowDim.animate('normal')
			else
				_shadowDim.animate('dim')
		
		
		_soundWave.states.extend = 
			x: 54
			y: 20
			opacity: 0.9
			scaleX: 1
			options: 
				time: 0.5
				curve: Spring(damping: 1)
		
		_soundWave.states.shrink = 
			x: 54
			y: 130
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
		
		_soundWave.states.cancel = 
			x: 54
			y: -10
			scaleY: 1
			scaleX: 1
			opacity: 1
			options: 
				time: 0.2
				curve: 'ease-in-out'	
		
		_soundWave.states.delete = 
			y: -44
			scaleY: 0
			opacity: 0
			options: 
				time: 0.2
				curve: 'ease-in-out'
		
		_soundWave.states.time = 
			x: 54
			y: 20
			opacity: 0
			scaleX: 1
			options: 
				time: 0.2
				curve: 'linear'

		_trash.states.normal = 
			y: 14
			opacity: 0.9
		
		_trash.states.cancel = 
			y: -15
			opacity: 0.9
		
		_trash.states.delete = 
			y: -30
			opacity: 0
			options:
				time: 0.1
				curve: 'ease-in-out'
		
		_soundWave.centerX()
	
	setButtonOffsetX: (x) ->
		if @followUser
			@buttonWrap.x = x
	
	setButtonOffsetY: (y) ->
		if @followUser
			@buttonWrap.y = y
	
	buttonWrapToMiddle: () ->
		@buttonWrap.animate
			x: 0
			y: -128
			options: 
				time: 0.25
				curve: 'ease-in-out'
		
	
	shrink: () ->
		@buttonContent.stateSwitch('shrink')
		@shadowWrap.stateSwitch('vanish')
		@shadowDimWrap.stateSwitch('vanish')
		@shadowRedWrap.stateSwitch('vanish')
		@soundWave.stateSwitch('shrink')
		@buttonWrap.y = 0
		@buttonWrap.x = 0
	
	extend: () ->
		main = this
		@buttonContent.animate('extend')
		@shadowRedWrap.animate('vanish')
		@trash.stateSwitch('normal')
		if @timeUp
# 			@soundWave.animate('time')
			@shadowWrap.animate('vanish')
			@shadowDimWrap.animate('show')
			for bar in @soundWave.children
				index = @soundWave.children.indexOf(bar)
				if  index < 29 && index > 3
					bar.stopAnimation()
				else
					bar.startAnimation()
					bar.max = 10
		else
			@soundWave.animate('extend')
			@shadowWrap.animate('show')
			@shadowDimWrap.animate('vanish')
			for bar in @soundWave.children
				bar.startAnimation()
				bar.max = 30
# 			@trash.anim.goToAndStop(0)
		
	
	deleteToExtend: () ->
		@followUser = true
		@shadowRedWrap.animate('vanish')
		@buttonContent.animate('extend')
		@trash.animate('normal')
		@soundWave.animate('extend')
# 		@trash.anim.setDirection(-1)
# 		@trash.anim.play()
		
		if @timeUp
			@hint.animate('time')
# 			@soundWave.animate('time')
			@hint.toTimeToSend()
			@shadowWrap.animate('vanish')
			@shadowDimWrap.animate('show')
			for bar in @soundWave.children
				index = @soundWave.children.indexOf(bar)
				if  index < 29 && index > 3
					bar.stopAnimation()
				else
					bar.startAnimation()
					bar.max = 10
		else
			@hint.animate('extend')
			@soundWave.animate('extend')
			@hint.toSend()
			@shadowWrap.animate('show')
			@shadowDimWrap.animate('vanish')
			for bar in @soundWave.children
				bar.startAnimation()
				bar.max = 30		
	
	toList: (message) ->
		main = this
		@followUser = false
		@shadowWrap.animate('vanish')
		@shadowRedWrap.animate('vanish')
		@shadowDimWrap.animate('vanish')
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
		@trash.animate('delete')
		@buttonContent.animate('extend')
		Utils.delay 0.2, ->
			main.shadowWrap.animate
				opacity: 0
				options:
					time: 0.1
					curve: 'linear'
			main.shadowRedWrap.animate
				opacity: 0
				options:
					time: 0.1
					curve: 'linear'
		@buttonContent.animate('delete').on Events.AnimationEnd, ->
			main.shrink()
			main.followUser = true
# 		@buttonWrap.animate('delete')
# 		@shadowWrap.animate('vanish')
# 		@shadowRedWrap.animate('vanish')
	
	cancel: () ->
		main = this
		@followUser = false
		@buttonContent.animate('cancel')
		@shadowRedWrap.animate('show').on Events.AnimationEnd, ->
			main.shadowWrap.animate('vanish')
			main.shadowDimWrap.animate('vanish')
		@hint.animate('cancel')
		@hint.toCancel()
		@trash.animate('cancel')
# 		@trash.anim.setDirection(1)
# 		@trash.anim.play()
		@soundWave.animate('cancel')
		for bar in @soundWave.children
			index = @soundWave.children.indexOf(bar)
			if !(index == 15 || index == 16 || index == 17)
				bar.stopAnimation()
			else
				bar.startAnimation()
				bar.max = 24
				
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		

effect.follow = false
effect.states.delete = 
	x: 36
	options:
		time: 0.3
		curve: 'ease-in-out'
		
effect.states.convert = 
	x: 269
	options:
		time: 0.3
		curve: 'ease-in-out'

effect.toDelete = () ->
	effect.animate('delete')

effect.toConvert = () ->
	effect.animate('convert')
	

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
			options:
				time: 0.2
		
		@message.states.show = 
			opacity: 1
			options:
				time: 0.2
		
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
		
		@timeToSend = new TextLayer
			superLayer: @
			text: '10 秒后自动发送'
			fontSize: 16
			color: 'rgba(255, 255, 255, .9)'
			opacity: 0
		
		@releaseToSend.center()
		@releaseToCancel.center()
		@tapToStart.center()
		@timeToSend.center()
		
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
		
		@timeToSend.animate
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
		
		@timeToSend.animate
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
		
		@timeToSend.animate
			opacity: 0
			options:
				time: 0.1
				curve: 'linear'
		
	toTimeToSend: () ->
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
			opacity: 0
			options:
				time: 0.1
				curve: 'linear'
		
		@timeToSend.animate
			opacity: 1
			options:
				time: 0.1
				curve: 'linear'

	jumpToTap: () ->
		@timeToSend.opacity = 0
		
		@releaseToSend.opacity = 0
		
		@releaseToCancel.opacity = 0
		
		@tapToStart.opacity = 1
# 
# effect = new ButtonEffect
# 	superLayer: mainScreen
# 	x: 152
# 	y: 667

# effect.placeBehind(voiceFrame)

# effect.shrink()

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
	
	return sent


setFlowConstrains()

flowAnimateToBottom()

mask.opacity = 0

mask.states.vanish = 
	opacity: 0
	options: 
		time: 0.3
		curve: 'ease-in'

mask.states.show =
	opacity: 1
	options: 
		time: 0.3
		
flowWraper.states.ready = 
	y: flowWraper.y - 200
	options: 
		time: 0.3

flowWraper.states.normal = 
	y: flowWraper.y
	options: 
		time: 0.3

dragArea.on "change:point", ->
# 	dragHandler.y = dragArea.y
	changeHandler()
	if effect.follow
		effect.animate
			x: dragArea.x + 156
			options: 
				time: 0.05
				curve: 'linear'
	effect.y = Utils.modulate(dragArea.y,[-1, 1], [-0.1, 0.1])  + 43



coreButtons.states.show = 
	opacity: 1
	y: 624
	options: 
		time: 0.2
		curve: 'ease-out'

coreButtons.states.vanish = 
	opacity: 0
	y: 812 
	options: 
		time: 0.2
		curve: 'ease-in'

buttonConverted.states.show = 
	opacity: 1
	options: 
		time: 0.3

buttonConverted.states.vanish = 
	opacity: 0
	options: 
		time: 0.3
		
buttonGroupReady.states.show = 
	opacity: 1
	options: 
		time: 0.3

buttonGroupReady.states.vanish = 
	opacity: 0
	options: 
		time: 0.3

buttonRecording.states.show = 
	opacity: 1
	options: 
		time: 0.3

buttonRecording.states.vanish = 
	opacity: 0
	options: 
		time: 0.3

convert.states.normal = 
	opacity: 1
	options: 
		time: 0.3

convert.states.weak = 
	opacity: 0.5
	options: 
		time: 0.3
		
toDelete.states.normal = 
	opacity: 1
	options: 
		time: 0.3

toDelete.states.weak = 
	opacity: 0.5
	options: 
		time: 0.3

# buttonConverted.stateSwitch('vanish')
# buttonRecording.stateSwitch('vanish')
# buttonGroupReady.stateSwitch('show')
coreButtons.stateSwitch('vanish')

buttonConverted.vanish = () ->
	buttonConverted.animate('vanish').on Events.AnimationEnd, ->
		buttonConverted.visible = false

buttonConverted.show = () ->
	buttonConverted.visible = true
	buttonConverted.animate('show')

buttonRecording.vanish = () ->
	buttonRecording.animate('vanish').on Events.AnimationEnd, ->
		buttonRecording.visible = false

buttonRecording.show = () ->
	buttonRecording.visible = true
	buttonRecording.animate('show')

buttonRecording.showDelete = () ->
	convert.animate('weak')
	toDelete.animate('normal')

buttonRecording.showConvert = () ->
	convert.animate('normal')
	toDelete.animate('weak')

buttonRecording.showNormal = () ->
	convert.animate('normal')
	toDelete.animate('normal')

buttonGroupReady.vanish = () ->
	buttonGroupReady.animate('vanish').on Events.AnimationEnd, ->
		buttonGroupReady.visible = false

buttonGroupReady.show = () ->
	buttonGroupReady.visible = true
	buttonGroupReady.animate('show')
		

coreButtons.show = () ->
	coreButtons.animate('show')
	buttonConverted.vanish()
	buttonRecording.vanish()
	buttonGroupReady.show()

coreButtons.vanish = () ->
	coreButtons.animate('vanish').on Events.AnimationEnd, ->
		buttonConverted.vanish()
		buttonRecording.vanish()
		buttonGroupReady.show()

coreButtons.recording = () ->
	buttonConverted.vanish()
	buttonRecording.show()
	buttonGroupReady.vanish()

coreButtons.convert = () ->
	buttonConverted.show()
	buttonRecording.vanish()
	buttonGroupReady.vanish()
		
backToKeyboard.on Events.Click, ->
	voiceExit()


eventDelegate.on "change:x", ->
	if @x == -1
		effect.follow = false
		effect.toDelete()
		buttonRecording.showDelete()
	if @x == 0
		effect.follow = true
		buttonRecording.showNormal()
	
	if @x == 1
		effect.follow = false
		effect.toConvert()
		buttonRecording.showConvert()
# 		effect.cancel()
# 		deleteHint.animate('delete')
# 		effect.buttonWrapToMiddle()
# 		
# 	else if @x == 0
# 		if dragArea.draggable.isDragging
# 			effect.deleteToExtend()
# 			deleteHint.animate('show')

# dragHandler.on "change:y", ->
# 	dragOffset = @y - 724
# 	targetOffset = Utils.modulate(dragOffset, [-120, 120], [-120, 120])
# 	effect.setButtonOffsetY(targetOffset)

# dragHandler.on "change:x", ->
# 	dragOffset = @x - 52
# 	targetOffset = Utils.modulate(dragOffset, [-500, 500], [-56, 56])
# 	effect.setButtonOffsetX(targetOffset)

mouseDownTimeOffset = 0

holdMessage = ''

dragArea.on Events.MouseDown, (event)->
	effect.follow = true
# 	effect.extend()
# 	mask.animate('show')
	coreButtons.recording()
	holdMessage = newTargetMessage()
# 	deleteHint.animate('show')

dragArea.on Events.MouseUp, (event)->
	if eventDelegate.x == -1
		coreButtons.show()
# 		dragArea.toDelete()
		holdMessage.destroy()
		messageAmount = imFlow.children.length
		imFlow.height = imFlow.children[messageAmount - 1].y + imFlow.children[messageAmount - 1].height + 20
		setFlowConstrains()
		flowAnimateToBottom()
# 		effect.toDelete()
# 		deleteHint.animate('vanish')

	else if eventDelegate.x == 0
		holdMessage.show()
		coreButtons.show()
# 		effect.toList(holdMessage)
# 		deleteHint.animate('vanish')
	else if eventDelegate.x == 1
		effect.toConvert()
		dragArea.toConvert()
		coreButtons.convert()
		dragArea.visible = false

voiceActive = () ->
	mask.animate('show')
	coreButtons.show()
	flowWraper.animate('ready')

voiceExit = () ->
	mask.animate('vanish')
	coreButtons.vanish()
	flowWraper.animate('normal')

	
entranceButton.on Events.Click, ->
	voiceActive()


cancel.on Events.Click, ->
	print 1
	coreButtons.show()
# 		dragArea.toDelete()
	holdMessage.destroy()
	messageAmount = imFlow.children.length
	imFlow.height = imFlow.children[messageAmount - 1].y + imFlow.children[messageAmount - 1].height + 20
	setFlowConstrains()
	flowAnimateToBottom()
		
