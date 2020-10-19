Framer.Extras.Hints.disable()

mainScreen.width = 375
mainScreen.height = 812

mainScreen.clip = true
mainScreen.centerY()
mainScreen.centerX()

# 所有动画设定都在这里

halfScreenAnimationOption = 
	time: 0.5
	curve: Spring(damping: 1)

halfScreenAnimationOptionAndroid = 
	time: 0.5
	curve: 'cubic-bezier(.28,.59,0,1)'
 
fullScreenAnimationOption = 
	time: 0.5
	curve: Spring(damping: 1)



frameAnimationOption = 
	time: 0.5
	curve: Spring(damping: 1)

popUpShowAnimationOption = 
	time: 0.4
	curve: Spring(damping: .5)

popUpVanishAnimationOption = 
	time: 0.1
	curve: 'linear'

panelAnimationOption = 
	time: 0.5
	curve: 'cubic-bezier(.28,.59,0,1)'
	
panelChangeAnimationOption = 
	time: 0.4
	curve: 'cubic-bezier(.28,.59,0,1)'



if Screen.width > 375
	mainScreen.scale = Screen.width / 375
mainScreen.y = (Screen.height - mainScreen.height) / 2



originScheme.states.halfToNormal =
	scale: 1
	options: halfScreenAnimationOption

originScheme.states.halfScreen =
	scale: 0.89
	options: halfScreenAnimationOption

originScheme.states.frame = 
	x: -125
	options: frameAnimationOption

originScheme.states.frameToNormal = 
	x: 0
	options: frameAnimationOption



halfScreenScheme.states.show = 
	y: 54
	options: halfScreenAnimationOption

halfScreenScheme.states.vanish = 
	y: 812
	options: halfScreenAnimationOption





halfScreenAndroidScheme.states.show = 
	y: 44
	options: halfScreenAnimationOption

halfScreenAndroidScheme.states.vanish = 
	y: 812
	options: halfScreenAnimationOption




fullScreenScheme.states.show = 
	y: 0
	options: fullScreenAnimationOption
	
fullScreenScheme.states.vanish = 
	y: 812
	options: fullScreenAnimationOption




frameScheme.states.vanish = 
	x: 375
	options: frameAnimationOption

frameScheme.states.show = 
	x: 0
	options: frameAnimationOption




popUp.states.show = 
	y: popUp.y
	scale: 1
	opacity: 1
	options: popUpShowAnimationOption

popUp.states.vanish = 
	y: popUp.y
	scale: 1.1
	opacity: 0
	options: popUpShowAnimationOption

popUp.states.showToVanish = 
	y: popUp.y
	scale: 1
	opacity: 0
	options: popUpVanishAnimationOption




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
	showMask()
	panel.draggable.enabled = true

panelTop = (options) ->
	panel.animate('showTop', options)
	showMask()
	panel.draggable.enabled = true
	
panelVanish = () ->
	panel.draggable.enabled = false
	panel.animate('vanish')
	vanishMask()
	




popUp.visible = false

popUpShow = () ->
	popUp.visible = true
	popUp.stateSwitch('vanish')
	popUp.animate('show')
	showMask()
	
popUpVanish = () ->
	popUp.animate('showToVanish').on Events.AnimationEnd, ->
		popUp.visible = false
	vanishMask()

halfScreenScheme.on Events.Click, ->
	halfScreenBack()

halfScreenTrigger.on Events.Click, ->
	toHalfScreen()

fullScreenTrigger.on Events.Click, ->
	toFullScreen()

fullScreenScheme.on Events.Click, ->
	fullScreenBack()

frameTrigger.on Events.Click, ->
	toFrame()

frameScheme.on Events.Click, ->
	frameBack()

popUpTrigger.on Events.Click, ->
	popUpShow()

popUp.on Events.Click, ->
	popUpVanish()

panelTrigger.on Events.Click, ->
	panelShow(panelAnimationOption)

panelCancel.on Events.Click, ->
	panelVanish()

panel.on 'change:y', ->
	panelInactiveArea.y = @y + 44

panel.on Events.DragEnd, ->
	if @y >= 353
		panelVanish()
	else if @y <= 120
		panelTop(panelChangeAnimationOption)
	else 
		panelShow(panelChangeAnimationOption)

# panelInactiveArea.on Events.Click, ->

halfScreenAndroidTrigger.on Events.Click, ->
	toHalfScreenAndroid()
	
halfScreenAndroidScheme.on Events.Click, ->
	halfScreenAndroidBack()

halfScreenScheme.stateSwitch('vanish')
halfScreenAndroidScheme.stateSwitch('vanish')
fullScreenScheme.stateSwitch('vanish')
frameScheme.stateSwitch('vanish')
popUp.stateSwitch('vanish')
panel.stateSwitch('vanish')
mask.stateSwitch('vanish')




	
	