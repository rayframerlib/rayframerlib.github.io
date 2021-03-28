mainScreen.clip = true
mainScreen.width = 375
mainScreen.height = 812
mainScreen.center()

recoverHandler = new Layer
recoverHandler.visible = false

activeHandler = new Layer
activeHandler.visible = false

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

tip.states.active = 
	scale: 1.1
	opacity: 1
	options: 
		time: 0.2

tip.states.show = 
	scale: 1
	opacity: 0.5
	options: 
		time: 0.2

tip.states.vanish = 
	scale: 0.5
	opacity: 0
	options: 
		time: 0.2

tip.stateSwitch('vanish')

shadowChange.backgroundColor = 'transparent'
shadowChange.classList.add("svgBox")
shadowChange.html = """
	<svg id='box' viewBox='0 0 375 812' version = "1.1">
		<linearGradient id="grad1" x1="0%" y1="0%" x2="100%" y2="0%">
			<stop offset="0%" style="stop-color:rgba(255, 255, 255, 0.34);stop-opacity:1" />
			<stop offset="100%" style="stop-color:rgb(255, 255, 255, 0);stop-opacity:1" />

		</linearGradient>
		<path id ="curve1" d ="M 375 0 q 0 364 0 728 l 0 0 l 0 -728" fill="url(#grad1)"/>
	</svg>
"""

shadowChange.states.show = 
	opacity: 1
	options: 
		time: 0.25

shadowChange.states.active = 
	opacity: 0.1
	options: 
		time: 0.2

shadowChange.states.vanish = 
	opacity: 0
	options: 
		time: 0.25
		
mask.states.show = 
	opacity: 1
	options: 
		time: 0.25

mask.states.vanish = 
	opacity: 0
	options: 
		time: 0.25

mask.stateSwitch('vanish')
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

hitArea.on Events.DragStart, ->
	if @draggable.direction != 'right'
		shadowChange.animate('show')
		tip.animate('show')
		mask.animate('show')
# 	hintText.animate('show')

hitArea.on Events.TouchEnd, ->
	
# 	hintText.animate('vanish')

hitArea.on Events.DragEnd, ->
	shadowChange.animate('vanish')
	mask.animate('vanish')
	if hitArea.x <= 200
# 		minePage.show()
		hitArea

back.on Events.Click, ->
	minePage.vanish()


hitArea.draggable.enabled = true
hitArea.draggable.overdragScale = 1
hitArea.draggable.constraints = 
		x: 0
		y: 0
		width: 375
		height: 812

hitArea.draggable.bounceOptions =
	friction: 100,
	tension: 2000,
	tolerance: 0.5

page.content.on 'change:x', ->
	followTab.opacity = Utils.modulate(@x,[0, -375],[1, 0.5])
	recommandTab.opacity = Utils.modulate(@x,[0, -375],[0.5, 1])
	tabSlideBar.x = Utils.modulate(@x,[0, -375],[143, 208])

lastPoint = [0,0]
lastDragPositon = [0,0]

hitArea.on Events.DragMove, (event) ->
	targetX = event.pointX
	targetY = event.pointY
	lastPoint = [targetX, targetY]
	document.querySelector('#curve1').setAttribute('d','M 375 0 c 0 100' + (targetX - 375) + ' ' + (targetY - 100) + ' ' + (targetX - 375) + ' ' + targetY + ' c 0 100 ' + (375 - targetX) + ' ' + (728 - targetY - 100) + ' ' + (375 - targetX) + ' ' + (728 - targetY) + ' l 0 0 l 0 -728')
	page.content.x = Utils.modulate(hitArea.x,[0, -375],[0, -60], true)
	
	if 0 <= event.pointX <= 220 && 416 <= event.pointY <= 480
		activeHandler.x = 1
	else
		activeHandler.x = 0

activeHandler.on 'change:x', ->
	if @x == 1
		if tip.states.current.name == 'show'
			tip.animate('active')
			tipText.text = '松手进入个人页'
			shadowChange.animate('active')
			minePage.animate
				x: 300
				options: 
					time: 0.2
	else
		if tip.states.current.name == 'active'
			tip.animate('show')
			tipText.text = '进入个人页'
			shadowChange.animate('show')
			minePage.animate('vanish')

hitArea.on Events.DragEnd, ->
	print 
	shadowChange.animate('vanish')
	tip.animate('vanish')
	recoverHandler.x = lastPoint[0]
	recoverHandler.y = lastPoint[1]
	recoverHandler.animate
		x: 375
		y: 406
		options: 
			time: 0.2
			curve: 'ease'
	if hitArea.x >= -100 && activeHandler.x == 0
		page.content.animate
			x: 0
			options: 
				time: 0.2
	else if activeHandler.x == 1
		minePage.animate('show')
		page.content.animate
			x: 0
			options: 
				time: 0.2
	else
		page.snapToPage(recommandFeed)
	

page.on 'change:currentPage', ->
	if @currentPage.name == 'followFeed'
		hitArea.visible = true
	else if @currentPage.name == 'recommandFeed'
		hitArea.visible = false
		
	

hitArea.on 'change:point', ->
	if hitArea.draggable.isDragging == false
		offsetX = @x + lastPoint.x
		offsetY = @y + lastPoint.y

recoverHandler.on 'change:point', ->
	document.querySelector('#curve1').setAttribute('d','M 375 0 c 0 100' + (@x - 375) + ' ' + (@y - 100) + ' ' + (@x - 375) + ' ' + @y + ' c 0 100 ' + (375 - @x) + ' ' + (728 - @y - 100) + ' ' + (375 - @x) + ' ' + (728 - @y) + ' l 0 0 l 0 -728')
		
# 		print lastDragPositon
# 	shadowChange.x = hitArea.x - 311
# 	document.querySelector('#curve1').setAttribute('d','M 0 364 q 0 406 0 728 l 0 0 l 0 -728')
# 	if minePage.states.current.name == 'vanish'
# 		minePage.x = Utils.modulate((hitArea.x - 311 + 375),[375, 0],[375, -64])