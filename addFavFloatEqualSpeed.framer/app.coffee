Framer.Extras.Hints.disable()
mainScreen.width = 414
mainScreen.height = 739

mainScreen.clip = true
mainScreen.center()

if Screen.width < 414
	mainScreen.scale = Screen.width / 414
mainScreen.y = (Screen.height - mainScreen.height) / 2

content.draggable.enabled = true
content.draggable.speedX = 0
content.draggable.constraints = {
	x: 0
	y: navigationBar.height + (mainScreen.height - navigationBar.height - bottomBar.height) - content.height
	width: 414
	height: 2 * content.height - (mainScreen.height - navigationBar.height - bottomBar.height)
}

#FocusButton 关注按钮
class FocusButton extends Layer
	constructor: (@options = {}) ->
		@options.width ?= 60
		@options.height ?= 28
		@options.backgroundColor ?= "transparent"
		@options.borderColor ?= "#ff8200"
		@options.borderWidth ?= 0.5
		@options.borderRadius ?= 14
		@options.method ?= ()->

		super @options
		
		@focused = false
		
		@plusIcon = new Layer
			superLayer: this
			x: 11
			y: 8
			size: 12
			backgroundColor: "transparent"
			image: "images/plusicon.png"
			
		@textLayer = new TextLayer
			superLayer: this
			x: 24
			y: 6
			text: "关注"
			fontSize: 12
			color: "ff8200"
		
		this.on Events.TouchStart, ->
			if @focused
			else
				this.backgroundColor = "rgba(255,130,0,0.05)"
			
		this.on Events.TouchEnd, ->
			if @focused
			else
				@focused = true
				this.backgroundColor = "transparent"
				this.borderColor = "rgba(147,147,147,0.4)"
				this.x = this.x + this.width - 73
				this.width = 73
				@plusIcon.image = "images/plusicongray.png"
				@textLayer.color = "#636363"
				@textLayer.text = "已关注"
				@ignoreEvents = true
				@options.method()
	
	reset: () ->
		@focused = false
		@ignoreEvents = false
		@plusIcon.image = "images/plusicon.png"
		@borderColor = "#ff8200"
		@textLayer.text = "关注"
		@textLayer.color = "#ff8200"
		this.width = 60
		this.x = 0


#Juper 跳动头像
class Jumper extends Layer
	constructor: (@options = {}) ->
		@options.width ?= 43
		@options.height ?= 43
		@options.borderRadius ?= 50
		@options.shadowX ?= 0
		@options.shadowY ?= 3
		@options.shadowBlur ?= 5
		@options.shadowColor ?= "rgba(0, 0, 0, 0.2)"
		super @options
		
		this.jump = this.jump.bind(this)
		
		@originalLayer = this.superLayer
	
	jump: () ->
		this.opacity = 1
		this.x = this.x + content.x + jumpers.x + this.superLayer.x
		this.y = this.y + content.y + jumpers.y + this.superLayer.y
		this.superLayer = mainScreen
		jumpTime = (this.y - 36) / 600
		animateX = this.animate
			x: 148
			options:
				time: jumpTime
				curve: 'ease-out'
				
		animateY = this.animate		
			y: 36
			options:
				time: jumpTime
				curve: 'ease-in'
		
		animateScaleIn = this.animate
			scale: 1.4
			options:
				time: jumpTime / 2
				curve: 'ease-out'
		
		animateScaleIn.on Events.AnimationEnd, (() ->
			animateScaleOut = this.animate
				scale: 0.2
				opacity: 0
				options:
					time: jumpTime / 2
					curve: 'ease-in'
			).bind(this)
		
		animateY.on Events.AnimationEnd, (()->
			Utils.delay 0.02, (()->
				this.superLayer = @originalLayer
				this.x = 0
				this.y = 0
				this.scale = 1
				).bind(this)
			).bind(this)

for i in [0...jumpers.subLayers.length]
	jumper = new Jumper
		superLayer: jumpers.subLayers[i]
		image: "images/#{i}.JPG"
		opacity: 0

for i in [0...buttons.subLayers.length]
	focue = new FocusButton
		superLayer: buttons.subLayers[i]
		method: jumpers.subLayers[i].subLayers[0].jump
		
navigationBar.on Events.Click, ->
	for layers in buttons.subLayers
		layers.subLayers[0].reset()