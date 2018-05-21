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
			scale: mainScreen.subLayers[i].scale - 0.3
			options:
				curve: "ease-in-out"
				time: 0.3
				delay: (2 - i) * 0.05

Utils.delay 2.1, ->
	for i in [0...3]
		mainScreen.subLayers[i].animate
			scale: mainScreen.subLayers[i].scale + 0.17
			options:
				curve: "ease-in-out"
				time: 0.3
				delay: (2 - i) * 0.05

Utils.delay 2.4, ->
	for i in [0...3]
		mainScreen.subLayers[i].animate
			scale: mainScreen.subLayers[i].scale - 0.12
			options:
				curve: "ease-in-out"
				time: 0.3
				delay: (2 - i) * 0.05

Utils.delay 2.7, ->
	for i in [0...3]
		mainScreen.subLayers[i].animate
			scale: mainScreen.subLayers[i].scale + 0.05
			options:
				curve: "ease-in-out"
				time: 0.3
				delay: (2 - i) * 0.05