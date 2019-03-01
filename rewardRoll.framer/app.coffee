Framer.Defaults.Animation = 
	time: 0.8
	curve: Spring(damping: 1)

mainScreen.width = 414
mainScreen.height = 736
mainScreen.center()

feed.draggable.enabled = true
feed.draggable.speedX = 0
feed.draggable.constraints = 
	x: 0
	y: -707
	width: 414
	height: 2 * 1396 - (736 - 65 - 47)

SingleListHight = rewardContent.subLayers[0].height

animate = (i) ->
	Utils.delay 1.5 * i, ->
		if i < 5
			rewardContent.animate
					y: -SingleListHight * (i + 3) + 2 * SingleListHight
		else if i == 5
			rewardContent.y = 0
			cycle()

cycle = () ->
	for i in [0...rewardContent.subLayers.length - 1]
		animate(i)
		

cycle()