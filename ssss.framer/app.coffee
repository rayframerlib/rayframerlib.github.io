BodymovinLayer = require 'lottieLayer'

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
coreTextContent = [
	'视',
	'频',
	'搜',
	'索',
	' ',
	'就',
	'在',
	'抖',
	'音'
]

coreText.text = ''

ges = new BodymovinLayer
	superLayer: mainScreen
	x: 270
	y: 400
	width: 100
	height: 100
	autoplay: false
	looping: false
	jsonPath: 'images/data.json'

clip = new VideoLayer
	superLayer: videoArea
	width: 403
	height: 716
	video: "images/aa.mp4"
	
clip.centerX()

clip.player.play()
# clip.player.muted = true
searchClip = new VideoLayer
	superLayer: textArea
	width: 264
	height: 64
	opacity: 1
	video: "images/%E5%9B%B0%E9%9A%BE%E6%9C%89%E4%B8%80%E4%B8%87clop.mp4"

searchClip.placeBehind(textMask)
searchClip.center()
searchClip.player.loop = true
searchClip.player.muted = true

button.clip = true

Utils.delay 8, ->
	texts.animate
		opacity: 0
		options: 
			time: 0.4
	(clip.animate
		opacity: 0
		options: 
			time: 0.3).on Events.AnimationEnd, ->
				videoFinished()

searchBar.clip = true
gradient.opacity = 1
searchBarGlow.clip = true
glowGradient.opacity = 1
textArea.clip = true

addCoreText = (i) ->
	Utils.delay i * 0.2 + Utils.randomNumber(0,0.2), ->
		coreText.text = coreText.text + coreTextContent[i]

coreTextType = () ->
	coreText.text = ''
	for i in [0...coreTextContent.length]
		addCoreText(i)

startGradientRotation = () ->
	(gradient.animate
		rotation: 360
		options:
			time: 2
			curve: 'linear').on Events.AnimationEnd, ->
				gradient.rotation = 0
				startGradientRotation()

startGlowGradientRotation = () ->
	(glowGradient.animate
		rotation: 360
		options:
			time: 4
			curve: 'linear').on Events.AnimationEnd, ->
				glowGradient.rotation = 0
				startGlowGradientRotation()

class FrontLightBall extends Layer
	constructor: (@options={}) ->
		@options.x ?= 0
		@options.y ?= 0
		@options.width ?= 1000
		@options.height ?= 1000
		@options.backgroundColor ?= 'transparent'
		
		super @options
		
# 		@center()
		
		_width = @options.width
		_height = @options.height
		randomSize = Utils.randomNumber(100, 200)
		randomStartX = Utils.randomNumber(0, _width)
		randomStartY = Utils.randomNumber(0, _height)
		
		@lightBall = new Layer
			superLayer: @
			size: randomSize
			x: randomStartX
			y: randomStartY
			image: 'images/half.png'
			opacity: 0
			borderRadius: randomSize / 2
			blur: 2
		
		@randomFlyAnimationX(@lightBall, @randomFlyAnimationX, @, @lightBallVanish, @options.width, @options.height, @options.x, @options.y)
		@randomFlyAnimationY(@lightBall, @randomFlyAnimationY, @, @lightBallVanish, @options.width, @options.height, @options.x, @options.y)
		@randomFlyAnimationOpacity(@lightBall, @randomFlyAnimationOpacity)

	randomFlyAnimationX: (lightBall, self, main, vanishMethod, width, height, x, y) ->
		targetOffsetX = Utils.randomChoice([Utils.randomNumber(70, 100), Utils.randomNumber(-70, -100)])
		time = Utils.randomNumber(2.5, 4.5)
		(lightBall.animate
			x: lightBall.x + targetOffsetX
			options: 
				time: time
				curve: 'ease-in-out').on Events.AnimationEnd, ->
					if -40 <= lightBall.x <= main.width + 40
						self(lightBall, self, main, vanishMethod, width, height, x, y)
					else
						vanishMethod(lightBall, main)
						lightBall = new FrontLightBall
							superLayer: frontBalls
							x: x
							y: y
							width: width
							height: height
	
	randomFlyAnimationY: (lightBall, self, main, vanishMethod, width, height, x, y) ->
		targetOffsetY = Utils.randomChoice([Utils.randomNumber(70, 100), Utils.randomNumber(-70, -100)])
		time = Utils.randomNumber(2.5, 4.5)
		(lightBall.animate
			y: lightBall.y + targetOffsetY
			options: 
				time: time
				curve: 'ease-in-out').on Events.AnimationEnd, ->
					if -40 <= lightBall.y <= main.height + 40
						self(lightBall, self, main, vanishMethod, width, height, x, y)
					else
						vanishMethod(lightBall, main)  
						lightBall = new FrontLightBall
							superLayer: frontBalls
							x: x
							y: y
							width: width
							height: height
						
		
	randomFlyAnimationOpacity: (lightBall, self) ->
		targetOpacity = Utils.randomNumber(0.5, 0. I )
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
			fontSize: 13
			fontWeight: 400
			color: 'rgba(229,219,255,0.4)'
			scale: 0
			opacity: 0
			backgroundColor: 'rgba(126,138,229,0.3)'
			borderColor: 'rgba(207,216,255,0.3)'
			borderWidth: 1
			borderRadius: 100
			padding:
				horizontal: 8
				vertical: 4
			shadowColor: 'rgba(207,216,255,0.4)'
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
			width: 1.5
			height: 1.5
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
		deg = Utils.randomNumber(0, 2*Math.PI)
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
				delay: 1
		
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

planetBreathUp = new Animation planetMedium,
	y: planetMedium.y - 10
	options:
		time: 2
		curve: "ease-in-out"

planetBreathDown = new Animation planetMedium,
	y: planetMedium.y
	options:
		time: 2
		curve: "ease-in-out"

planetBreathUp.start()

planetBreathUp.on Events.AnimationEnd, ->
	planetBreathDown.start()

planetBreathDown.on Events.AnimationEnd, ->
	planetBreathUp.start()

searchBreathUp = new Animation search,
	y: search.y - 3
	options:
		time: 1
		curve: "ease-in-out"

searchBreathDown = new Animation search,
	y: search.y
	options:
		time: 1
		curve: "ease-in-out"

searchBreathUp.start()

searchBreathUp.on Events.AnimationEnd, ->
	searchBreathDown.start()

searchBreathDown.on Events.AnimationEnd, ->
	searchBreathUp.start()

musicBreathUp = new Animation music,
	scale: 1.1
	options:
		time: 3
		curve: "ease-in-out"

musicBreathDown = new Animation music,
	scale: 1
	options:
		time: 3
		curve: "ease-in-out"

musicBreathUp.start()

musicBreathUp.on Events.AnimationEnd, ->
	musicBreathDown.start()

musicBreathDown.on Events.AnimationEnd, ->
	musicBreathUp.start()

# iconBreathUp = new Animation search,
# 	scale: 0.95
# 	options:
# 		time: 0.3
# 		curve: "ease-in-out"
# 
# iconBreathDown = new Animation search,
# 	scale: 1
# 	options:
# 		time: 1
# 		curve: "ease-in-out"
# 
# iconBreathUp.start()
# 
# iconBreathUp.on Events.AnimationEnd, ->
# 	iconBreathDown.start()
# 
# iconBreathDown.on Events.AnimationEnd, ->
# 	iconBreathUp.start()

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
	Utils.delay 1, ->
		startGenerateQuery()

startGenerateBackLight = () ->
	backLightBall = new BackLightBallCentral
		superLayer: backBalls
	Utils.delay 0.1, ->
		startGenerateBackLight()

planetTinyRotation = new Animation planetTinyContainer,
	rotation: 110
	options:
		time: 20
		curve: 'linear'

planetTinyShow = new Animation planetTinyContainer,
	opacity: 1
	options:
		time: 3
		curve: 'linear'

planetTinyVanish = new Animation planetTinyContainer,
	opacity: 0
	options:
		time: 3
		curve: 'linear'

planetTinyRotationStart = () ->
	planetTinyContainer.rotation= -45
	planetTinyContainer.opacity= 0
	planetTinyRotation.start()
	planetTinyRotation.on Events.AnimationEnd, ->
		planetTinyRotationStart()
	planetTinyShow.start()
	Utils.delay 17, ->
		planetTinyVanish.start()

planetTinyRotationStart()

planetMiniRotation = new Animation planetMiniContainer,
	rotation: -120
	options:
		time: 17
		curve: 'linear'

planetMiniShow = new Animation planetMiniContainer,
	opacity: 1
	options:
		time: 3
		curve: 'linear'

planetMiniVanish = new Animation planetMiniContainer,
	opacity: 0
	options:
		time: 3
		curve: 'linear'

planetMiniRotationStart = () ->
	planetMiniContainer.rotation= 50
	planetMiniContainer.opacity= 0
	planetMiniRotation.start()
	planetMiniRotation.on Events.AnimationEnd, ->
		planetMiniRotationStart()
	planetMiniShow.start()
	Utils.delay 14, ->
		planetMiniVanish.start()

planetMiniRotationStart()

ges.states.vanish =
	opacity: 0.3
	y: ges.y
	x: ges.x + 5
	options:
		curve: 'ease-in-out'
		time: 0.8

ges.states.show = 
	opacity: 1
	x: ges.x
	y: ges.y - 10
	options:
		curve: 'ease-in-out'
		time: 0.5


ges.stateSwitch('vanish')
ges.opacity = 0

gesBreath = () ->
	ges.animate('show')
	Utils.delay 0.35, ->
		ges.anim.goToAndStop(310) 
		ges.anim.play()
		Utils.delay 0.4, ->
			ges.animate('vanish').on Events.AnimationEnd, ->
				gesBreath()

button.width = 31
button.opacity = 0

gotoSearch = () ->
	icon.animate
		opacity: 0
		options: 
			time: 0.3
	
	button.animate
		opacity: 1
		width: 71
		options: 
			time: 0.4
			curve: 'ease-in-out'

videoFinished = () ->
	startGenerateQuery()
	startGenerateBackLight()
	startGradientRotation()
	startGlowGradientRotation()
	coreTextType()
	searchClip.player.play()
	gesBreath()
	Utils.delay 5, ->
# 		gotoSearch()
# 	lightBall1 = new FrontLightBall
# 		superLayer: frontBalls
# 		width: 200
# 		height: 200
# 	lightBall2 = new FrontLightBall
# 		superLayer: frontBalls
# 		x: 150
# 		y: 0
# 		width: 200
# 		height: 200
# 	lightBall3 = new FrontLightBall
# 		superLayer: frontBalls
# 		x: 0
# 		y: 600
# 		width: 200
# 		height: 200
# 	lightBall4 = new FrontLightBall
# 		superLayer: frontBalls
# 		x: 150
# 		y: 600
# 		width: 200
# 		height: 200
# 	lightBall5 = new FrontLightBall
# 		superLayer: frontBalls
# 		x: 70
# 		y: 300
# 		width: 200
# 		height: 2 00

# for i in [0...5]
# 	lightBall = new BackLightBall
# 		superLayer: frontBalls
# 		width: 375
# 		height: 120
