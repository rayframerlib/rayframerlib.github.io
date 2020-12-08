Framer.Extras.Hints.disable()

mainScreen.width = 375
mainScreen.height = 812

mainScreen.clip = true
mainScreen.centerY()
mainScreen.centerX()

AnimateContinue = (animateOld, animateNew) ->
	animateOld.on Events.AnimationEnd, ->
		animateNew.start()

LayerDestroy = (layer, animate) ->
	animate.on Events.AnimationEnd, ->
		layer.destroy()	

LayerRotate = (layer, i) ->
	rotateRight = new Animation layer,
		rotation: 5
		options:
			time: 0.2
			curve: "ease-in-out"
	rotateLeft = new Animation layer,
		rotation: -5
		options:
			time: 0.2
			curve: "ease-in-out"
	rotateRight.on Events.AnimationEnd, ->
		rotateLeft.start()
	rotateLeft.on Events.AnimationEnd, ->
		rotateRight.start()
	Utils.delay Utils.randomNumber(0,0.2), ->
		rotateRight.start()

BlowUp = (mainLayer, subLayer, time, i, j) ->
	Utils.delay time/2 + i*0.2, ->
		subLayer.opacity = 1
		mainLayer.opacity = 0
		subLayer.animate
			opacity: 0
			x: Utils.randomNumber(10, 90) * Math.sin(2 * Math.PI * j / 10)
			y: Utils.randomNumber(10, 90) * Math.cos(2 * Math.PI * j / 10)
			options:
				time: 1
				curve: Spring(damping: 1)
		

down = () ->
	for i in [0...Math.round(375/15)]
		emoji = new Layer
			superLayer: area
			width: 36
			height: 36
			scale: Utils.randomNumber(0.7, 1)
			image: "images/laugh.png"
			x: Utils.randomNumber(-36, area.width)
			y: -36
		emojiDown = new Animation emoji,
			x: Utils.randomNumber(-32,375)
			y: area.height
			options:
				curve: Bezier.linear
				time: 5
				delay: i*0.2
		emojiDown.start()
		LayerRotate(emoji, i)
		LayerDestroy(emoji, emojiDown)

jump = () ->
	for i in [0...Math.round(375/15)]
		emoji = new Layer
			superLayer: area
			width: 36
			height: 36
			scale: Utils.randomNumber(0.7, 1)
			image: "images/laugh.png"
			x: Utils.randomNumber(-36, area.width)
			y: area.height + 36
		
		jumpX = Utils.randomNumber(-32,area.width)
		jumpHeight = Utils.randomNumber(0, mainScreen.height / 2)
		
		time = Math.sqrt((area.height - jumpHeight) * 2 / 120)
		
		emojiMove = new Animation emoji,
			x: jumpX
			options:
				time: time
				curve: 'linear'
				delay: i*0.2
		
		emojiJump = new Animation emoji,
			y: jumpHeight
			options:
				curve: 'ease-out'
				time: time / 2
				delay: i*0.2
		
		emojiFall = new Animation emoji,
			y: area.height + 36
			options:
				curve: 'ease-in'
				time: time / 2
		
		emojiMove.start()
		emojiJump.start()
		AnimateContinue(emojiJump, emojiFall)
# 		emojiJump.on Events.AnimationEnd, ->
# 			emojiFall.start()
		LayerRotate(emoji, i)
		LayerDestroy(emoji, emojiFall)

blow = () ->
	for i in [0...Math.round(375/20)]
		emoji = new Layer
			superLayer: area
			width: 36
			height: 36
			scale: Utils.randomNumber(0.7, 1)
			x: Utils.randomNumber(-36, area.width)
			y: area.height + 36
			backgroundColor: "transparent"
		
		mainEmoji = new Layer
			superLayer: emoji
			size: emoji.size
			image: "images/laugh.png"
		
		jumpX = Utils.randomNumber(-32,area.width)
		jumpHeight = Utils.randomNumber(0, mainScreen.height / 2)
		
		time = Math.sqrt((area.height - jumpHeight) * 2 / 120)
		
		emojiMove = new Animation emoji,
			x: jumpX
			options:
				time: time
				curve: 'linear'
				delay: i*0.2
		
		emojiJump = new Animation emoji,
			y: jumpHeight
			options:
				curve: 'ease-out'
				time: time / 2
				delay: i*0.2
		
		emojiFall = new Animation emoji,
			y: area.height + 36
			options:
				curve: 'ease-in'
				time: time / 2
		
		for j in [0...10]
			subEmoji = new Layer
				superLayer: emoji
				width: 18
				height: 18
				image: "images/laugh.png"
				rotation: Utils.randomNumber(0, 360)
				opacity: 0
			subEmoji.center()
			BlowUp(mainEmoji, subEmoji, time, i, j)
			
				
		emojiMove.start()
		emojiJump.start()
		AnimateContinue(emojiJump, emojiFall)
# 		emojiJump.on Events.AnimationEnd, ->
# 			emojiFall.start()
		LayerDestroy(emoji, emojiFall)

fallHitArea.on Events.Click, ->
	down()

jumpHitArea.on Events.Click, ->
	jump()

blowHitArea.on Events.Click, ->
	blow()
		
		