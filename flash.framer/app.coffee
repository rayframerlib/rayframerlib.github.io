BodymovinLayer = require 'lottieLayer'
ratio = window.devicePixelRatio

#Set up layers
mainScreen = new Layer
	width: 375 * ratio
	height: 667 * ratio
	clip: true
	backgroundColor: "white"

bg = new Layer
	superLayer: mainScreen
	width: 375 * ratio
	height: 667 * ratio
	image: "images/bg.png"

emotion1 = new BodymovinLayer
	superLayer: bg
	x: 300 * ratio
	y: 30 * ratio
	jsonPath:'flash.json'
	autoplay: true
	looping: true
	width: 24 * ratio
	height: 24 * ratio

mainScreen.center()
