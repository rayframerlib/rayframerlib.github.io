Framer.Extras.Hints.disable()

mainScreen.width = 375
mainScreen.height = 812

mainScreen.clip = true
mainScreen.centerY()
mainScreen.centerX()

testQueries = [
	'抗击疫情',
	'我的抗疫菜谱',
	'我的家乡菜',
	'爸爸妈妈农产品',
	'众志成城',
	'中国2021',
	'我们自己的故事',
	'2020年度总结',
	'我的2021',
]

searchBar.clip = true
gradient.opacity = 1
searchBarGlow.clip = true
glowGradient.opacity = 1

startGradientRotation = () ->
	(gradient.animate
		rotation: 360
		options:
			time: 5
			curve: 'linear').on Events.AnimationEnd, ->
				gradient.rotation = 0
				startGradientRotation()

startGlowGradientRotation = () ->
	(glowGradient.animate
		rotation: 360
		options:
			time: 5
			curve: 'linear').on Events.AnimationEnd, ->
				glowGradient.rotation = 0
				startGlowGradientRotation()


class FrontLightBall extends Layer
	constructor: (@options={}) ->
		@options.width ?= 1000
		@options.height ?= 1000
		@options.backgroundColor ?= 'transparent'
		
		super @options
		
		@center()
		
		_width = @options.width
		_height = @options.height
		randomSize = Utils.randomNumber(20, 40)
		randomStartX = Utils.randomNumber(0, _width)
		randomStartY = Utils.randomNumber(0, _height)
		
		@lightBall = new Layer
			superLayer: @
			size: randomSize
			x: randomStartX
			y: randomStartY
			opacity: 0
			borderRadius: randomSize / 2
			blur: 2
		
		@randomFlyAnimationX(@lightBall, @randomFlyAnimationX, @, @lightBallVanish)
		@randomFlyAnimationY(@lightBall, @randomFlyAnimationY, @, @lightBallVanish)
		@randomFlyAnimationOpacity(@lightBall, @randomFlyAnimationOpacity)
	
	randomFlyAnimationX: (lightBall, self, main, vanishMethod) ->
		targetOffsetX = Utils.randomChoice([Utils.randomNumber(70, 100), Utils.randomNumber(-70, -100)])
		time = Utils.randomNumber(2.5, 4.5)
		(lightBall.animate
			x: lightBall.x + targetOffsetX
			options: 
				time: time
				curve: 'ease-in-out').on Events.AnimationEnd, ->
					if -40 <= lightBall.x <= main.width + 40
						self(lightBall, self, main, vanishMethod)
					else
						vanishMethod(lightBall, main)
						lightBall = new FrontLightBall
							superLayer: frontBalls
							width: 375
							height: 375
	
	randomFlyAnimationY: (lightBall, self, main, vanishMethod) ->
		targetOffsetY = Utils.randomChoice([Utils.randomNumber(70, 100), Utils.randomNumber(-70, -100)])
		time = Utils.randomNumber(2.5, 4.5)
		(lightBall.animate
			y: lightBall.y + targetOffsetY
			options: 
				time: time
				curve: 'ease-in-out').on Events.AnimationEnd, ->
					if -40 <= lightBall.y <= main.height + 40
						self(lightBall, self, main, vanishMethod)
					else
						vanishMethod(lightBall, main)
						lightBall = new FrontLightBall
							superLayer: frontBalls
							width: 375
							height: 375
						
		
	randomFlyAnimationOpacity: (lightBall, self) ->
		targetOpacity = Utils.randomNumber(0.03, 0.08)
		time = Utils.randomNumber(0.2, 0.3)
		(lightBall.animate
			opacity: targetOpacity
			options: 
				time: time
				curve: 'ease-in-out').on Events.AnimationEnd, ->
					self(lightBall, self)
	
	lightBallVanish: (lightBall, main) ->
		targetOffsetX = Utils.randomNumber(-10, 10)
		targetOffsetY = Utils.randomNumber(-10, 10)
		(lightBall.animate
			x: lightBall.x + targetOffsetX
			y: lightBall.y + targetOffsetY
			opacity: 0
			options: 
				time: 0.3
				curve: 'ease-in-out').on Events.AnimationEnd, ->
					
					main.destroy()
					
		

class BackLightBall extends Layer
	constructor: (@options={}) ->
		@options.width ?= 1000
		@options.height ?= 1000
		@options.backgroundColor ?= 'transparent'
		
		super @options
		
		@center()
		
		_width = @options.width
		_height = @options.height
		randomSize = Utils.randomNumber(2, 5)
		randomStartX = Utils.randomNumber(0, _width)
		randomStartY = Utils.randomNumber(0, _height)
		
		@lightBall = new Layer
			superLayer: @
			size: randomSize
			x: randomStartX
			y: randomStartY
			opacity: 0
			borderRadius: randomSize / 2
			blur: 1
		
		@randomFlyAnimationX(@lightBall, @randomFlyAnimationX, @, @lightBallVanish)
		@randomFlyAnimationY(@lightBall, @randomFlyAnimationY, @, @lightBallVanish)
		@randomFlyAnimationOpacity(@lightBall, @randomFlyAnimationOpacity)
	
	randomFlyAnimationX: (lightBall, self, main, vanishMethod) ->
		targetOffsetX = Utils.randomChoice([Utils.randomNumber(70, 100), Utils.randomNumber(-70, -100)])
		time = Utils.randomNumber(2.5, 4.5)
		(lightBall.animate
			x: lightBall.x + targetOffsetX
			options: 
				time: time
				curve: 'ease-in-out').on Events.AnimationEnd, ->
					if -40 <= lightBall.x <= main.width + 40
						self(lightBall, self, main, vanishMethod)
					else
						vanishMethod(lightBall, main)
						lightBall = new BackLightBall
							superLayer: frontBalls
							width: 375
							height: 375
	
	randomFlyAnimationY: (lightBall, self, main, vanishMethod) ->
		targetOffsetY = Utils.randomChoice([Utils.randomNumber(70, 100), Utils.randomNumber(-70, -100)])
		time = Utils.randomNumber(2.5, 4.5)
		(lightBall.animate
			y: lightBall.y + targetOffsetY
			options: 
				time: time
				curve: 'ease-in-out').on Events.AnimationEnd, ->
					if -40 <= lightBall.y <= main.height + 40
						self(lightBall, self, main, vanishMethod)
					else
						vanishMethod(lightBall, main)
						lightBall = new BackLightBall
							superLayer: frontBalls
							width: 375
							height: 375
						
		
	randomFlyAnimationOpacity: (lightBall, self) ->
		targetOpacity = Utils.randomNumber(0.6, 0.9)
		time = Utils.randomNumber(0.2, 0.3)
		(lightBall.animate
			opacity: targetOpacity
			options: 
				time: time
				curve: 'ease-in-out').on Events.AnimationEnd, ->
					self(lightBall, self)
	
	lightBallVanish: (lightBall, main) ->
		targetOffsetX = Utils.randomNumber(-10, 10)
		targetOffsetY = Utils.randomNumber(-10, 10)
		(lightBall.animate
			x: lightBall.x + targetOffsetX
			y: lightBall.y + targetOffsetY
			opacity: 0
			options: 
				time: 0.3
				curve: 'ease-in-out').on Events.AnimationEnd, ->
					
					main.destroy()

class FlyingQuery extends Layer
	constructor: (@options={}) ->
		@options.width ?= 512
		@options.height ?= 512
		@options.backgroundColor ?= 'transparent'
		@options.text ?= '请输入Query'
		
		super @options
		
		@center()
		
		@query = new TextLayer
			superLayer: @
			text: "#{@options.text}"
			fontSize: 16
			fontWeight: 400
			color: 'rgba(255,255,255,0.5)'
			scale: 0
			opacity: 0
			backgroundColor: 'rgba(255,255,255,0.06)'
			borderRadius: 100
			padding:
				horizontal: 12
				vertical: 6
			shadowColor: 'rgba(255,255,255,0.2)'
			shadowBlur: 10
		
		@query.center()
		
		@randomFlyAnimation()
		

	randomFlyAnimation: () ->
		deg = Utils.randomChoice([Utils.randomNumber(Math.PI / 6, Math.PI * 5 / 6), Utils.randomNumber(-Math.PI / 6, -Math.PI * 5 / 6)])
		distance = Utils.randomNumber(100, 200)
		offsetX = distance * Math.cos(deg)
		offsetY = distance * Math.sin(deg)
		_mainFrame = @
		_query = @query
		_query.animate
			scale: 1
			x: @query.x + offsetX
			y: @query.y + offsetY
			options:
				time: 8
				curve: "ease-out"
		
		_query.animate
			opacity: 1
			options:
				time: 3
		
		Utils.delay 6, ->
			_query.animate
				opacity: 0
				options:
					time: 2
		
		Utils.delay 8, ->
			_mainFrame.destroy()
			
	

class BackLightBallCentral extends Layer
	constructor: (@options={}) ->
		@options.width ?= 512
		@options.height ?= 512
		@options.backgroundColor ?= 'transparent'
		@options.text ?= '请输入Query'
		
		super @options
		
		@center()
		
		@query = new Layer
			superLayer: @
			width: 3
			height: 3
			scale: 0
			opacity: 0
			backgroundColor: 'rgba(255,255,255,0.6)'
			borderRadius: 100
			blur: 0
			shadowColor: 'rgba(255,255,255,0.5)'
			shadowBlur: 3
		
		@query.center()
		
		@randomFlyAnimation()
		

	randomFlyAnimation: () ->
		deg = Utils.randomNumber(0, 360)
		distance = Utils.randomNumber(150, 400)
		offsetX = distance * Math.cos(deg)
		offsetY = distance * Math.sin(deg)
		_mainFrame = @
		_query = @query
		_query.animate
			scale: 1
			x: @query.x + offsetX
			y: @query.y + offsetY
			options:
				time: 8
				curve: "ease-out"
		
		_query.animate
			opacity: 1
			options:
				curve: 'ease-in-out'
				time: 2
				delay: 3
		
		Utils.delay 6, ->
			_query.animate
				opacity: 0
				options:
					time: 2
		
		Utils.delay 8, ->
			_mainFrame.destroy()

lightBreathUp = new Animation light,
	scale: 1.5
	options:
		time: 1.5
		curve: "ease-in-out"

lightBreathDown = new Animation light,
	scale: 1
	options:
		time: 1.5
		curve: "ease-in-out"

lightBreathUp.start()

lightBreathUp.on Events.AnimationEnd, ->
	lightBreathDown.start()

lightBreathDown.on Events.AnimationEnd, ->
	lightBreathUp.start()

ovalBreathUp = new Animation oval,
	scale: 1.05
	options:
		time: 1.5
		curve: "ease-in-out"

ovalBreathDown = new Animation oval,
	scale: 1
	options:
		time: 1.5
		curve: "ease-in-out"

ovalBreathUp.start()

ovalBreathUp.on Events.AnimationEnd, ->
	ovalBreathDown.start()

ovalBreathDown.on Events.AnimationEnd, ->
	ovalBreathUp.start()

searchBreathUp = new Animation search,
	scale: 0.98
	options:
		time: 2
		curve: "ease-in-out"

searchBreathDown = new Animation search,
	scale: 1
	options:
		time: 2
		curve: "ease-in-out"

searchBreathUp.start()

searchBreathUp.on Events.AnimationEnd, ->
	searchBreathDown.start()

searchBreathDown.on Events.AnimationEnd, ->
	searchBreathUp.start()

maskHandler = new Layer
	visible: false
	image: 'images/all.png'
	
maskAnime = new Animation maskHandler,
	x: 4.4
	options:
		time: 0.3
		curve: 'linear'

maskAnime.start()

maskAnime.on Events.AnimationEnd, ->
	maskHandler.x = -0.5
	maskAnime.start()

maskHandler.on "change:x", ->
	maskNum = Math.round(@x)
	@.y = maskNum

maskHandler.on "change:y", ->
	mask.x = -@.y * 375
	
startGenerateQuery = () ->
	query = new FlyingQuery
		superLayer: queryContainer
		text: Utils.randomChoice(testQueries)
	Utils.delay 1.5, ->
		startGenerateQuery()

startGenerateBackLight = () ->
	backLightBall = new BackLightBallCentral
		superLayer: backBalls
	Utils.delay 0.1, ->
		startGenerateBackLight()

for i in [0...5]
	lightBall = new FrontLightBall
		superLayer: frontBalls
		width: 375
		height: 375
	

startGenerateQuery()
startGenerateBackLight()
startGradientRotation()
startGlowGradientRotation()
# for i in [0...5]
# 	lightBall = new BackLightBall
# 		superLayer: frontBalls
# 		width: 375
# 		height: 120

