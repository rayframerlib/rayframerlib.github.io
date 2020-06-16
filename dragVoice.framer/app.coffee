
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

dragEffect.classList.add("svgBox")
dragEffect.html = """
	<svg viewBox='0 -72 375 375' version = "1.1">
		<linearGradient id="grad1" x1="0%" y1="0%" x2="0%" y2="100%">
			<stop offset="0%" style="stop-color:rgb(39, 41, 51);stop-opacity:1" />
			<stop offset="100%" style="stop-color:rgb(39, 41, 51);stop-opacity:1" />
		</linearGradient>
		<path id ="curve" d ="M 0 0 q 187.5 0 375 0" fill="url(#grad1)"/>
	</svg>
"""
dragEffect.backgroundColor = "transparent"

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

curveHandler = () ->
# 	print event
	xVal = 187.5 + (dragHandler.x - handlerOriginX)
	yVal = Math.min(Math.max(dragHandler.y - handlerOriginY, -118), 0)
	document.querySelector('.svgBox #curve').setAttribute('d','M 0 0 q '+xVal+' '+yVal+' 375 0')
	
dragHandler.draggable.enabled = true
dragHandler.draggable.constraints = dragHandler.frame
dragHandler.draggable.overdragScale	= 1

dragHandler.on "change:y", ->
	curveHandler()

dragHandler.on "change:x", ->
	curveHandler()

dragHandler.on Events.MouseDown, (event)->
	mask.animate('show')
	dragEffect.animate('show')
	dragHandler.on Events.Pan, (event)->
# 		curveHandler(event)

dragHandler.on Events.LongPressEnd, ->
	Utils.delay 0.1, ->
		mask.animate('vanish')
		dragEffect.animate('vanish')
		dragHandler.off Events.PanEnd
		dragHandler.off Events.Pan



mask.opacity = 0

mask.states.vanish = 
	opacity: 0
	options: 
		time: 0.3

mask.states.show =
	opacity: 1
	options: 
		time: 0.3



