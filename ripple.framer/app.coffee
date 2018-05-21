mainScreen = new Layer
	width: 375
	height: 667
	backgroundColor: "white"

for i in[0...3]
	card = new Layer
		width: 218
		height: 300
		superLayer: mainScreen
		image: "images/2.png"
		shadowColor: "rgba(0, 0, 0, 0.3)"
		shadowBlur: 6
		borderRadius: 8
	card.center()
	card.y += i * 20
	card.scale += i*0.05

Utils.delay 1.4, ->
	for i in [0...3]
		mainScreen.subLayers[i].animate
			scale: mainScreen.subLayers[i].scale + 0.2
			options:
				time: 0.4
				curve: "ease-in-out"
				delay: (2 - i) * 0.05
	
Utils.delay 1.8, ->
	for i in [0...3]
		mainScreen.subLayers[i].animate
			scale: mainScreen.subLayers[i].scale - 0.2
			options:
				curve: "Spring(tension: 100, friction: 6, velocity: 0)"
				delay: (2 - i) * 0.05