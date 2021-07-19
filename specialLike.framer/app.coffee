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
		@options.backgroundColor ?= '#161616'

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
	
	generateEffect: Utils.throttle 0.1, (event, superLayer)->
			generateX = event.point.x + Utils.randomNumber(-10, 10) - 150
			generateY = event.point.y + Utils.randomNumber(-10, 10) - 200
			generateRotation = Utils.randomNumber(-15, 15)
			likeEffect = new LikeAnimationPlayer
				superLayer: superLayer
				jsonPath: 'likeJson/normal.json'
				x: generateX
				y: generateY
				rotation: generateRotation
			
	doubleClickEvent: (event)->
		@generateEffect(event, @)
		
a = new VideoContent
	superLayer: videoContainer