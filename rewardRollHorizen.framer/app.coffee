Framer.Defaults.Animation = 
	time: 1.2
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

SingleListWidth = rewardContent1.subLayers[0].width

animate1 = (i) ->
	Utils.delay 2.5 * i, ->
		if i < 4
			rewardContent1.animate
					x: -SingleListWidth * (i + 3) + 2 * SingleListWidth
		else if i == 4
			rewardContent1.x = 0
			cycle1()

cycle1 = () ->
	for i in [0...rewardContent1.subLayers.length]
		animate1(i)
		

cycle1()

animate2 = (i) ->
	Utils.delay 2.5 * i, ->
		if i < 4
			rewardContent2.animate
					x: -SingleListWidth * (i + 3) + 2 * SingleListWidth
		else if i == 4
			rewardContent2.x = 0
			cycle2()

cycle2 = () ->
	for i in [0...rewardContent2.subLayers.length]
		animate2(i)
		
Utils.delay 0.4, ->
	cycle2()