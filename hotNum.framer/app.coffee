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
page.addPage(videoD, 'bottom')
page.addPage(videoE, 'bottom')

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
	height: 729
	video: "images/1594722252398313.mp4"

vB.placeBehind(videoBMask)
vB.player.loop = true
vB.player.muted = true

vC = new VideoLayer
	superLayer: videoC
	width: 418
	height: 729
	video: "images/1594877244367455.mp4"

vC.player.loop = true
vC.player.muted = true
vC.placeBehind(videoCMask)

vD = new VideoLayer
	superLayer: videoD
	width: 418
	height: 729
	video: "images/1596181038946402.mp4"

vD.player.loop = true
vD.player.muted = true
vD.placeBehind(videoDMask)

vE = new VideoLayer
	superLayer: videoE
	width: 418
	height: 729
	video: "images/1594722252398313.mp4"

vE.player.loop = true
vE.player.muted = true
vE.placeBehind(videoEMask)

cliper.clip = true

mask.placeBefore(page)
tag2.placeBefore(page)
dots.placeBefore(page)

isShow = false

dot1.states.s1 = 
	y: 0
	height: 24
	backgroundColor: 'rgba(255, 255, 255, 0.9)'
	options:
		time: 0.3
		curve: 'ease-in-out'

dot1.states.s2 = 
	y: 0
	height: 8
	backgroundColor: 'rgba(255, 255, 255, 0.5)'
	options:
		time: 0.3
		curve: 'ease-in-out'

dot1.states.s3 = 
	y: 0
	height: 8
	backgroundColor: 'rgba(255, 255, 255, 0.5)'
	options:
		time: 0.3
		curve: 'ease-in-out'

dot1.states.s4 = 
	y: 0
	height: 8
	backgroundColor: 'rgba(255, 255, 255, 0.5)'
	options:
		time: 0.3
		curve: 'ease-in-out'

dot1.states.s5 = 
	y: 0
	height: 8
	backgroundColor: 'rgba(255, 255, 255, 0.5)'
	options:
		time: 0.3
		curve: 'ease-in-out'
		
dot2.states.s1 = 
	y: 30
	height: 8
	backgroundColor: 'rgba(255, 255, 255, 0.5)'
	options:
		time: 0.3
		curve: 'ease-in-out'

dot2.states.s2 = 
	y: 14
	height: 24
	backgroundColor: 'rgba(255, 255, 255, 0.9)'
	options:
		time: 0.3
		curve: 'ease-in-out'

dot2.states.s3 = 
	y: 14
	height: 8
	backgroundColor: 'rgba(255, 255, 255, 0.5)'
	options:
		time: 0.3
		curve: 'ease-in-out'

dot2.states.s4 = 
	y: 14
	height: 8
	backgroundColor: 'rgba(255, 255, 255, 0.5)'
	options:
		time: 0.3
		curve: 'ease-in-out'

dot2.states.s5 = 
	y: 14
	height: 8
	backgroundColor: 'rgba(255, 255, 255, 0.5)'
	options:
		time: 0.3
		curve: 'ease-in-out'

dot3.states.s1 = 
	y: 44
	height: 8
	backgroundColor: 'rgba(255, 255, 255, 0.5)'
	options:
		time: 0.3
		curve: 'ease-in-out'

dot3.states.s2 = 
	y: 44
	height: 8
	backgroundColor: 'rgba(255, 255, 255, 0.5)'
	options:
		time: 0.3
		curve: 'ease-in-out'

dot3.states.s3 = 
	y: 28
	height: 24
	backgroundColor: 'rgba(255, 255, 255, 0.9)'
	options:
		time: 0.3
		curve: 'ease-in-out'

dot3.states.s4 = 
	y: 28
	height: 8
	backgroundColor: 'rgba(255, 255, 255, 0.5)'
	options:
		time: 0.3
		curve: 'ease-in-out'

dot3.states.s5 = 
	y: 28
	height: 8
	backgroundColor: 'rgba(255, 255, 255, 0.5)'
	options:
		time: 0.3
		curve: 'ease-in-out'

dot4.states.s1 = 
	y: 58
	height: 8
	backgroundColor: 'rgba(255, 255, 255, 0.5)'
	options:
		time: 0.3
		curve: 'ease-in-out'

dot4.states.s2 = 
	y: 58
	height: 8
	backgroundColor: 'rgba(255, 255, 255, 0.5)'
	options:
		time: 0.3
		curve: 'ease-in-out'

dot4.states.s3 = 
	y: 58
	height: 8
	backgroundColor: 'rgba(255, 255, 255, 0.5)'
	options:
		time: 0.3
		curve: 'ease-in-out'

dot4.states.s4 = 
	y: 42
	height: 24
	backgroundColor: 'rgba(255, 255, 255, 0.9)'
	options:
		time: 0.3
		curve: 'ease-in-out'

dot4.states.s5 = 
	y: 42
	height: 8
	backgroundColor: 'rgba(255, 255, 255, 0.5)'
	options:
		time: 0.3
		curve: 'ease-in-out'

dot5.states.s1 = 
	y: 72
	height: 8
	backgroundColor: 'rgba(255, 255, 255, 0.5)'
	options:
		time: 0.3
		curve: 'ease-in-out'

dot5.states.s2 = 
	y: 72
	height: 8
	backgroundColor: 'rgba(255, 255, 255, 0.5)'
	options:
		time: 0.3
		curve: 'ease-in-out'

dot5.states.s3 = 
	y: 72
	height: 8
	backgroundColor: 'rgba(255, 255, 255, 0.5)'
	options:
		time: 0.3
		curve: 'ease-in-out'

dot5.states.s4 = 
	y: 72
	height: 8
	backgroundColor: 'rgba(255, 255, 255, 0.5)'
	options:
		time: 0.3
		curve: 'ease-in-out'

dot5.states.s5 = 
	y: 56
	height: 24
	backgroundColor: 'rgba(255, 255, 255, 0.9)'
	options:
		time: 0.3
		curve: 'ease-in-out'

cliper.states.normal = 
	width: cliper.width
	options: 
		time: 0.4
		curve: 'ease-in-out'

cliper.states.shrink = 
	width: cliper.width - 66
	options: 
		time: 0.4
		curve: 'ease-in-out'

tagRightMask.states.normal = 
	x: tagRightMask.x
	options: 
		time: 0.4
		curve: 'ease-in-out'

tagRightMask.states.shrink = 
	x: tagRightMask.x - 66
	options: 
		time: 0.4
		curve: 'ease-in-out'

guide.states.vanish = 
	opacity: 0
	options: 
		time: 0.3
		curve: 'linear'

guide.states.show = 
	opacity: 1
	options: 
		time: 0.3
		curve: 'linear'

guide.stateSwitch('vanish')

mask.states.vanish = 
	opacity: 0
	options: 
		time: 0.2
		curve: 'linear'

mask.states.show = 
	opacity: 1
	options: 
		time: 0.2
		curve: 'linear'

mask.stateSwitch('vanish')

arrow.states.normal = 
	rotation: 0
	options: 
		time: 0.4
		curve: 'ease-in-out'

arrow.states.rota = 
	rotation: 180
	options: 
		time: 0.4
		curve: 'ease-in-out'

tag.states.bgShow = 
	backgroundColor: 'rgba(0, 0, 0, 1)'
	options: 
		time: 0.4

tag.states.bgVanish = 
	backgroundColor: 'rgba(0, 0, 0, 0)'
	options: 
		time: 0.4

dotTo1 = () ->
	dot1.animate('s1')
	dot2.animate('s1')
	dot3.animate('s1')
	dot4.animate('s1')
	dot5.animate('s1')

dotTo2 = () ->
	dot1.animate('s2')
	dot2.animate('s2')
	dot3.animate('s2')
	dot4.animate('s2')
	dot5.animate('s2')
	
dotTo3 = () ->
	dot1.animate('s3')
	dot2.animate('s3')
	dot3.animate('s3')
	dot4.animate('s3')
	dot5.animate('s3')

dotTo4 = () ->
	dot1.animate('s4')
	dot2.animate('s4')
	dot3.animate('s4')
	dot4.animate('s4')
	dot5.animate('s4')

dotTo5 = () ->
	dot1.animate('s5')
	dot2.animate('s5')
	dot3.animate('s5')
	dot4.animate('s5')
	dot5.animate('s5')

roll = () ->
	Utils.delay 3, ->
		(texts.animate
			x: -353
			options: 
				time: 9
				curve: 'linear').on Events.AnimationEnd, ->
					texts.x = 7
					roll()

roll()

mask.on Events.Click, ->
mask.visible = false

showGuide = () ->
	tagRightMask.animate('shrink')
	cliper.animate('shrink')
	guide.animate('show')

vanishGuide = () ->
	tagRightMask.animate('normal')
	cliper.animate('normal')
	guide.animate('vanish')

maskShow = () ->
	showGuide()
	mask.animate('show')
	arrow.animate('rota')
	tag.animate("bgVanish")
	mask.visible = true
	page.currentPage.subLayers[2].player.pause()

maskVanish = () ->
	vanishGuide()
	mask.animate('vanish').on Events.AnimationEnd, ->
		mask.visible = false
	arrow.animate('normal')
	tag.animate("bgShow")
	page.currentPage.subLayers[2].player.play()
	
page.on 'change:currentPage', ->
	vA.player.pause()
	vB.player.pause()
	vC.player.pause()
	vD.player.pause()
	vE.player.pause()
	
	if page.currentPage.name == 'videoA'
		vA.player.play()
		dotTo1()
	
	if page.currentPage.name == 'videoB'
		vB.player.play()
		dotTo2()
		
	if page.currentPage.name == 'videoC'
		vC.player.play()
		dotTo3()
	
	if page.currentPage.name == 'videoD'
		vD.player.play()
		dotTo4()
	
	if page.currentPage.name == 'videoE'
		vE.player.play()
		dotTo5()

hitArea.on Events.Click, ->
	if !isShow
		maskShow()
	else
		maskVanish()
	isShow = !isShow
