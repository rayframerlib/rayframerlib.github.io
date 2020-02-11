BodymovinLayer = require 'lottieLayer'

Framer.Extras.Hints.disable()

mainScreen.width = 414
mainScreen.height = 736

mainScreen.clip = true
mainScreen.centerY()
mainScreen.centerX()

if Screen.width < 414
	mainScreen.scale = Screen.width / 414

feedHandler.draggable.enabled = true
feedHandler.draggable.speedX = 0
feedHandler.draggable.constraints = 
	x: 0 
	y: mainScreen.height - bottomBar.height - feedHandler.height
	width: mainScreen.width 
	height: 2 * feedHandler.height - (mainScreen.height - navigationBar.height - bottomBar.height)

feedHandler.on "change:y", ->
	feed.y = feedHandler.y

keyQuery.textDecoration= "underline"

class AnimationPlayer extends BodymovinLayer
	constructor: (@options={}) ->
		@options.x ?= 0
		@options.y ?= 0
		@options.width ?= 414
		@options.height ?= 736
		@options.autoplay ?= true
		@options.looping ?= false
		@options.jsonPath ?= 'data.json'
		@options.destroyTimer ?= 1.6
		
		super @options
		
		Utils.delay @options.destroyTimer, (->
			@.destroy()).bind(@)

hitArea.on Events.Click, ->
	player = new AnimationPlayer
		superLayer: animationPlayerContainer
		width: 414
		height: 736
		destroyTimer: 3.2