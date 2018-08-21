Framer.Extras.Hints.disable()
mainScreen.clip = true
secondLevel.clip = true
dragDelegate.draggable.enabled = true
dragDelegate.draggable.speedX = 0
dragDelegate.draggable.constraints = {
	x: 0
	y: -385
	width: 375
	height: 1380
}

handlerDelegate.draggable.enabled = true
handlerDelegate.draggable.speedX = 0
handlerDelegate.draggable.constraints = {
	x: 0
	y: 0
	width: 375
	height: 20
}

content.draggable.enabled = true
content.draggable.speedX = 0
content.draggable.constraints = {
	x: 0
	y: -573
	width: 375
	height: 2000
}


handlerDelegate.on "change:y", ->
	dragDelegate.animateStop()
	if this.y > 0
		secondLevel.y = this.y + 65
	else
		secondLevel.y = 65

dragDelegate.on "change:y",->
	handlerDelegate.animateStop()
	if this.y <= 0
		sContent.y = dragDelegate.y + 20
		secondLevel.y = 65
	else
		secondLevel.y = dragDelegate.y + 65
		sContent.y = 20

dragDelegate.on Events.DragEnd, ->
	handlerDelegate.y = 0

dragDelegate.on Events.DragEnd, ->
	if secondLevel.y > 200
		secondGroup.animate
			y: 667
			options:
				time: 0.5
				curve: Spring(damping: 1.00)

handlerDelegate.on Events.DragEnd, ->
	if secondLevel.y > 170
		secondGroup.animate
			y: 667
			options:
				time: 0.5
				curve: Spring(damping: 1.00)

secondGroup.on Events.AnimationEnd, ->
	handlerDelegate.y = 0
	dragDelegate.y = 0

secondGroup.on "change:y", ->
	mask.opacity = Utils.modulate(secondGroup.y,[667, 0], [0, 1], false)
	
buttonArea.on Events.Click, ->
	secondGroup.animate
		y: 0
		options:
			time: 0.5
			curve: Spring(damping: 1.00)
	