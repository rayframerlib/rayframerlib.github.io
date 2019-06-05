Framer.Extras.Hints.disable()

mainScreen.width = 414
mainScreen.height = 736

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

content.on "change:y", ->
	if (this.y + 552) >= navigationBar.height
		sort.y = this.y + 552
	else
		sort.y = navigationBar.height

#RandomFlipNumber 数字翻页模块
class RandomFlipNumber extends Layer
	constructor: (@options = {}) ->
		@options.width ?= 16
		@options.height ?= 24
		@options.num ?= 31
		@options.numSize ?= 12
		@options.backgroundColor ?= "rgba(255, 255, 255, 1)"
		@options.flat ?= true
		@options.clip ?= true
		@options.animOption ?= 
			curve: "ease-in-out"
			time: 0.3
		
		super @options
		
		animOption = @options.animOption
		numSize = @options.numSize
		
		#新建图层与常数
		@textFirst = new TextLayer
			superLayer: this
			z: 100
			text: "#{@options.num}"
			fontSize: numSize
			color: "#939393"
		
		@textSecond = new TextLayer
			superLayer: this
			z: 100
			text: "#{@options.num + 1}"
			fontSize: numSize
			color: "#939393"
		
		@textFirst.centerY()
		@textSecond.centerY()
		
		higherPositionY = @textFirst.y - @textFirst.height
		lowerPositionY = @textFirst.y + @textFirst.height
		originY = @textFirst.y
		
		#元素状态设置
		@textFirst.states =
			upVanish:
				y: higherPositionY
# 				rotationX: -90
				opacity: 0
				animationOptions: animOption
			
			lowVanish:
				y: lowerPositionY
# 				rotationX: 90
				opacity: 0
				animationOptions: animOption
				
			show:
				y: originY
# 				rotationX: 0
				opacity: 1
				animationOptions: animOption
		
		@textSecond.states =
			upVanish:
				y: higherPositionY
# 				rotationX: -90
				opacity: 0
				animationOptions: animOption
			
			lowVanish:
				y: lowerPositionY
# 				rotationX: 90
				opacity: 0
				animationOptions: animOption
				
			show:
				y: originY
# 				rotationX: 0
				opacity: 1
				animationOptions: animOption
		
		@textFirst.stateSwitch("show")
		@textSecond.stateSwitch("lowVanish")
		
		
		#数字随机时间循环逻辑
		numSwitchCycle = (layer1, layer2) ->
			time = Utils.randomNumber(2, 8)
			Utils.delay time, ->
				layer1.animate("upVanish")
				reporter = layer2.animate("show")
				reporter.on Events.AnimationEnd, ->
					reporter.off
					numAdd(layer1, layer2)
					layer1.stateSwitch("show")
					layer2.stateSwitch("lowVanish")
					numSwitchCycle(layer1, layer2)
		
		numAdd = ((layer1, layer2) -> 
			@options.num++
			layer1.text= "#{@options.num}"
			layer2.text= "#{@options.num + 1}"
			).bind(this)
		
		numSwitchCycle(@textFirst, @textSecond)
		
		#主宽度适配
		@textSecond.on "change:width", ->
			this.superLayer.width = this.width
		
	#方法
	setTextColor: (color) ->
		@textFirst.color = color
		@textSecond.color = color
		
	addTextNumber: () ->
		@options.num++
		@textFirst.text = "#{@options.num}"
		@textSecond.text = "#{@options.num + 1}"
	
	reduceTextNumber: () ->
		@options.num--
		@textFirst.text = "#{@options.num}"
		@textSecond.text = "#{@options.num + 1}"


#CommentThumb 大拇指模块
class CommentThumb extends Layer
	constructor: (@options = {}) ->
		@options.width ?= 18
		@options.height ?= 18
		@options.image ?= "images/unlike.png"
		@options.animOption ?= 
			curve: "ease-out"
			time: 0.2
		
		super @options
		
		animOption = @options.animOption
		
		@states =
			scale:
				scale: 1.3
				animationOptions: animOption
			
			normal:
				scale: 1
				animationOptions: animOption
		
	setRed: () ->
		@image = "images/like.png"
		scale = @animate("scale")
		normal = (() -> @animate("normal")).bind(this)
		scale.on Events.AnimationEnd, ->
			normal()
		
	setGray: () ->
		@image = "images/unlike.png"
		

#CommentLikeButton 评论赞按钮模块
class CommentLikeButton extends Layer
	constructor: (@options = {}) ->
		@options.width ?= 64
		@options.height ?= 32
		@options.num ?= 31
		@options.numSize ?= 12
		@options.backgroundColor ?= "rgba(255, 255, 255, 1)"
		@options.flat ?= true
		@options.active ?= false
		
		super @options
		
		num = @options.num
		numSize = @options.numSize
		
		number = new RandomFlipNumber
			x: 36
			superLayer: this
			num: num
			numSize: numSize
		
		thumb = new CommentThumb
			x: 15
			superLayer: this
		
		thumb.centerY()
		number.centerY()
		
		ClickController = (() -> 
			if @options.active
				number.reduceTextNumber()
				number.setTextColor("#939393")
				thumb.setGray()
				@options.active = false
			else
				number.addTextNumber()
				number.setTextColor("E14123")
				thumb.setRed()
				@options.active = true
			).bind(this) 

		this.on Events.Click, ->
			ClickController()
		
for layers in buttons.subLayers
	button = new CommentLikeButton
		superLayer: layers
		num: Math.round(Utils.randomNumber(30, 70))
		x: 0
		y: 0
