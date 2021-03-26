mainScreen.clip = true
mainScreen.width = 375
mainScreen.height = 812
mainScreen.center()

guide.backgroundColor = '#292929'
guide.borderRadius = 4
guide.padding = 6

page = new PageComponent
	width: mainScreen.width
	height: mainScreen.height
	scrollVertical: false

page.addPage(followFeed)
page.addPage(recommandFeed)
page.content.draggable.overdrag = false

page.superLayer = mainScreen
page.placeBehind(hitArea)

minePage.draggable.enabled = true
minePage.draggable.speedY = 0
minePage.draggable.constraints = 
	x: 0
	y: 0
	width: 750
	height: 812
minePage.draggable.overdrag = false
minePage.on Events.DragEnd, ->
	if minePage.x >= 60
		minePage.animate('vanish')
	else
		minePage.animate('show')

minePage.superLayer = mainScreen
minePage.width = 375
minePage.height = 812
minePage.x = 375
minePage.placeBehind(statusBar)

minePage.states.show =
	x: 0
	options:
		time: 0.25

minePage.states.vanish =
	x: 375
	options:
		time: 0.25

minePage.show = () ->
	minePage.animate('show')

minePage.vanish = () ->
	minePage.animate('vanish')

minePage.stateSwitch('vanish')

shadowChange.states.show = 
	opacity: 1
	options: 
		time: 0.25

shadowChange.states.vanish = 
	opacity: 0
	options: 
		time: 0.25

shadowChange.stateSwitch('vanish')

# hintText.states.show = 
# 	opacity: 1
# 	options: 
# 		time: 0.2

# hintText.states.vanish = 
# 	opacity: 0
# 	options: 
# 		time: 0.2

# hintText.stateSwitch('vanish')

hitArea.on Events.TouchStart, ->
	shadowChange.animate('show')
# 	hintText.animate('show')

hitArea.on Events.TouchEnd, ->
	shadowChange.animate('vanish')
# 	hintText.animate('vanish')

hitArea.on Events.DragEnd, ->
	shadowChange.animate('vanish')
	if hitArea.x <= 200
		minePage.show()

back.on Events.Click, ->
	minePage.vanish()


hitArea.draggable.enabled = true
hitArea.draggable.overdragScale = 1
hitArea.draggable.constraints = 
		x: 311
		y: 0
		width: 64
		height: 812

hitArea.draggable.bounceOptions =
	friction: 100,
	tension: 2000,
	tolerance: 0.5

page.content.on 'change:x', ->
	followTab.opacity = Utils.modulate(@x,[0, -375],[1, 0.5])
	recommandTab.opacity = Utils.modulate(@x,[0, -375],[0.5, 1])
	tabSlideBar.x = Utils.modulate(@x,[0, -375],[143, 208])

hitArea.on 'change:point', ->
	shadowChange.x = hitArea.x - 311
	if minePage.states.current.name == 'vanish'
		minePage.x = Utils.modulate((hitArea.x - 311 + 375),[375, 0],[375, -64])

guide.on Events.Click, ->
	(hitArea.animate
		x: 260
		options: 
			time: 0.4).on Events.AnimationEnd, ->
				(hitArea.animate
					x: 311
					options:
						time: 0.5).on Events.AnimationEnd, ->
						Utils.delay 3, ->
							shadowChange.animate('vanish')
	shadowChange.animate('show')