Framer.Extras.Hints.disable()

mainScreen.width = 375
mainScreen.height = 667

mainScreen.clip = true
mainScreen.centerY()
mainScreen.centerX()

if Screen.width > 375
	mainScreen.scale = Screen.width / 375
mainScreen.y = (Screen.height - mainScreen.height) / 2

video = new VideoLayer
	superLayer: mainScreen
	size: mainScreen.size
	video: './videos/vid.mp4'

video.placeBehind(ui)
video.player.loop = true

Utils.delay 2, ->
	view.animate
		opacity: 0
		options: 
			time: 0.3
			curve: 'linear'
	
	video.player.play()
	
	Utils.delay 6 , ->
		video.player.pause()
	
ui.states.show = 
	opacity: 1
	options: 
		time: 0.3
		curve: 'linear'

ui.states.vanish = 
	opacity: 0
	options: 
		time: 0.3
		curve: 'linear'

ui.stateSwitch('vanish')

mask.states.show = 
	opacity: 1
	options: 
		time: 0.3
		curve: 'linear'

mask.states.vanish = 
	opacity: 0
	options: 
		time: 0.3
		curve: 'linear'

mask.stateSwitch('vanish')

redPacket.states.vanish = 
	x: 38
	y: 101
	opacity: 0
	scale: .3
	options: 
		time: 0.2
		curve: 'ease-in'

redPacket.states.show = 
	opacity: 1
	scale: 1
	options: 
		time: .5
		curve: Spring(damping: 0.6)

redPacket.states.hold = 
	scale: .126
	x: -106
	y: 220
	options: 
		time: 0.25
		curve: 'ease-in-out'

redPacket.states.extend = 
	scale: 1.25
	options: 
		time: 0.2
		curve: 'ease-in'

redPacket.stateSwitch('vanish')

cancelIcon.states.vanish = 
	opacity: 0
	options:
		time: 0.2
		curve: 'linear'

cancelIcon.states.show = 
	opacity: 1
	options: 
		time: 0.2
		curve: 'linear'

cancelIcon.stateSwitch('vanish')
cancelIcon.visible = false

redPacket.text = text

redPacket.text.states.vanish = 
	opacity: 0
	options:
		time: 0.2
		curve: 'linear'

redPacket.text.states.show = 
	opacity: 1
	options:
		time: 0.2
		curve: 'linear'

redPacketHold.states.vanish = 
	opacity: 0
	scale: .9

redPacketHold.states.show = 
	opacity: 1
	scale: 1
	options: 
		time: .4
		curve: Spring(damping: 0.6)

redPacketHold.stateSwitch('vanish') 

newPage.states.vanish = 
	opacity: 0
	options:
		time: 0.2
		curve: 'linear'

newPage.states.show = 
	opacity: 1
	options: 
		time: 0.2
		curve: 'linear'

newPage.stateSwitch('vanish')

pageContent.opacity = 0

pageAnimeTop.states.open = 
	y: -328
	options: 
		time: 0.3
		curve: 'ease-in-out'

pageAnimeBottom.states.open = 
	y: 667
	options: 
		time: 0.3
		curve: 'ease-in-out'
		
dialog.states.init = 
	opacity: 0
	scale: .8
	y: dialog.y
	

dialog.states.show = 
	scale: 1
	opacity: 1
	options: 
		time: .2
		curve: 'ease-out'

dialog.states.vanish = 
	opacity: 0
	y: dialog.y - 10
	options: 
		time: .2
		curve: 'ease-in'

dialog.stateSwitch('init')

ui.show = () ->
	ui.animate('show')

mask.show = () ->
	mask.animate('show')

mask.vanish = () ->
	mask.animate('vanish')

redPacket.show = () ->
	redPacket.animate('show')

redPacket.text.vanish = () ->
	redPacket.text.animate('vanish')

redPacketHold.show = () ->
	redPacketHold.animate('show')

redPacket.hold = () ->
	redPacket.text.vanish()
	redPacket.animate('hold').on Events.AnimationEnd, ->
		redPacketHold.show()
		dialog.animate('show').on Events.AnimationEnd, ->
			dialog.on Events.Click, ->
				dialog.animate('vanish')
				mask.vanish()
				video.player.play()
		(redPacket.animate 
			opacity: 0
			options: 
				time: 0.15
				curve: 'linear').on Events.AnimationEnd, ->
					redPacket.stateSwitch('vanish')
					redPacket.text.stateSwitch('show')
					

cancelIcon.vanish = () ->
	cancelIcon.animate('vanish').on Events.AnimationEnd, ->
		cancelIcon.visible = false

cancelIcon.show = () ->
	cancelIcon.visible = true
	cancelIcon.animate('show')
	
Events.wrap(video.player).on "pause", ->
	mask.show()
	redPacket.show()
	cancelIcon.show()

cancelIcon.on Events.Click, ->
# 	video.player.play()
	redPacket.hold()
	cancelIcon.vanish()
	ui.show()
	
	

packetHitArea.on Events.Click, ->
	packetHitArea.visible = false
	redPacket.animate('extend')
	redPacket.text.vanish()
	cancelIcon.vanish()
	newPage.animate('show').on Events.AnimationEnd, ->
		pageContent.opacity = 1
		pageAnimeTop.animate('open').on Events.AnimationEnd, ->
			pageAnimeTop.opacity = 0
		pageAnimeBottom.animate('open')