# Import file "forframer"
skt = Framer.Importer.load("imported/forframer@2x", scale: 1)

#init
skt.mainScreen.clip = true
skt.mainScreen.height = 667
skt.mainScreen.width = 375
skt.mainScreen.center()

skt.card4.opacity = 0
skt.card5.opacity = 0
skt.card6.opacity = 0

skt.extendText.opacity = 0

animationOptionsExtend = 
	curve: Spring(damping: 1)
	time: 0.5
	
skt.card.draggable.enabled = true
skt.card.draggable.speedX = 0

skt.card.height = skt.story.height + skt.cardHeader.height + skt.card1.height + skt.card2.height + skt.card3.height + skt.extendButton.height + 10 + skt.cg4.height

resetConstraints = ()->
	skt.card.draggable.constraints = 
		x: 0
		y: skt.mainScreen.height - skt.card.height - skt.tabBar.height
		width: 375
		height: 2 * skt.card.height - (skt.mainScreen.height - skt.navigationBar.height - skt.tabBar.height)

resetConstraints()


#animation group
skt.cg2.states.extend =
	y: skt.story.height + skt.cardHeader.height + skt.card4.height
	animationOptions: animationOptionsExtend

skt.cg3.states.extend = 
	y: skt.story.height + skt.cardHeader.height + skt.card4.height + skt.card5.height
	animationOptions: animationOptionsExtend

skt.extendButton.states.extend = 
	y: skt.story.height + skt.cardHeader.height + skt.card4.height + skt.card5.height + skt.card6.height
	animationOptions: animationOptionsExtend
	
skt.cg4.states.extend = 
	y: skt.story.height + skt.cardHeader.height + skt.card4.height + skt.card5.height + skt.card6.height + skt.extendButton.height + 10
	animationOptions: animationOptionsExtend
	
skt.card4.states.extend = 
	opacity: 1
	animationOptions: animationOptionsExtend

skt.card5.states.extend = 
	opacity: 1
	animationOptions: animationOptionsExtend

skt.card6.states.extend = 
	opacity: 1
	animationOptions: animationOptionsExtend

skt.extendArrow.states.extend = 
	rotation: -90
	animationOptions: animationOptionsExtend

extend = ()->
	skt.cg2.stateSwitch("extend")
	skt.cg3.stateSwitch("extend")
	skt.extendButton.stateSwitch("extend")
	skt.cg4.stateSwitch("extend")
	skt.card4.stateSwitch("extend")
	skt.card5.stateSwitch("extend")
	skt.card6.stateSwitch("extend")
	skt.extendArrow.stateSwitch("extend")
	skt.extendText.opacity = 1
	skt.defaultText.opacity = 0
	skt.card.height = skt.story.height + skt.cardHeader.height + skt.card4.height + skt.card5.height + skt.card6.height + skt.extendButton.height + 10 + skt.cg4.height
	resetConstraints()

skt.extendButton.on Events.Click, ->
	extend()

skt.tabBar.on Events.Click, ->
	skt.cg2.stateSwitch("default")
	skt.cg3.stateSwitch("default")
	skt.extendButton.stateSwitch("default")
	skt.cg4.stateSwitch("default")
	skt.card4.stateSwitch("default")
	skt.card5.stateSwitch("default")
	skt.card6.stateSwitch("default")
	skt.extendArrow.stateSwitch("default")
	skt.extendText.opacity = 0
	skt.defaultText.opacity = 1
	skt.card.height = skt.story.height + skt.cardHeader.height + skt.card1.height + skt.card2.height + skt.card3.height + skt.extendButton.height + 10 + skt.cg4.height
	skt.card.y = 64
	resetConstraints()
	