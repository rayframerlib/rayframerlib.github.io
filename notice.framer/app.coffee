Framer.Extras.Hints.disable()

mainScreen.width = 375
mainScreen.height = 812

mainScreen.clip = true
mainScreen.centerY()
mainScreen.centerX()

showOption = 
	time: 0.4
	curve: Spring(damping: 1)

switchOption =
	time: 0.4
	curve: Spring(damping: 1)

vanishOption =
	time: 0.4
	curve: 'cubic-bezier(.55,0,.80,.3)'

class Notice extends Layer
	constructor: (@options={}) ->
		@options.width ?= 375
		@options.height ?= 124
		@options.backgroundColor ?= 'transparent'
		
		super @options
		
		@toDestroy = false
		
		@noticePop = new Layer
			superLayer: @
			x: 8
			width: 359
			height: 80
			backgroundColor: 'white'
			borderRadius: 12
		
		@noticePop.states.unShow = 
			y: -80
			opacity: 1
			
		@noticePop.states.show = 
			y: 44
			opacity: 1
			options: showOption
		
		@noticePop.states.switchNotice = 
			y: 44
			scale: 0.8
			opacity: 0
			options: switchOption
		
		@noticePop.states.vanish = 
			y: -80
			opacity: 1
			options: vanishOption
		
		@noticeInit()
		
	noticeSwitch: () ->
		mainLayer = @
		@noticePop.animate('switchNotice').on Events.AnimationEnd, ->
			mainLayer.destroy()
	
	noticeInit: () ->
		@noticePop.stateSwitch('unShow')
		@noticePop.animate('show')
		temp = @noticePop
		mainTemp = @
		Utils.delay 2, ->
			if !mainTemp.toDestroy
				temp.animate('vanish').on Events.AnimationEnd, ->
					mainTemp.destroy()
				
			
		
trigger.on Events.Click, ->
	if noticeLayer.children.length
		temp = noticeLayer.children[noticeLayer.children.length - 1]
		if !temp.toDestroy
			temp.toDestroy = true
			temp.noticeSwitch()
			
		layer = new Notice
			superLayer: noticeLayer
	else
		layer = new Notice
			superLayer: noticeLayer

