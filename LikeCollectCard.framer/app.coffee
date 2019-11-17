Framer.Defaults.Animation =
	curve: Spring(damping: 1)
	time: 0.4

#getSuperPoint 获取一个图层在目标图层位置的方法
getSuperPoint = (layer, targetLayer = null, lastPoint = [0, 0]) ->
	if layer.superLayer.id == targetLayer.id
		return [lastPoint[0] + layer.x, lastPoint[1] + layer.y]
	else
		lastPoint = [lastPoint[0] + layer.x, lastPoint[1] + layer.y]
		getSuperPoint(layer.superLayer, targetLayer, lastPoint)

positionSaver =
	x: 0
	y: 0

saverSetter = (point) ->
	positionSaver.x = point[0]
	positionSaver.y = point[1]

class CardBulb extends Layer
	constructor: (@options={}) ->
		
		@options.x ?= 0
		@options.y ?= 0
		@options.width ?= 30
		@options.height ?= 42
		@options.backgroundColor ?= 'transparent'
# 		@options.collectTargetX ?= 0
# 		@options.collectTargetY ?= 0 
		
		super @options
		
# 		@computedX = @options.collectTargetX - @x
# 		@computedY = @options.collectTargetY - @y
	
		@bulb = new Layer
			name: 'bulb'
			superLayer: @
			width: @width
			height: @height
			y: @height / 2
			opacity: 0
		
		@popUpAnimation = new Animation @bulb,
			y: 0
			opacity: 1
		
# 		@collectAnimation = new Animation @bulb,
# 			x: @computedX
# 			opacity: 0
	
	pop: ->
		_popUpAnimation = @popUpAnimation
# 		_collect = @collect.bind(this)
		_popUpAnimation.start()
		superPoint = getSuperPoint(@bulb, mainScreen)
		saverSetter(superPoint)
# 		_bulb = @bulb
# 		_bulb.on Events.Click, ->
# 			_collect()

# 	collect: ->
# 		_collectAnimation = @collectAnimation
# 		_bulb = @bulb
# 		_computedX = @computedX
# 		_computedY = @computedX
# 		_reset = @reset.bind(this)
# 		_collectAnimation.start()
# 		_bulb.on "change:x", ->
# 			yUnit = -Math.pow(Utils.modulate(@x, [0, _computedX], [-1, 3]), 2) + 1
# 			yPosition = Utils.modulate(yUnit, [0, -8], [0, _computedY], false)
# 			_bulb.y = yPosition

# 		@collectAnimation.on Events.AnimationEnd, ->
# 			_bulb.off "change:x"
# 			_bulb.off Events.Click
# 			@off Events.AnimationEnd
# 			_reset()
	
	reset: ->
		@bulb.x = 0
		@bulb.y = @height / 2
		@bulb.opacity = 0

class Jumper extends Layer
	constructor: (@options = {}) ->
		@options.x ?= 0
		@options.y ?= 0
		@options.width ?= 43
		@options.height ?= 43
		@options.borderRadius ?= 50
		@options.recall ?= null

		super @options
		this.jump = this.jump.bind(this)
		@originalLayer = this.superLayer
	
	jump: () ->
		superPoint = getSuperPoint(this, mainScreen)
		this.opacity = 1
		this.x = superPoint[0]
		this.y = superPoint[1]
		this.superLayer = mainScreen
		jumpTime = 0.45
		vanishTime = 0.3

		animateY = new Animation this,	
			y: 32
			options:
				time: jumpTime
				curve: "ease-in-out"
		
		animateY.on Events.AnimationStart, (() ->
			originX = this.x
			originY = this.y
			this.on "change:y", ->
				yToFunction = Utils.modulate(this.y, [originY, 36],[-2, 0], true)
				this.x = Utils.modulate(Math.sqrt(1 - Math.pow(yToFunction, 2) / 4), [0, 1], [originX, 148])
			).bind(this)
		
		animateY.on Events.AnimationEnd, (() ->
			this.off "change:y"
			).bind(this)
		animateY.start()
		
		animateScaleIn = this.animate
			scale: 1.4
			options:
				time: jumpTime / 2
				curve: 'ease-out'
		
		animateScaleIn.on Events.AnimationEnd, (() ->
			animateScaleOut = this.animate
				scale: 1
				options:
					time: jumpTime / 2
					curve: 'ease-in'
			).bind(this)
		
		animateY.on Events.AnimationEnd, (()->
			animateVanish = this.animate
				scale: 0
				opacity: 0
				options:
					time: vanishTime
					curve: 'ease-out'
			Utils.delay vanishTime + 0.02, (()->
				this.superLayer = @originalLayer
				this.x = 0
				this.y = 0
				this.scale = 1
				if this.options.recall != null
					this.options.recall()
				).bind(this)
			).bind(this)

feed.draggable.enabled = true
feed.draggable.speedX = 0
feed.draggable.constraints = 
	x: 0 
	y: mainScreen.height - bottomBar.height - feed.height
	width: mainScreen.width 
	height: 2 * feed.height - (mainScreen.height - navigationBar.height - bottomBar.height)

popBehave = (layer,cardBulb) ->
	layer.on Events.Click, ->
		cardBulb.pop()

for layer in buttons.subLayers
	cardBulb = new CardBulb
		superLayer: layer
		x: 50
		y: -42
		width: 30
		height: 42
		setMethod: saverSetter
		
	popBehave(layer,cardBulb)

feed.on Events.DragStart, ->
	for layer in buttons.subLayers
		layer.subLayers[0].reset()
		