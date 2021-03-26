mainScreen.clip = true
mainScreen.width = 375
mainScreen.height = 812
mainScreen.center()

handler = new Layer
	visible: false

page = new PageComponent
	width: mainScreen.width
	height: mainScreen.height
	scrollVertical: false

shadowChange.backgroundColor = 'transparent'
shadowChange.classList.add("svgBox")
shadowChange.html = """
	<svg id='box' viewBox='-30 0 375 60' version = "1.1">
		<linearGradient id="grad1" x1="0%" y1="0%" x2="0%" y2="100%">
			<stop offset="0%" style="stop-color:rgb(64, 66, 82);stop-opacity:1" />
			<stop offset="100%" style="stop-color:rgb(22, 24, 35);stop-opacity:1" />

		</linearGradient>
		<path id ="curve1" d ="M 30 0 q 187.5 0 375 0 l 0 60 q -187.5 0 -375 0" fill="rgba(41,41,41,0.5)"/>
	</svg>
"""

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

page.content.on Events.DragStart, ->
	if page.currentPage.name == 'followFeed'
		shadowChange.animate('show')

page.content.on Events.DragEnd, ->
	shadowChange.animate('vanish')
	if -60 >= page.content.x >= - 187 &&  page.content.draggable.velocity.x > -0.2 && page.currentPage.name == 'followFeed'
		minePage.animate('show')

back.on Events.Click, ->
	minePage.vanish()



# hitArea.draggable.enabled = true
# hitArea.draggable.overdragScale = 1
# hitArea.draggable.constraints = 
# 		x: 311
# 		y: 0
# 		width: 64
# 		height: 812

# hitArea.draggable.bounceOptions =
# 	friction: 100,
# 	tension: 2000,
# 	tolerance: 0.5

page.content.on 'change:x', ->
	if @x < -187
		handler.x = 1
	else
		handler.x = 0
	shadowChange.width = 60 - page.content.x - 375 + minePage.x 
	shadowChange.x = page.content.x 
	followTab.opacity = Utils.modulate(@x,[0, -375],[1, 0.5])
	recommandTab.opacity = Utils.modulate(@x,[0, -375],[0.5, 1])
	tabSlideBar.x = Utils.modulate(@x,[0, -375],[143, 208])
	dot = Utils.modulate(@x, [0, -187], [0,40])
	length = shadowChange.width - 30
	tip.opacity =  Utils.modulate(@x, [-30, -100], [0,1], false)
	document.querySelector('#box').setAttribute('viewBox','-30 0 '+shadowChange.width+' 60')
	document.querySelector('#curve1').setAttribute('d','M 0 0 c 20 0 ' + length/2 + ' ' + dot + ' ' + length + ' 0 l 0 60 c ' + (-length/2) + ' ' + (-dot) + ' ' + (-length + 20) + '  0 ' + (-length) + ' 0')

handler.on 'change:x', ->
	if @x == 1
		shadow.animate
			opacity: 0
			options:
				time: 0.2
	else if @x == 0
		shadow.animate
			opacity: 1
			options:
				time: 0.2

# hitArea.on 'change:point', ->
# 	shadowChange.x = hitArea.x - 311
# 	if minePage.states.current.name == 'vanish'
# 		minePage.x = Utils.modulate((hitArea.x - 311 + 375),[375, 0],[375, -64])