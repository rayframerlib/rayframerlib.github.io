Framer.Extras.Hints.disable()

mainScreen.width = 375
mainScreen.height = 812

mainScreen.clip = true
mainScreen.centerY()
mainScreen.centerX()

if Screen.width > 375
	mainScreen.scale = Screen.width / 375
mainScreen.y = (Screen.height - mainScreen.height) / 2

page = new PageComponent
	superLayer: mainScreen
	width: Screen.width
	height: 729
	scrollHorizontal: false

page.placeBehind(head)

page.addPage(videoA)
page.addPage(videoB, 'bottom')
page.addPage(videoC, 'bottom')

vA = new VideoLayer
	superLayer: videoA
	width: 410
	height: 729
	video: "images/1596181038946402.mp4"

vA.placeBehind(videoAMask)
vA.player.play()
vA.player.loop = true
vA.player.muted = true

vB = new VideoLayer
	superLayer: videoB
	width: 418
	height: 736
	video: "images/1594722252398313.mp4"

vB.placeBehind(videoBMask)
vB.player.loop = true
vB.player.muted = true

vC = new VideoLayer
	superLayer: videoC
	width: 418
	height: 736
	video: "images/1594877244367455.mp4"

vC.player.loop = true
vC.player.muted = true
vC.placeBehind(videoCMask)

# blockShadow.placeBefore(page)

isShow = false

tabText.states.vanish = 
	scale: 0.5
	opacity: 0
	options:
		curve: 'ease-in-out'
		time: 0.3

tabText.states.show = 
	scale: 1
	opacity: 1
	options:
		curve: 'ease-in-out'
		time: 0.3

refresh.states.vanish = 
	scale: 0.5
	opacity: 0
	options:
		curve: 'ease-in-out'
		time: 0.3

refresh.states.show = 
	scale: 1
	opacity: 1
	options:
		curve: 'ease-in-out'
		time: 0.3

refresh.stateSwitch('vanish')

block.placeBefore(page)

block.states.startVanish = 
	y: block.y + 200
	opacity: 0
	scale: 1
	
block.states.show = 
	y: block.y
	opacity: 1
	options: 
		time: 0.4
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
	refresh.animate('vanish')
	tabText.animate('show')

blockShow = () ->
	block.animate('show')
	blockShadow.animate('show')
	isShow = true
	page.content.on Events.MouseDown, ->
		blockVanish()
	refresh.animate('show')
	tabText.animate('vanish')

block.on Events.Click, ->

cancel.on Events.Click, ->
	blockVanish()
	

page.on 'change:currentPage', ->
	vA.player.pause()
	vB.player.pause()
	vC.player.pause()
	
	if page.previousPage.name == 'videoA' && page.currentPage.name == 'videoB'
		blockShow()
		Utils.delay 5, ->
			if isShow
				blockVanish()
			
	if page.currentPage.name == 'videoA'
		videoBStruct.stateSwitch('vanish')
		vA.player.play()
	
	if page.currentPage.name == 'videoB'
		vB.player.play()
		
	if page.currentPage.name == 'videoC'
		vC.player.play()








