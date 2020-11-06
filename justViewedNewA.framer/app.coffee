Framer.Extras.Hints.disable()

mainScreen.width = 375
mainScreen.height = 667
mainScreen.clip = true
mainScreen.centerY()
mainScreen.centerX()

feed.draggable.enabled = true
feed.draggable.speedX = 0
feed.draggable.constraints = 
	x: 0
	y:  -feed.height + mainScreen.height
	width: 375
	height: 2 * feed.height - mainScreen.height

naviHandler = new Layer
naviHandler.visible = false

naviHandler.width = 0

target.clip = true

feed.states.focus = 
	y: -1050
	options: 
		time: 0.5
		curve: Spring(damping: 1)

pop.states.vanish = 
	y: pop.y + 60
	opacity: 0
	options: 
		time: 0.2
		curve: 'ease-in'

pop.states.show = 
	y: pop.y
	opacity: 1
	options: 
		time: 0.2
		curve: 'ease-out'

pop.clip = true

pop.stateSwitch('vanish')

pop.on Events.Click, ->
	feed.animate('focus')
	Utils.delay 0.3, ->
		strokeSpark()
		
	pop.animate('vanish').on Events.AnimationEnd, ->
		listenToPop()
# 		popSwitchExtend()

feed.on "change:y", ->
	if feed.y >= -407
		naviHandler.x = 0
		tabSecond.y = feed.y + 471
	else 
		naviHandler.x = 1
		tabSecond.y = 64
		if feed.y <= -1051
			naviHandler.width = 1
		else
# 			naviHandler.height = 0
		if feed.y <= -800
			naviHandler.y = 1
			if pop.states.current.name == 'show'
				pop.opacity = Utils.modulate(feed.y,[-1250, -1300], [0, 1], true)
		else
			naviHandler.y = 0
			if pop.states.current.name == 'show'
				pop.opacity = Utils.modulate(feed.y,[-800, -850], [1, 0], true)
	naviSecond.opacity = Utils.modulate(feed.y,[-400, -300],[1, 0])
	

naviHandler.on "change:y", ->
	if naviHandler.y == 1
		arrow.animate('up')
	else
		arrow.animate('down')
		

naviHandler.on "change:width", ->
	if naviHandler.width == 1
		strokeSpark()
	else
# 		arrow.animate('down')

popShow = () ->
	pop.animate('show')
# 	Utils.delay 2, ->
# 		if pop.states.current.name == 'show'
# 			popShrink()

listenToPop = () ->
	naviHandler.on "change:x", ->
		if naviHandler.x == 1
			popShow()
			naviHandler.off "change:x"

listenToPop()		

bg.on "change:frame", ->
	shadow.frame = bg.frame

bg.states.extend = 
	width: 116
	x: 0
	options: 
		time: 0.5
		curve: Spring(damping: 1)

bg.states.shrink = 
	width: 40
	x: 76
	options: 
		time: 0.5
		curve: Spring(damping: 1)

arrow.states.shrink = 
	x: arrow.x - 5
	options: 
		time: 0.5
		curve: Spring(damping: 1)

arrow.states.extend = 
	x: arrow.x
	options: 
		time: 0.5
		curve: Spring(damping: 1)

pic.states.shrink = 
	x: pic.x + 76
	opacity: 0
	options: 
		time: 0.5
		curve: Spring(damping: 1)

pic.states.extend = 
	x: pic.x
	opacity: 1
	options: 
		time: 0.5
		curve: Spring(damping: 1)

text.states.shrink = 
	x: text.x + 76
	opacity: 0
	options: 
		time: 0.5
		curve: Spring(damping: 1)

text.states.extend = 
	x: text.x
	opacity: 1
	options: 
		time: 0.5
		curve: Spring(damping: 1)

arrow.states.down = 
	rotation: -180
	options: 
		time: 0.15
		curve: 'ease-in-out'

arrow.states.up = 
	rotation: 0
	options: 
		time: 0.15
		curve: 'ease-in-out'

arrow.stateSwitch('down')

popShrink = () ->
	bg.animate('shrink')
	arrow.animate('shrink')
	pic.animate('shrink')
	text.animate('shrink')

popExtend = () ->
	bg.animate('extend')
	arrow.animate('extend')
	pic.animate('extend')
	text.animate('extend')

popSwitchExtend = () ->
	bg.stateSwitch('extend')
	arrow.stateSwitch('extend')
	pic.stateSwitch('extend')
	text.stateSwitch('extend')

stroke.states.dim =
	opacity: 0.4
	options: 
		time: 0.2
		curve: 'ease-in'

stroke.states.normal =
	opacity: 1
	options: 
		time: 0.2
		curve: 'ease-out'

target.states.float = 
	scale: 1.08
	shadow1: 
		y: 5
		blur: 20
		color: 'rgba(0,0,0,0.3)'
	options: 
		time: 0.3
		curve: 'cubic-bezier(.35,0,0.3,1)'

target.states.normal =
	scale: 1
	shadow1: 
		y: 0
		blur: 0
		color: 'rgba(0,0,0,0.3)'
	options: 
		time: 0.4
		curve: 'cubic-bezier(0.2,0,.65,1)'

light.states.start = 
	y: light.y
	options: 
		time: 0.3
		curve: 'cubic-bezier(.35,.55,0.7,0.89)'

light.states.mid = 
	y: light.y + 165
	options: 
		time: 0.3
		curve: 'cubic-bezier(.35,.55,0.7,0.89)'

light.states.end = 
	y: light.y + 330
	options: 
		time: 0.4
		curve: 'cubic-bezier(0.3,0.2,.65,.45)'


strokeSpark = () ->
	target.animate('float').on Events.AnimationEnd, ->
		target.animate('normal')
	
# 	light.animate('mid').on Events.AnimationEnd, ->
# 		light.animate('end').on Events.AnimationEnd, ->
# 			light.stateSwitch('start')
# 	stroke.animate('dim').on Events.AnimationEnd, ->
# 		stroke.animate('normal').on Events.AnimationEnd, ->
# 			stroke.animate('dim').on Events.AnimationEnd, ->
# 				stroke.animate('normal')

