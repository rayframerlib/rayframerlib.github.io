mainScreen.width = 375
mainScreen.height = 812
mainScreen.center()

gifComp.draggable.enabled = true
gifComp.draggable.speedY = 0
gifComp.clip = true

gifCompExposure = 200 

gifComp.states.extend = 
	x: 0
	borderRadius: 0
	opacity: 1
	options: 
		time: 0.26
		curve:'cubic-bezier(0.46, 0.0, 0.18, 1.0)'

gifComp.states.show = 
	x: 375 - gifCompExposure
	borderRadius:
		topLeft: 6
	opacity: 1
	options:
		time: 0.26
		curve: 'cubic-bezier(0.46, 0.0, 0.18, 1.0)'

gifComp.states.vanish = 
	x: 375
	borderRadius:
		topLeft: 6
	opacity:  1
	options:
		time: 0.18
		curve: 'cubic-bezier(0.3, 0.0, 0.9, 0.6)'

gifComp.stateSwitch('vanish')

gifCompVanish = ()->
	gifComp.animate('vanish').on Events.AnimationEnd, ->
		gifComp.draggable.enabled = true
		gifs.draggable.enabled = false
		gifs.x = 10

gifCompShow = ()->
	gifComp.animate('show').on Events.AnimationEnd, ->
		gifComp.draggable.enabled = false
		gifs.draggable.enabled = true

inputComp.states.normal = 
	height: 64
	options: 
		time: 0.26
		curve: 'cubic-bezier(0.46, 0.0, 0.18, 1.0)'

inputComp.states.extend = 
	height: 134
	options: 
		time: 0.26
		curve: 'cubic-bezier(0.46, 0.0, 0.18, 1.0)'

selectedGif.states.target = 
	x: 12
	y: 64
	options: 
		time: 0.26
		curve: 'cubic-bezier(0.46, 0.0, 0.18, 1.0)'

selectedGif.opacity = 0

selectedGif.states.vanish = 
	x: -18
	y: 34
	opacity: 0
	scale: 0
	options: 
		time: 0.26
		curve: 'cubic-bezier(0.46, 0.0, 0.18, 1.0)'

hitArea.on Events.Click, ->
	gifComp.animate('show')

gifs.draggable.constraints = 
	x: 375 - 10 - gifs.width
	y: 10
	width: gifs.width * 2 - 355
	height: gifs.height
gifs.draggable.enabled = false
gifs.draggable.speedY = 0


gifComp.on Events.DragEnd, ->
	if gifComp.x <= (375 - gifCompExposure)/2
		gifComp.animate('extend')
		gifComp.draggable.enabled = false
		gifs.draggable.enabled = true 
	else if gifComp.x <= 375 - gifCompExposure / 2
		gifComp.animate('show')
	else
		gifCompVanish()

target.on Events.Click, ->
	gifCompVanish()
	inputComp.animate('extend')
	selectedGif.x = gifComp.x + gifs.x + target.x
	selectedGif.y = gifComp.y + gifs.y + target.y
	selectedGif.opacity = 1
	selectedGif.animate('target')

selectedGif.on Events.Click, ->
	inputComp.animate('normal')
	selectedGif.animate('vanish').on Events.AnimationEnd, ->
		selectedGif.scale = 1
	
	
		