Framer.Extras.Hints.disable()

mainScreen.width = 375
mainScreen.height = 812

mainScreen.clip = true
mainScreen.centerY()
mainScreen.centerX()

innerFeed.visible = false

fakehead.states.vanish = 
	opacity: 0
	options: 
		time: 0.1

fakehead.states.show = 
	opacity: 1 
	options: 
		time: 0.1

innerFeed.states.vanish = 
	width: 60
	height: 60
	borderRadius: 26
	x: 294
	y: 131
	options: 
		time: 0.25
		curve: 'cubic-bezier(0.46, 0.0, 0.18, 1.0)'

innerFeed.states.show = 
	width: 375
	height: 812
	borderRadius: 0
	x: 0
	y: 0
	options: 
		time: 0.25
		curve: 'cubic-bezier(0.46, 0.0, 0.18, 1.0)'

mask.states.show = 
	opacity: 1
	options: 
		time: 0.25

mask.states.vanish = 
	opacity: 0
	options: 
		time: 0.25

mask.stateSwitch('vanish')

hitArea.on Events.Click, ->
	innerFeed.visible = true
	innerFeed.animate('show')
	fakehead.animate('vanish')
	mask.animate('show')

innerBack.on Events.Click, ->
	mask.animate('vanish')
	innerFeed.animate('vanish').on Events.AnimationEnd, ->
		innerFeed.visible = false
	Utils.delay 0.15, ->
		fakehead.animate('show')

innerFeed.draggable.enabled = true
innerFeed.on Events.DragEnd, ->
	mask.animate('vanish')
	innerFeed.animate('vanish').on Events.AnimationEnd, ->
		innerFeed.visible = false
	Utils.delay 0.15, ->
		fakehead.animate('show')
		
	