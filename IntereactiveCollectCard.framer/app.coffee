Framer.Extras.Hints.disable()

mainScreen.width = 414
mainScreen.height = 736

mainScreen.clip = true
mainScreen.center()

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

class CardCarrier extends Layer
	constructor: (@options={}) ->
		@options.x ?= 0
		@options.y ?= 0
		@options.width ?= 260
		@options.height ?= 435
		@options.backgroundColor ?= "transparent"
		
		@options.holderBackgroundColor ?= "#ff5555"
		@options.holderBackgroudImage ?= ''
		
		
		@options.cardWidth ?= 150
		@options.cardHeight ?= 200
		@options.cardX ?= (@options.width - @options.cardWidth)/2
		@options.cardY ?= 107
		@options.cardBackgroundColor ?= "ffbb22"
		@options.cardBackgroudImage ?= ''
		@options.collectTargetX ?= 0
		@options.collectTargetY ?= 0
		
		@options.coverWidth ?= @options.width
		@options.coverHeight ?= 100
		@options.coverX ?= 0
		@options.coverY ?= @options.height - 100
		@options.coverBackgroundColor ?= "#ff4444"
		@options.coverBackgroudImage ?= ''
		
		@options.screenWidth ?= 414
		@options.screenHeight ?= 736
		
		@options.buttonY ?= 500
		
		@options.buttonFunction ?= () -> return
		
		super @options
		
		@cardMask = new Layer
			superLayer: @
			x: -@options.x
			y: -@options.y
			width: @options.screenWidth
			height: @options.screenHeight
			backgroundColor: 'rgba(0, 0, 0, 0.45)'
		
		@cardHolder = new Layer
			superLayer: @
			x: 0
			y: 0
			width: @options.width
			height: @options.height
			backgroundColor: @options.holderBackgroundColor
			image: @options.holderBackgroudImage
		
		@card = new Layer
			superLayer: @
			x: @options.cardX
			y: @options.cardY
			z: 1000
			width: @options.cardWidth
			height: @options.cardHeight
			backgroundColor: @options.cardBackgroundColor
			image: @options.cardBackgroudImage
		
		@cardCoverCarrier = new Layer
			superLayer: @
			x: 0
			y: 0
			z: 2000
			width: @options.width
			height: @options.height
			backgroundColor: 'transparent'
						
		@cardCover = new Layer
			superLayer: @cardCoverCarrier
			x: @options.coverX
			y: @options.coverY
			height: @options.coverHeight
			width: @options.coverWidth
			backgroundColor: @options.coverBackgroundColor
			image: @options.coverBackgroudImage
		
		@cancelButton = new Layer
			superLayer: @
			width: 34
			height: 34
			y: @options.buttonY
			image: 'images/cancel.png'
		
		@cancelButton.centerX()
		
		@cardHolder.states.vanish =
			opacity: 0
			scale: 0
			options:
				time: 0.5
				curve: Spring(1)
		
		@cardHolder.states.show = 
			opacity: 1
			scale: 1
			options:
				time: 0.6
				curve: Spring(0.8)
		
		@cardHolder.states.collect = 
			opacity: 0
			scale: 0.8
			options:
				time: 0.2
				curve: 'ease-out'


		@card.states.vanish =
			x: @options.cardX
			y: @options.cardY
			opacity: 0
			scale: 0
			rotationY: 0
			rotationZ: 0
		
		@card.states.show = 
			x: @options.cardX
			y: @options.cardY 
			opacity: 1
			scale: 1
			rotationY: 0
			rotationZ: 0
			options:
				time: 0.9
				curve: Spring(0.6)
		
		@card.states.collectMove = 
			x: @options.cardX
			y: @options.cardY - 100
			opacity: 1
			scale: 1.2
			rotationY: 0
			rotationZ: 0
			options:
				time: 0.2
				curve: 'ease-out'
		
		@card.states.collectVanish = 
			x: @options.collectTargetX - @options.cardWidth / 2
			y: @options.collectTargetY - @options.cardHeight / 2
			opacity: 0
			scale: 0.1
			rotationY: 360
			rotationZ: 30
			options:
				time: 0.6
				curve: 'ease-in-out'
		
		@cardMask.states.vanish = 
			opacity: 0
			options:
				time: 0.3
				curve: 'linear'
				
		@cardMask.states.show = 
			opacity: 1
			options:
				time: 0.3
				curve: 'linear'
		
		@cancelButton.states.vanish = 
			opacity: 0
			options:
				time: 0.3
				curve: 'linear'
				
		@cancelButton.states.show = 
			opacity: 1
			options:
				time: 0.3
				curve: 'linear'
		
				
		@cardHolder.on "change:x", (->
			@cardCoverCarrier.x = @cardHolder.x
		).bind(@)
			
		@cardHolder.on "change:y", (->
			@cardCoverCarrier.y = @cardHolder.y
		).bind(@)
			
		@cardHolder.on "change:scale", (->
			@cardCoverCarrier.scale = @cardHolder.scale
		).bind(@)
			
		@cardHolder.on "change:opacity", (->
			@cardCoverCarrier.opacity = @cardHolder.opacity
		).bind(@)
		
		@cardCover.on Events.Click, (-> @options.buttonFunction()).bind(@)
		
		@cancelButton.on Events.Click, (->
			@collect()).bind(@)
			
		
	init: ->
		@cardHolder.stateSwitch('vanish')
		@card.stateSwitch('vanish')
		@cardMask.stateSwitch('vanish')
		@cancelButton.stateSwitch('vanish')
		
	show: ->
		@cardHolder.animate('show')
		@card.animate('show')
		@cardMask.animate('show')
		@cancelButton.animate('show')
		
	
	collect: ->
		@cancelButton.animate('vanish')
		@card.animate('collectMove').on Events.AnimationEnd, (->
			@cardMask.animate('vanish')
			@card.animate('collectVanish').on Events.AnimationEnd, (->
				@card.stateSwitch('vanish')
				).bind(@)
			).bind(@)
		@cardHolder.animate('collect').on Events.AnimationEnd, (->
				@cardHolder.stateSwitch('vanish')
			).bind(@)

content.image = 'images/feed.PNG'
subPage.image = 'images/sub.PNG'

mainPage.states.left = 
	x: -414
	options:
		time: 0.6
		curve: Spring(1)

mainPage.states.right = 
	x: 0
	options:
		time: 0.6
		curve: Spring(1)

subPage.states.left = 
	x: 0
	options:
		time: 0.6
		curve: Spring(1)

subPage.states.right = 
	x: 414
	options:
		time: 0.6
		curve: Spring(1)

toLandingPage = () ->
	mainPage.animate('left')
	subPage.animate('left')

toFeed = () ->
	mainPage.animate('right')
	subPage.animate('right')
	
subPage.stateSwitch('right')
	
carrier = new CardCarrier
	superLayer: mainPage
	x: -7
	y: 90
	width: 428
	height: 450
	collectTargetX: 396
	collectTargetY: 560
	coverX: 81
	coverY: 261
	coverWidth: 266
	coverHeight: 179
	cardWidth: 150
	cardHeight: 194
	cardY: 160
	holderBackgroudImage: 'images/cardBg.png'
	holderBackgroundColor: 'transparent'
	coverBackgroudImage: 'images/cover.png'
	coverBackgroundColor: 'transparent'
	cardBackgroudImage: 'images/card.png'
	cardBackgroundColor: 'transparent'
	buttonY: 480
	buttonFunction: toLandingPage
# carrier.center()
carrier.init()

navigationBar.on Events.Click, ->
	carrier.show()

subPage.on Events.Click, ->
	toFeed()
	carrier.init()

# bottomBar.on Events.Click, ->
# 	carrier.show()

# buttons.subLayers[0].on Events.Click, ->
# 	carrier.show()