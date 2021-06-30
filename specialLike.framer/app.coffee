Framer.Extras.Hints.disable()

BodymovinLayer = require 'lottieLayer'

mainScreen.width = 375
mainScreen.height = 812

mainScreen.clip = true
mainScreen.centerY()
mainScreen.centerX()

class LikeAnimationPlayer extends BodymovinLayer
	constructor: (@options={}) ->
		@options.x ?= 0
		@options.y ?= 0
		@options.width ?= 300
		@options.height ?= 300
		@options.autoplay ?= true
		@options.looping ?= false
		@options.jsonPath ?= 'data.json'
		@options.destroyTimer ?= 2
		
		super @options
		
		Utils.delay @options.destroyTimer, (->
			@.destroy()).bind(@)

class VideoContent extends Layer
	constructor: (@options={}) ->
		@options.x ?= 0
		@options.y ?= 0
		@options.width ?= 375
		@options.height ?= 729

		super @options
		
		_self = @
		
		@isHot = false
		
		clearHot = Utils.debounce 0.4, ->
			_self.isHot = false
		
		_self.on Events.Click, (event)->
			if _self.isHot
				_self.doubleClickEvent(event)
				clearHot()
			else
				_self.isHot = true
				clearHot()
		
	doubleClickEvent: (event)->
		generateX = event.point.x + Utils.randomNumber(-10, 10) - 150
		generateY = event.point.y + Utils.randomNumber(-10, 10) - 250
		generateRotation = Utils.randomNumber(-15, 15)
		print generateX
		print generateY
		
		likeEffect = new LikeAnimationPlayer
			jsonPath: 'likeJson/earth.json'
			x: generateX
			y: generateY
			rotation: generateRotation


a = new VideoContent