BodymovinLayer = require 'lottieLayer'

Framer.Extras.Hints.disable()

mainScreen.width = 414
mainScreen.height = 736

mainScreen.clip = true
mainScreen.centerY()
mainScreen.centerX()

if Screen.width < 414
	mainScreen.scale = Screen.width / 414
mainScreen.y = (Screen.height - mainScreen.height) / 2

Framer.Defaults.Animation =
	curve: Spring(damping: 1)
	time: 1

feed.draggable.enabled = true
feed.draggable.speedX = 0
feed.draggable.constraints = 
	x: 0 
	y: mainScreen.height - bottomBar.height - feed.height
	width: mainScreen.width 
	height: 2 * feed.height - (mainScreen.height - navigationBar.height - bottomBar.height)

# content.image = 'images/feed.PNG'


class LikeButton extends Layer
	constructor: (@options={}) ->
		@options.x ?= 0
		@options.y ?= 0
		@options.width ?= 135
		@options.height ?= 35
		@options.backgroundColor ?= 'white'
		@options.startNumber ?= 100
		@options.activeFunc ?= () -> return
		
		super @options
		
		@.isHighlighted = false

		@icon = new Layer
			superLayer: @
			x: 42
			y: 8
			width: 18
			height: 18
			image: "images/IconArea_like@3x.png"
			
		@number = new TextLayer
			x: 64
			y: 8
			superLayer: @
			text: @options.startNumber
			fontSize: 14
			color: '#636363'
		
		_number = @number
		_icon = @icon
		_startNumber = @options.startNumber
		_activeFunc = @options.activeFunc
		
		@.on Events.Click, ->
			if @.isHighlighted
				_number.text = _startNumber
				_number.color = '#636363'
				_icon.image = "images/IconArea_like@3x.png"
				@.isHighlighted = false

			else
				_number.text = _startNumber + 1
				_number.color = '#e14123'
				_icon.image = "images/IconArea_like_highlighted@3x.png"
				@.isHighlighted = true
				_activeFunc()

class LikeAnimationPlayer extends BodymovinLayer
	constructor: (@options={}) ->
		@options.x ?= 0
		@options.y ?= 0
		@options.width ?= 200
		@options.height ?= 200
		@options.autoplay ?= true
		@options.looping ?= false
		@options.jsonPath ?= 'data.json'
		@options.destroyTimer ?= 1.6
		
		super @options
		
		@.center()
		
		Utils.delay @options.destroyTimer, (->
			@.destroy()).bind(@)
		

for layer in buttons.subLayers
	do (layer) ->
		button = new LikeButton
			superLayer: layer.subLayers[0]
			startNumber: Math.floor(Utils.randomNumber(100, 999))
			activeFunc: () ->
# 				if layer.subLayers.length == 1
# 					if layer.index == 0
# 						anim = new LikeAnimationPlayer
# 							superLayer: layer
# 							jsonPath: 'lottieJson/data_logo.json'
# 							destroyTimer: 1.1
# 					else if layer.index == 1
# 						anim = new LikeAnimationPlayer
# 							superLayer: layer
# 							jsonPath: 'lottieJson/like_ad.json'
# 							destroyTimer: 1.35
# 					else if layer.index == 2
				anim = new LikeAnimationPlayer
					superLayer: layer
					jsonPath: 'lottieJson/data_octopus_text.json'
					destroyTimer: 1.35
