Framer.Extras.Hints.disable()

BodymovinLayer = require 'lottieLayer'

mainScreen.width = 375
mainScreen.height = 812

mainScreen.clip = true
mainScreen.centerY()
mainScreen.centerX()

clickEffect = new BodymovinLayer
	superLayer: mainScreen
	x: 330
	y: 403
	width: 30
	height: 30
	jsonPath: 'likeJson/click.json'
	autoplay: false
	looping: false

hotArea = new Layer
	superLayer: mainScreen
	x: 330
	y: 403
	width: 30
	height: 30
	backgroundColor: 'transparent'

hotArea.on Events.Click, ->
	clickEffect.anim.play()