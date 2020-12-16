Framer.Extras.Hints.disable()

mainScreen.width = 375
mainScreen.height = 812

mainScreen.clip = true
mainScreen.centerY()
mainScreen.centerX()

# 所有动画设定都在这里
panelAnimationOptionNow = 
	time: 0.5
	curve: 'cubic-bezier(.35,.75,0,1)'
	
panelChangeAnimationOptionNow = 
	time: 0.4
	curve: 'cubic-bezier(.35,.75,0,1)'
	
panelAnimationOptionOrigin = 
	time: 0.15
	curve: 'ease'
	
panelChangeAnimationOptionOrigin = 
	time: 0.15
	curve: 'ease'

panelAnimationOptionSameTime = 
	time: 0.15
	curve: 'ease-in-out'
	
panelChangeAnimationOptionSameTime = 
	time: 0.15
	curve: 'ease-in-out'
	
panelAnimationOptionRecommand = 
	time: 0.25
	curve: 'cubic-bezier(.35,.5,0,1)'
	
panelChangeAnimationOptionRecommand = 
	time: 0.2
	curve: 'cubic-bezier(.35,.5,0.3,1)'



if Screen.width > 375
	mainScreen.scale = Screen.width / 375
mainScreen.y = (Screen.height - mainScreen.height) / 2

panel.states.show = 
	y: 203

panel.states.showTop = 
	y: 44
	
panel.states.vanish = 
	y: 812

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
	
panelVanish = (options) ->
	panel.draggable.enabled = false
	panel.animate('vanish', options)
	vanishMask()

vanishOption = null

changeOption = null

panelTriggerNow.on Events.Click, ->
	panelShow(panelAnimationOptionNow)
	vanishOption = panelAnimationOptionNow
	changeOption = panelChangeAnimationOptionNow

panelTriggerOrigin.on Events.Click, ->
	panelShow(panelAnimationOptionOrigin)
	vanishOption = panelChangeAnimationOptionOrigin
	changeOption = panelChangeAnimationOptionOrigin

panelTriggerSameTime.on Events.Click, ->
	panelShow(panelAnimationOptionSameTime)
	vanishOption = panelChangeAnimationOptionSameTime
	changeOption = panelChangeAnimationOptionSameTime

panelTriggerRecommand.on Events.Click, ->
	panelShow(panelAnimationOptionRecommand)
	vanishOption = panelChangeAnimationOptionRecommand
	changeOption = panelChangeAnimationOptionRecommand

panelCancel.on Events.Click, ->
	panelVanish(vanishOption)

panel.on 'change:y', ->
	panelInactiveArea.y = @y + 44

panel.on Events.DragEnd, ->
	if @y >= 353
		panelVanish()
	else if @y <= 120
		panelTop(changeOption)
	else 
		panelShow(changeOption)

# panelInactiveArea.on Events.Click, ->

panel.stateSwitch('vanish')
mask.stateSwitch('vanish')




	
	