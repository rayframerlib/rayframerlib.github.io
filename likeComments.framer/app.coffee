# Import file "forframer"
skt = Framer.Importer.load("imported/forframer@2x", scale: 1)
BodymovinLayer = require 'lottieLayer'

skt.mainScreen.clip = true
skt.mainScreen.height = 667
skt.mainScreen.width = 375
skt.mainScreen.center()

animationOptionsExtend = 
	curve: Spring(damping: 1)
	time: 0.5

animationOptionsShow = 
	curve: Spring(damping: 1)
	time: 0.6

composerShow = false
commentAreaShow = false
likeEnabled = false

skt.AnimateArea.image = ""
skt.HitArea.image = ""
skt.LikeNumber.opacity = 0
skt.commentFunction.opacity = 0
skt.mask.opacity = 0
skt.commented.opacity = 0
skt.composer.y = skt.composer.y + skt.composer.height

skt.card.draggable.enabled = true
skt.card.draggable.speedX = 0

resetConstraints = ()->
	skt.card.draggable.constraints = 
		x: 0
		y: skt.mainScreen.height - skt.card.height - skt.tabBar.height
		width: 375
		height: 2 * skt.card.height - (skt.mainScreen.height - skt.navigationBar.height - skt.tabBar.height)

resetHeight = ()->
	skt.card.height = skt.card2.y + skt.card2.height

resetHeight()
resetConstraints()

likeAnim = new BodymovinLayer
	superLayer: skt.AnimateArea
	width: skt.AnimateArea.width
	height: skt.AnimateArea.height
	autoplay: false
	looping: false

skt.commentArea.states.extend = 
	y: skt.commentArea.y + 20
	opacity: 1
	animationOptions: animationOptionsExtend
	
skt.cardButton5.states.extend = 
	y: skt.cardButton5.y + 40
	animationOptions: animationOptionsExtend
	
skt.commentFunction.states.extend = 
	opacity: 1
	animationOptions: animationOptionsExtend

skt.card2.states.extend = 
	y: skt.card2.y + 40
	animationOptions: animationOptionsExtend

skt.composer.states.show = 
	y: skt.mainScreen.height - skt.composer.height
	animationOptions: animationOptionsShow

skt.mask.states.show = 
	opacity: 1
	animationOptions: animationOptionsShow

skt.HitArea.on Events.Click, ->
	if composerShow == false
		if likeEnabled == false
			likeAnim.anim.play()
			skt.LikeNumber.opacity = 1
			likeEnabled = true
			Utils.delay 1, ->
				commentAreaShow = true
				skt.commentArea.animate("extend")
				skt.cardButton5.animate("extend")
				skt.commentFunction.animate("extend")
				skt.card2.animate("extend")
	
		else
			likeAnim.anim.goToAndStop(0, true)
			likeEnabled = false
			skt.LikeNumber.opacity = 0

skt.commentArea.on Events.Click, ->
	if commentAreaShow && skt.unComment.opacity
		composerShow = true
		skt.mask.animate("show")
		skt.composer.animate("show")

skt.sendButton.on Events.Click, ->
	if composerShow
		composerShow = false
		skt.mask.animate "default", animationOptionsShow
		skt.composer.animate "default", animationOptionsShow
		skt.commented.opacity = 1
		skt.unComment.opacity = 0

skt.tabBar.on Events.Click, ->
	if composerShow == false
		skt.commented.opacity = 0
		skt.unComment.opacity = 1
		skt.mask.stateSwitch("default")
		skt.composer.stateSwitch("default")
		skt.commentArea.stateSwitch("default")
		skt.cardButton5.stateSwitch("default")
		skt.commentFunction.stateSwitch("default")
		skt.card2.stateSwitch("default")
