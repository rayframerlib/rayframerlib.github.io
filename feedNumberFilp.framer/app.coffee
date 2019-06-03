Framer.Extras.Hints.disable()

mainScreen.width = 414
mainScreen.height = 736

mainScreen.center()

content.draggable.enabled = true
content.draggable.speedX = 0
content.draggable.constraints = {
	x: 0
	y: navigationBar.height + (mainScreen.height - navigationBar.height - bottomBar.height) - content.height
	width: 414
	height: 2 * content.height - (mainScreen.height - navigationBar.height - bottomBar.height)
}

#RandomFlipNumber 数字翻页模块
class RandomFlipNumber extends Layer
	constructor: (@options = {}) ->
		@options.width ?= 16
		@options.height ?= 16
		@options.num ?= 31
		@options.numSize ?= 12
		@options.numColor ?= "#939393"
		@options.backgroundColor ?= "rgba(255, 255, 255, 1)"
		@options.flat ?= true
		@options.animOption ?= 
			curve: Spring(damping: 1)
			time: 1
		
		super @options
		
		animOption = @options.animOption
		numSize = @options.numSize
		numColor = @options.numColor	
		
		#新建图层与常数
		@textFirst = new TextLayer
			superLayer: this
			z: 100
			text: "#{@options.num}"
			fontSize: numSize
			color: numColor
		
		@textSecond = new TextLayer
			superLayer: this
			z: 100
			text: "#{@options.num + 1}"
			fontSize: numSize
			color: numColor
		
		@textFirst.centerY()
		@textSecond.centerY()
		
		higherPositionY = @textFirst.y - @textFirst.height / 2
		lowerPositionY = @textFirst.y + @textFirst.height / 2
		originY = @textFirst.y
		
		#元素状态设置
		@textFirst.states =
			upVanish:
				y: higherPositionY
				rotationX: -90
				opacity: 0
				animationOptions: animOption
			
			lowVanish:
				y: lowerPositionY
				rotationX: 90
				opacity: 0
				animationOptions: animOption
				
			show:
				y: originY
				rotationX: 0
				opacity: 1
				animationOptions: animOption
		
		@textSecond.states =
			upVanish:
				y: higherPositionY
				rotationX: -90
				opacity: 0
				animationOptions: animOption
			
			lowVanish:
				y: lowerPositionY
				rotationX: 90
				opacity: 0
				animationOptions: animOption
				
			show:
				y: originY
				rotationX: 0
				opacity: 1
				animationOptions: animOption
		
		@textFirst.stateSwitch("show")
		@textSecond.stateSwitch("lowVanish")
		
		
		#数字随机时间循环逻辑
		numSwitchCycle = (layer1, layer2) ->
			time = Utils.randomNumber(0, 4)
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

#CommentLikeButton 按钮模块
class Button extends Layer
	constructor: (@options = {}) ->
		@options.width ?= 138
		@options.height ?= 34
		@options.num ?= 31
		@options.backgroundColor ?= "#ffffff"
		@options.flat ?= true
		@options.active ?= false
		@options.buttonImg ?= ""
		
		super @options
		
		num = @options.num
		numSize = @options.numSize
		buttonImg = @options.buttonImg
		
		number = new RandomFlipNumber
			superLayer: this
			num: num
			numSize: 14
			numColor: "#636363"
			backgroundColor: "transparent"

		number.centerY()
			
		buttonImg = new Layer
			superLayer: this
			size: 18
			backgroundColor: "transparent"
			image: buttonImg
		
		buttonImg.centerY()
		
		buttonImg.x = (138 - (buttonImg.width + 34 + 6)) / 2
		number.x = (138 - (buttonImg.width + 34 + 6)) / 2 + buttonImg.width + 6

		this.on Events.MouseDown, ->
			this.backgroundColor = "#eeeeee"
		this.on Events.MouseUp, ->
			this.backgroundColor = "#ffffff"
		

for layer in likes.subLayers
	button = new Button
		superLayer: layer
		num: Math.round(Utils.randomNumber(5000, 9000))
		buttonImg: "images/unlike.png"
		x: 0
		y: 0

for layer in comments.subLayers
	button = new Button
		superLayer: layer
		num: Math.round(Utils.randomNumber(1000, 2000))
		buttonImg: "images/comment.png"
		x: 0
		y: 0

for layer in retweets.subLayers
	button = new Button
		superLayer: layer
		num: Math.round(Utils.randomNumber(1000, 2000))
		buttonImg: "images/retweet.png"
		x: 0
		y: 0
