mainScreen.clip = true
mainScreen.width = 375
mainScreen.height = 812
mainScreen.center()

page = new PageComponent
	width: mainScreen.width
	height: mainScreen.height
	scrollVertical: false

page.addPage(followFeed)
page.addPage(recommandFeed)

page.superLayer = mainScreen
page.placeBehind(hitArea)

minePage.draggable.enabled = true
minePage.draggable.speedY = 0
minePage.on Events.DragEnd, ->
	if minePage.x >= 60
		minePage.animate
			x: 375
			options: 
				time: 0.3
	else
		minePage.animate
			x: 0
			options: 
				time: 0.3

minePage.superLayer = mainScreen

minePage.x = 375

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


shadowChange.states.show = 
	width: shadowChange.width + 108
	x: shadowChange.x - 108
	options: 
		time: 0.25

shadowChange.states.vanish = 
	width: shadowChange.width
	x: shadowChange.x
	options: 
		time: 0.25

hintText.states.show = 
	opacity: 1
	options: 
		time: 0.2

hintText.states.vanish = 
	opacity: 0
	options: 
		time: 0.2

hintText.stateSwitch('vanish')

hitArea.on Events.TouchStart, ->
	shadowChange.animate('show')
	hintText.animate('show')

hitArea.on Events.TouchEnd, ->
	if !hitArea.draggable.isDragging
		minePage.show()
	shadowChange.animate('vanish')
	hintText.animate('vanish')

hitArea.on Events.DragEnd, ->
	if hitArea.x <= 250
		minePage.show()

back.on Events.Click, ->
	minePage.vanish()


hitArea.draggable.enabled = true
hitArea.draggable.overdragScale = 1
hitArea.draggable.constraints = 
		x: 311
		y: 268
		width: 64
		height: 180

hitArea.draggable.bounceOptions =
	friction: 100,
	tension: 2000,
	tolerance: 0.5

hitArea.on 'change:point', ->
	head.x = hitArea.x + 9