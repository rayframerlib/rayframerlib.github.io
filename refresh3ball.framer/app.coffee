Framer.Extras.Hints.disable()
Framer.Extras.Preloader.enable()

mainScreen.clip = true
mainScreen.width = 375
mainScreen.height = 667
mainScreen.center()

iconContainer.clip = true

# ry = new Gradient
# 	start: "#FFAE00"
# 	end: "#FF3C00"
# 
# tip.gradient = ry

BodymovinLayer = require 'lottieLayer'
animLayer = new BodymovinLayer
	superLayer: feedContent
	jsonPath:'loading_rota.json'
	autoplay: false
	looping: true
	width: 100
	height: refreshIcon.height
	opacity: 0
	x: 137
	y: -60

marker = 0

tip.opacity = 0
tipBg.width = 0
tipBg.x = 187.5

feedContent.draggable.enabled = true
feedContent.draggable.speedX = 0

feedContent.draggable.constraints = 
	x: 0
	y: mainScreen.height - navigationBar.height - feedContent.height
	width: 375
	height: 2 * feedContent.height - (mainScreen.height - navigationBar.height)

feedContent.on "change:y", ->
	picNum = Math.round(Utils.modulate(feedContent.y, [24, 80], [0, 59], true))
	refreshIcon.image = "images/drag/drag_#{picNum}.png"

positionBack = (m)->
	Utils.delay 2, ->
		if m == marker
			animLayer.anim.goToAndStop(0, true)
			animLayer.opacity = 0
			refreshIcon.opacity = 1
			tip.animate
				opacity: 1
				options:
					time: 0.40
					curve: Spring(damping: 1.00)
			tipBg.animate
				width: 375
				x: 0
				options:
					time: 0.40
					curve: Spring(damping: 1.00)
			feedContent.off "change:y"
			tipBg.on "change:width", ->
				picNum = Math.round(Utils.modulate(tipBg.width, [0, 375], [0, 9], true))
				refreshIcon.image = "images/back/back_#{picNum}.png"
	Utils.delay 3, ->
		if m == marker
			container.animate
				y: 64
				options:
					time: 0.50
					curve: Spring(damping: 1.00)
			tip.animate
				opacity: 0
				options:
					time: 0.40
					curve: Spring(damping: 1.00)
			refreshIcon.image = "null"
			container.on Events.AnimationEnd, ->
				container.off Events.AnimationEnd, ->
				refreshIcon.off "change:x"
				feedContent.on "change:y", ->
					picNum = Math.round(Utils.modulate(feedContent.y, [24, 80], [0, 59], true))
					refreshIcon.image = "images/drag/drag_#{picNum}.png"
				tip.opacity = 0
				tipBg.width = 0
				tipBg.x = 187.5
			
			
				

feedContent.on Events.DragEnd, ->
	if feedContent.y >= 60
		container.animate
			y: 94
			options:
				time: 0.50
				curve: Spring(damping: 1.00)
		marker = Utils.randomNumber(0,1)
		positionBack(marker)
		refreshIcon.opacity = 0
		animLayer.opacity = 1
		animLayer.anim.play()
		
