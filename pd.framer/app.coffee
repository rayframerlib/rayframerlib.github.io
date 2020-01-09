

mainScreen = new Layer
	width: 375
	height: 667
	clip: true

mainScreen.clip = true

bg = new Layer
	superLayer: mainScreen
	width: 375
	height: 667
	image: "images/IMG_1220.PNG"

area = new Layer
	superLayer: mainScreen
	width: 375
	y: 64
	height: 559
	clip: true
	backgroundColor: "transparent"



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

down1 = () ->
	down()

down = () ->
	mainScreen.off Events.Click
	Utils.delay 8, -> mainScreen.on Events.Click, -> down1()
	for i in [0...20]
		packet = new Layer
			superLayer: area
			width: 38
			height: 48
			scale: Utils.randomNumber(0.7,0.9)
			image: "images/pk.png"
			x: Utils.randomNumber(-32,375)
			y: -48
		
		packetDown = new Animation packet,
			x: Utils.randomNumber(-32,375)
			y: area.height
			options:
				curve: Bezier.linear
				time: 1.8
				delay: i*0.1
		packetDown.start()
		LayerRotate(packet, i)
		LayerDestroy(packet, packetDown)

mainScreen.on Events.Click, ->
	down()

		
		