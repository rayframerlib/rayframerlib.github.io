mainScreen = new Layer
	width: 375
	height: 667
	clip: true

bg = new Layer
	superLayer: mainScreen
	width: 375
	height: 667
	image: "images/IMG_1220.PNG"

mainScreen.center()

LayerDestroy = (layer, animate) ->
	animate.on Events.AnimationEnd, ->
		layer.destroy()	

LayerRotate = (layer, i) ->
	rotateRight = new Animation layer,
		rotation: 5
		options:
				time: 0.2
	Utils.delay i * 0.2, ->
		rotateRight.start()
	rotateLeft = new Animation layer,
		rotation: -5
		options:
				time: 0.2
	rotateRight.on Events.AnimationEnd, ->
		rotateLeft.start()
	rotateLeft.on Events.AnimationEnd, ->
		rotateRight.start()

mainScreen.on Events.Click, ->
	for i in [0...24]
		packet = new Layer
			superLayer: mainScreen
			width: 38
			height: 48
			scale: 0.8
			image: "images/pk.png"
			x: Utils.randomNumber(-32,375)
			y: -48
		packetDown = new Animation packet,
			x: Utils.randomNumber(-164,607)
			y: screen.height
			options:
				curve: Bezier.linear
				time: 3
				delay: i*0.2
		packetDown.start()
		LayerRotate(packet, i)
		LayerDestroy(packet, packetDown)