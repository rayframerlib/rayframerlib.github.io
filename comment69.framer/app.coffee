Framer.Extras.Hints.disable()

mainScreen.width = 375
mainScreen.height = 812

mainScreen.clip = true
mainScreen.centerY()
mainScreen.centerX()

# 所有动画设定都在这里

panelAnimationOption = 
	time: 0.5
	curve: Spring(damping: 1)
	
panelChangeAnimationOption = 
	time: 0.5
	curve: Spring(damping: 1)


if Screen.width > 375
	mainScreen.scale = Screen.width / 375
mainScreen.y = (Screen.height - mainScreen.height) / 2


panel.states.show = 
	y: 203

panel.states.showTop = 
	y: 44
	
panel.states.vanish = 
	y: 812
	options: panelAnimationOption

panel.draggable.constraints = 
	x: 0
	y: 0
	width: 375
	height: 1753

commentEntrance.states.show = 
	y: commentEntrance.y
	options: panelAnimationOption

commentEntrance.states.vanish = 
	y: commentEntrance.y + commentEntrance.height
	options: panelAnimationOption

mask.states.show = 
	opacity: 1
	options: 
		time: 0.25
		curve: 'linear'
		
mask.states.vanish = 
	opacity: 0
	options: 
		time: 0.25
		curve: 'linear'

mask.on Events.Click, ->
mask.visible = false

showMask = () ->
	mask.animate('show')
	mask.visible = true

vanishMask = () ->
	mask.animate('vanish').on Events.AnimationEnd, ->
		mask.visible = false

toHalfScreen = () ->
	halfScreenScheme.stateSwitch('vanish')
	originScheme.animate('halfScreen') 
	halfScreenScheme.animate('show')
	showMask()

halfScreenBack = () ->
	halfScreenScheme.animate('vanish')
	originScheme.animate('halfToNormal') 
	vanishMask()

toHalfScreenAndroid = () ->
	halfScreenAndroidScheme.stateSwitch('vanish')
	halfScreenAndroidScheme.animate('show')
	showMask()
	
halfScreenAndroidBack = () ->
	halfScreenAndroidScheme.animate('vanish')
	vanishMask()

toFullScreen = () ->
	fullScreenScheme.stateSwitch('vanish')
	fullScreenScheme.animate('show')
	showMask()

fullScreenBack = () ->
	fullScreenScheme.animate('vanish')
	vanishMask()

toFrame = () ->
	showMask()
	frameScheme.animate('show')
	originScheme.animate('frame')

frameBack = () ->
	vanishMask()
	frameScheme.animate('vanish')
	originScheme.animate('frameToNormal')


panel.clip = true

panel.draggable.speedX = 0

panelShow = (options) ->
	panel.animate('show', options)
# 	commentEntrance.animate('show')
# 	showMask()
	panel.draggable.enabled = true

panelTop = (options) ->
	panel.animate('showTop', options)
# 	showMask()
	panel.draggable.enabled = true
	
panelVanish = () ->
	panel.draggable.enabled = false
# 	commentEntrance.animate('vanish')
	panel.animate('vanish')
# 	vanishMask()
# halfScreenScheme.on Events.Click, ->
# 	halfScreenBack()
# 
# halfScreenTrigger.on Events.Click, ->
# 	toHalfScreen()
# 
# fullScreenTrigger.on Events.Click, ->
# 	toFullScreen()
# 
# fullScreenScheme.on Events.Click, ->
# 	fullScreenBack()
# 
# frameTrigger.on Events.Click, ->
# 	toFrame()
# 
# frameScheme.on Events.Click, ->
# 	frameBack()
# 
# popUpTrigger.on Events.Click, ->
# 	popUpShow()
# 
# popUp.on Events.Click, ->
# 	popUpVanish()

panelTrigger.on Events.Click, ->
	panelShow(panelAnimationOption)
	

panel.on 'change:y', ->
	panelInactiveArea.y = @y + 44

panel.on Events.DragEnd, ->
	if @y >= 353
		panelVanish()
	else if @y <= 120
		panelTop(panelChangeAnimationOption)
	else 
		panelShow(panelChangeAnimationOption)

panelInactiveArea.on Events.Click, ->

# halfScreenAndroidTrigger.on Events.Click, ->
# 	toHalfScreenAndroid()
# 	
# halfScreenAndroidScheme.on Events.Click, ->
# 	halfScreenAndroidBack()
panel.stateSwitch('vanish')
mask.stateSwitch('vanish')




	
	