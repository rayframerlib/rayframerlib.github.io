BodymovinLayer = require 'lottieLayer'

class VideoContent extends Layer
	constructor: (@options={}) ->
		@options.x ?= 0
		@options.y ?= 0
		@options.width ?= 375
		@options.height ?= 729

		super @options
		
		_self = @
		
		@isHot = false
		
		clearHot = Utils.debounce 0.35, ->
			_self.isHot = false
		
		_self.on Events.Click, ()->
			print _self.isHot
			if _self.isHot
				_self.doubleClickEvent()
				clearHot()
			else
				_self.isHot = true
				clearHot()
		
	doubleClickEvent: ()->


a = new VideoContent

class DoubleClickEffect extends Layer
	constructor: (@options={}) ->
		@options.x ?= 0
		@options.y ?= 0
		@options.width ?= 200
		@options.height ?= 200
		

b = new DoubleClickEffect