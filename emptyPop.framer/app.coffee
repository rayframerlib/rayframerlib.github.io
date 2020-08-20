page = new PageComponent
	superLayer: mainScreen
	width: Screen.width
	height: 729
	scrollHorizontal: false

page.placeBehind(head)

page.addPage(videoA)
page.addPage(videoB, 'bottom')
page.addPage(videoC, 'bottom')

isShow = false

block.states.startVanish = 
	y: block.y + 197
	opacity: 0
	scale: 1
	
block.states.show = 
	y: block.y
	opacity: 1
	options: 
		time: 0.5
		curve: Spring(damping: 1)

block.states.vanish = 
	opacity: 0
	scale: 0.92
	options: 
		time: 0.4
		curve: Spring(damping: 1)

block.stateSwitch('startVanish')

videoBStruct.states.vanish = 
	opacity: 0

videoBStruct.states.show = 
	opacity: 1
	options: 
		curve: 'linear'
		time: 0.2

videoBStruct.stateSwitch('vanish')		

blockShadow.states.startVanish = 
	y: blockShadow.y + blockShadow.height
	opacity: 0

blockShadow.states.show = 
	y: blockShadow.y
	opacity: 1
	options: 
		time: 0.5
		curve: Spring(damping: 1)

blockShadow.states.vanish = 
	opacity: 0
	options: 
		time: 0.2
		curve: 'linear'

blockShadow.stateSwitch('startVanish')

blockVanish = () ->
	block.animate('vanish').on Events.AnimationEnd, ->
		block.stateSwitch('startVanish')
	blockShadow.animate('vanish').on Events.AnimationEnd, ->
		blockShadow.stateSwitch('startVanish')
	videoBStruct.animate('show')
	isShow = false
	page.content.off Events.MouseDown

blockShow = () ->
	block.animate('show')
	blockShadow.animate('show')
	isShow = true
	page.content.on Events.MouseDown, ->
		blockVanish()

block.on Events.Click, ->

cancel.on Events.Click, ->
	blockVanish()
	

page.on 'change:currentPage', ->
	if page.previousPage.name == 'videoA' && page.currentPage.name == 'videoB'
		blockShow()
		Utils.delay 5, ->
			if isShow
				blockVanish()
			
	if page.currentPage.name == 'videoA'
		videoBStruct.stateSwitch('vanish')	

