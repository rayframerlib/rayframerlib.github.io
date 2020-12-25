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
	video: "images/1594722252398313.mp4"

vD.player.loop = true
vD.player.muted = true
vD.placeBehind(videoDMask)

vE = new VideoLayer
	superLayer: videoE
	width: 418
	height: 729
	video: "images/1596181038946402.mp4"

vE.player.loop = true
vE.player.muted = true
vE.placeBehind(videoEMask)

navi.placeBefore(page)

isShow = false

bar.clip = true
getSearchBar = () ->
	roll = Utils.randomNumber(0, 10)
	if roll < 1
		bar.animate
			x: 46
			width: 107
			options: 
				time: 0.25
				curve: 'ease-in-out'
		
			
		tlong.animate
			opacity: 0
			options: 
				time: 0.25
				curve: 'ease-in-out'
		tshort.animate
			opacity: 0
			options: 
				time: 0.25
				curve: 'ease-in-out'
		tmid.animate
			opacity: 1
			options: 
				time: 0.25
				curve: 'ease-in-out'
	else if roll < 2
		bar.animate
			x: 0
			width: 153
			options: 
				time: 0.25
				curve: 'ease-in-out'
			
		tlong.animate
			opacity: 1
			options: 
				time: 0.25
				curve: 'ease-in-out'
		tshort.animate
			opacity: 0
			options: 
				time: 0.25
				curve: 'ease-in-out'
		tmid.animate
			opacity: 0
			options: 
				time: 0.25
				curve: 'ease-in-out'
	else
		bar.animate
			x: 75
			width: 78
			options: 
				time: 0.25
				curve: 'ease-in-out'
		tlong.animate
			opacity: 0
			options: 
				time: 0.25
				curve: 'ease-in-out'
		tshort.animate
			opacity: 1
			options: 
				time: 0.25
				curve: 'ease-in-out'
		tmid.animate
			opacity: 0
			options: 
				time: 0.25
				curve: 'ease-in-out'

getSearchBar()

page.on 'change:currentPage', ->
	vA.player.pause()
	vB.player.pause()
	vC.player.pause()
	vD.player.pause()
	vE.player.pause()
	
	if page.currentPage.name == 'videoA'
		vA.player.play()
	
	if page.currentPage.name == 'videoB'
		vB.player.play()
		getSearchBar()
				
	if page.currentPage.name == 'videoC'
		vC.player.play()
		getSearchBar()
	
	if page.currentPage.name == 'videoD'
		vD.player.play()
		getSearchBar()
		
	if page.currentPage.name == 'videoE'
		vE.player.play()
		getSearchBar()

page.content.on Events.AnimationEnd, ->
	if	page.currentPage.name == 'videoE'
		page.snapToPage(videoA,false)
		
			
