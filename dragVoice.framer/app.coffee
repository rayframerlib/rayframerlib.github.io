
Framer.Extras.Hints.disable()

mainScreen.width = 375
mainScreen.height = 812

mainScreen.clip = true
mainScreen.centerY()
mainScreen.centerX()

if Screen.width > 375
	mainScreen.scale = Screen.width / 375
mainScreen.y = (Screen.height - mainScreen.height) / 2

Framer.Defaults.Animation =
	curve: Spring(damping: 1)
	time: 0.4
	
maxHeight = 125
maxX = 350
minX = 25

handlerOriginX = dragHandler.x
handlerOriginY = dragHandler.y

curveEffect.classList.add("svgBox")
curveEffect.html = """
	<svg viewBox='0 -72 375 375' version = "1.1">
		<linearGradient id="grad1" x1="0%" y1="0%" x2="0%" y2="100%">
			<stop offset="0%" style="stop-color:rgb(39, 41, 51);stop-opacity:1" />
			<stop offset="100%" style="stop-color:rgb(39, 41, 51);stop-opacity:1" />
		</linearGradient>
		<path id ="curve" d ="M 0 0 q 187.5 0 375 0" fill="url(#grad1)"/>
	</svg>
"""
curveEffect.backgroundColor = "transparent"

dragEffect.states.vanish = 
	y: 740
	opacity: 0
	options: 
		time: 0.3
		curve: "ease-in-out"

dragEffect.states.show = 
	y: 642
	opacity: 1
	options: 
		time: 0.3
		curve: "ease-in-out"

dragEffect.stateSwitch("vanish")

light.states.show = 
	opacity: 1

light.states.vanish = 
	opacity: 0

effectHandler = () ->
	xVal = dragHandler.x - handlerOriginX + 187.5
	yVal = Math.min(Math.max(dragHandler.y - handlerOriginY, -118), 0)
	document.querySelector('.svgBox #curve').setAttribute('d','M 0 0 q '+xVal+' '+yVal+' 375 0')
# 	print dragHandler.x - handlerOriginX
	light.x = dragHandler.x + 7
	light.y = yVal + Utils.modulate(yVal,[0, -118],[130, 200],false)
	
dragArea.draggable.enabled = true
dragArea.draggable.constraints = dragHandler.frame
dragArea.draggable.overdragScale = 1

eventDelegate = new Layer
	visible: false

changeHandler = () ->
	if dragArea.y >= 600
		eventDelegate.x = 0
		dragHandler.animate
			y: dragArea.y
			x: dragArea.x
			options: 
				time: 0.1
				curve: 'linear'
	else
		eventDelegate.x = 1

dragArea.on "change:y", ->
	changeHandler()
			

dragArea.on "change:x", ->
	changeHandler()

eventDelegate.on "change:x", ->
	if @x == 1
		light.animate('vanish')
		dragHandler.animate
			x: 52
			y: 724
	else if @x == 0
		light.animate('show')

dragHandler.on "change:y", ->
	effectHandler()

dragHandler.on "change:x", ->
	effectHandler()

dragArea.on Events.MouseDown, (event)->
	mask.animate('show')
	dragEffect.animate('show')
	dragArea.on Events.Pan, (event)->
# 		curveHandler(event)

dragArea.on Events.LongPressEnd, ->
	Utils.delay 0.1, ->
		mask.animate('vanish')
		dragEffect.animate('vanish')
		dragArea.off Events.PanEnd
		dragArea.off Events.Pan

blueLight.states.vanish = 
	opacity: 0
	options: 
		time: 1
		curve: 'linear'
blueLight.states.show = 
	opacity: 1
	options: 
		time: 1
		curve: 'linear'

pinkLight.states.vanish = 
	opacity: 0
	options: 
		time: 1
		curve: 'linear'
pinkLight.states.show = 
	opacity: 1
	options: 
		time: 1
		curve: 'linear'

blueLight.stateSwitch('vanish')

pinkLight.on Events.AnimationEnd, ->
	if pinkLight.states.current.name == 'vanish'
		pinkLight.animate('show')
	else if pinkLight.states.current.name == 'show'
		pinkLight.animate('vanish')

blueLight.on Events.AnimationEnd, ->
	if blueLight.states.current.name == 'vanish'
		blueLight.animate('show')
	else if blueLight.states.current.name == 'show'
		blueLight.animate('vanish')

pinkLight.animate('vanish')
blueLight.animate('show')



	



mask.opacity = 0

mask.states.vanish = 
	opacity: 0
	options: 
		time: 0.3

mask.states.show =
	opacity: 1
	options: 
		time: 0.3



