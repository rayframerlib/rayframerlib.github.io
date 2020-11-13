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
	time: 0.3
	curve: 'cubic-bezier(.5,.05,.9,.6)'
	
dragVanishOption = 
	time: 0.15
	curve: 'ease-out'

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
		
		@noticeBar = new Layer
			superLayer: @noticePop
			width: 32
			height: 4
			y: 70
			backgroundColor:'#161823'
			borderRadius: 2
			opacity: 0.2
		
		@noticeBar.centerX()
		
		@noticePop.draggable.enabled = true
		@noticePop.draggable.speedX = 0
		@noticePop.draggable.constraints = 
			x: 0
			y: -80
			width: 375
			height: 204
		@noticePop.draggable.overdragScale = 0.1
		@noticePop.draggable.bounceOptions =
			friction: 40,
			tension: 400,
			tolerance: 0.0001
		
		_main = @
		_noticePop = @noticePop
		_noticePop.on Events.DragEnd, ->

			if _noticePop.y <= 24
				_noticePop.animate('dragVanish').on Events.AnimationEnd, ->
					_main.toDestroy = true
					_main.destroy()
			else 
				_noticePop.animate('show')
		
		_noticePop.states.unShow = 
			y: -80
			opacity: 1
			
		_noticePop.states.show = 
			y: 44
			opacity: 1
			options: showOption
		
		_noticePop.states.switchNotice = 
			y: 44
			scale: 0.8
			opacity: 0
			options: switchOption
		
		_noticePop.states.vanish = 
			y: -80
			opacity: 1
			options: vanishOption
		
		_noticePop.states.dragVanish = 
			y: -80
			opacity: 1
			options: dragVanishOption
		
		@noticeInit()
		
		
		
	noticeSwitch: () ->
		mainLayer = @
		@noticePop.draggable.enabled = false
		@noticePop.animate('switchNotice').on Events.AnimationEnd, ->
			mainLayer.destroy()
	
	noticeInit: () ->
		@noticePop.stateSwitch('unShow')
		@noticePop.animate('show')
		temp = @noticePop
		mainTemp = @
		Utils.delay 5, ->
			temp.draggable.enabled = false
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

