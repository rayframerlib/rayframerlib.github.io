mainScreen.clip = true
mainScreen.width = 375
mainScreen.height = 812
mainScreen.center()

guide.backgroundColor = '#292929'
guide.borderRadius = 4
guide.padding = 6

guideHandler = new Layer
guideHandler.visible = false

guideMoveFirst = new Animation guideHandler,
	x: 16
	options:
		time: 0.3
		curve: 'ease-out'

guideMoveSecond = new Animation guideHandler,
	x: 8
	options:
		time: 0.8
		curve: 'ease-in-out'

guideMoveFirst.on Events.AnimationEnd, ->
	guideMoveSecond.start()
	guideMoveSecond.on Events.AnimationEnd, ->
		guideMoveFirst.start()

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

shadowCurve.backgroundColor = 'transparent'
shadowCurve.classList.add("svgBox")
shadowCurve.html = """
	<svg id='box' viewBox='0 0 80 728' version = "1.1">
		<linearGradient id="grad1" x1="0%" y1="0%" x2="100%" y2="0%">
			<stop offset="0%" style="stop-color:rgba(255, 255, 255, 0.2);stop-opacity:1" />
			<stop offset="100%" style="stop-color:rgb(255, 255, 255, 0.18);stop-opacity:1" />
		</linearGradient>
		<path id ="curve1" d ="M 375 0 q 0 364 0 728 l 0 0 l 0 -728" fill="url(#grad1)"/>
	</svg>
"""

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

hint.states.vanish =
	x: 72
	opacity: 0
	options: 
		time: 0.2
		curve: 'ease-in' 

hint.states.show =
	x: 24
	opacity: 1
	options: 
		time: 0.2
		curve: 'ease-out' 
	

hint.stateSwitch('vanish')

# hintText.states.show = 
# 	opacity: 1
# 	options: 
# 		time: 0.2

# hintText.states.vanish = 
# 	opacity: 0
# 	options: 
# 		time: 0.2

# hintText.stateSwitch('vanish')

hitArea.on Events.TouchStart,(event) ->
	shadowChange.animate('show')
	hint.animate('show')
	targetX = event.point.x - ((Screen.width - mainScreen.width) / 2) + hitArea.x
	targetY = event.point.y - ((Screen.height - mainScreen.height) / 2) + hitArea.y
	document.querySelector('#curve1').setAttribute('d','M 80 0 c 0 50 -16' + ' ' + (targetY - 100) + ' -16 ' + targetY + ' c 0 100 16' + ' ' + (728 - targetY - 50) + ' 16 ' + (728 - targetY) + ' l 0 0 l 0 -728')
# 	hintText.animate('show')

hitArea.on Events.TouchEnd, ->
	shadowChange.animate('vanish')
	hint.animate('vanish')
# 	hintText.animate('vanish')

hitArea.on Events.DragEnd, ->
	shadowChange.animate('vanish')
	hint.animate('vanish')
	if hitArea.x <= 200
		minePage.show()

back.on Events.Click, ->
	minePage.vanish()


hitArea.draggable.enabled = true
hitArea.draggable.overdragScale = 1
hitArea.draggable.constraints = 
		x: 311
		y: 0
		width: 80
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

lastPoint = [0,0]
lastDragPositon = [0,0]

hitArea.on Events.DragMove, (event) ->
	targetX = event.pointX - ((Screen.width - mainScreen.width) / 2)
	targetY = event.pointY - ((Screen.height - mainScreen.height) / 2)
	document.querySelector('#curve1').setAttribute('d','M 80 0 c 0 50 -16' + ' ' + (targetY - 100) + ' -16 ' + targetY + ' c 0 100 16' + ' ' + (728 - targetY - 50) + ' 16 ' + (728 - targetY) + ' l 0 0 l 0 -728')
	page.content.x = Utils.modulate(hitArea.x,[0, -375],[0, -60], true)


guide.on Events.Click, ->
	page.content.x = Utils.modulate(hitArea.x,[0, -375],[0, -60], true)
	(hitArea.animate
		x: 260
		options: 
			time: 0.4).on Events.AnimationEnd, ->
				shadowChange.animate
					opacity: 0.8
					options:
						time: 0.3
				(hitArea.animate
					x: 311
					options:
						time: 0.5).on Events.AnimationEnd, ->
						guideMoveFirst.start()
						guideHandler.on 'change:x', ->
							document.querySelector('#curve1').setAttribute('d','M 80 0 c 0 50 ' + -@x + ' ' + ' ' + (364 - 100) + ' ' + -@x + ' ' + 364 + ' c 0 100 ' + @x + ' ' + ' ' + (728 - 364 - 50) + ' ' + @x + ' ' + (728 - 364) + ' l 0 0 l 0 -728')
							shadowChange.opacity = Utils.modulate(@x,[8,16],[0.8,1],true)
						Utils.delay 3, ->
							shadowChange.animate('vanish')
							hint.animate('vanish')
							guideHandler.off 'change:x'
	shadowChange.animate('show')
	hint.animate('show')