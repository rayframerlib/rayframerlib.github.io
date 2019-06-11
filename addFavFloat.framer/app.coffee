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

#Resources card 资源
Resources = [
	{
		headerImg:"images/header0.png"
		contentImg:"images/content0.png"
		headImg:"images/head0.JPG"
		cardContentHeight: 542
	},
	{
		headerImg:"images/header1.png"
		contentImg:"images/content1.png"
		headImg:"images/head1.JPG"
		cardContentHeight: 259
	},
	{
		headerImg:"images/header2.png"
		contentImg:"images/content2.png"
		headImg:"images/head2.JPG"
		cardContentHeight: 473
	}
]

Buttons = []
Cards = []

#getSuperPoint 获取一个图层在目标图层位置的方法
getSuperPoint = (layer, targetLayer = null, lastPoint = [0, 0]) ->
	if layer.superLayer.id == targetLayer.id
		return [lastPoint[0] + layer.x, lastPoint[1] + layer.y]
	else
		lastPoint = [lastPoint[0] + layer.x, lastPoint[1] + layer.y]
		getSuperPoint(layer.superLayer, targetLayer, lastPoint)

#makeList 整理列表的方法
makeList = (layer, gap) ->
	totalHeight = 0 + gap
	for i in [0...layer.subLayers.length]
		layer.subLayers[i].y = totalHeight
		totalHeight = totalHeight + layer.subLayers[i].height + gap
	layer.height = totalHeight
	layer.draggable.constraints = {
		x: 0
		y: navigationBar.height + (mainScreen.height - navigationBar.height - bottomBar.height) - layer.height
		width: 414
		height: 2 * layer.height - (mainScreen.height - navigationBar.height - bottomBar.height)
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
		if @focused == true
			this.x = this.x + this.width - 60
			@ignoreEvents = false
			@plusIcon.image = "images/plusicon.png"
			@borderColor = "#ff8200"
			@textLayer.text = "关注"
			@textLayer.color = "#ff8200"
			this.width = 60
			@focused = false
		

#Jumper 跳动头像
class Jumper extends Layer
	constructor: (@options = {}) ->
		@options.x ?= 0
		@options.y ?= 0
		@options.width ?= 43
		@options.height ?= 43
		@options.borderRadius ?= 50
		@options.shadowX ?= 0
		@options.shadowY ?= 3
		@options.shadowBlur ?= 5
		@options.shadowColor ?= "rgba(0, 0, 0, 0.2)"
		@options.recall ?= null

		super @options
		this.jump = this.jump.bind(this)
		@originalLayer = this.superLayer
	
	jump: () ->
		superPoint = getSuperPoint(this, mainScreen)
		this.opacity = 1
		this.x = superPoint[0]
		this.y = superPoint[1]
		this.superLayer = mainScreen
		jumpTime = 0.45
		vanishTime = 0.3
# 		animateX = this.animate
# 			x: 148
# 			options:
# 				time: jumpTime
# 				curve: 'ease-out'

		animateY = new Animation this,	
			y: 32
			options:
				time: jumpTime
				curve: "ease-in-out"
		
		animateY.on Events.AnimationStart, (() ->
			originX = this.x
			originY = this.y
			this.on "change:y", ->
				yToFunction = Utils.modulate(this.y, [originY, 36],[-2, 0], true)
				this.x = Utils.modulate(Math.sqrt(1 - Math.pow(yToFunction, 2) / 4), [0, 1], [originX, 148])
			).bind(this)
		
		animateY.on Events.AnimationEnd, (() ->
			this.off "change:y"
			).bind(this)
		animateY.start()
		
		animateScaleIn = this.animate
			scale: 1.4
			options:
				time: jumpTime / 2
				curve: 'ease-out'
		
		animateScaleIn.on Events.AnimationEnd, (() ->
			animateScaleOut = this.animate
				scale: 1
				options:
					time: jumpTime / 2
					curve: 'ease-in'
			).bind(this)
		
		animateY.on Events.AnimationEnd, (()->
			animateVanish = this.animate
				scale: 0
				opacity: 0
				options:
					time: vanishTime
					curve: 'ease-out'
			Utils.delay vanishTime + 0.02, (()->
				this.superLayer = @originalLayer
				this.x = 0
				this.y = 0
				this.scale = 1
				if this.options.recall != null
					this.options.recall()
				).bind(this)
			).bind(this)
			
			
# 		animateY.on Events.AnimationEnd, (()->
# 			
# 			).bind(this)

#Card Feed 流内容
class Card extends Layer
	constructor: (@options = {}) ->
		@options.width ?= 414
		@options.cardHeaderHeight ?= 70
		@options.cardContentHeight ?= 200
		@options.headerImg ?= ""
		@options.contentImg ?= ""
		@options.headImg ?= ""
		@options.recall ?= null
		
		super @options
		
		@backgroundColor = "white"
		@height = @options.cardHeaderHeight + @options.cardContentHeight
		this.extendRecommand = this.extendRecommand.bind(this)
		this.setToNormal = this.setToNormal.bind(this)
		
		recommend = new Layer
			superLayer: this
			y: @options.cardHeaderHeight
			width: 414
			height: 258
			opacity: 0
			image: "images/recommand.png"
		
		content = new Layer
			superLayer: this
			y: @options.cardHeaderHeight
			image: @options.contentImg
			width: 414
			height: @options.cardContentHeight
			
		header = new Layer
			superLayer: this
			image: @options.headerImg
			width: 414
			height: @options.cardHeaderHeight
		
		jumper = new Jumper
			superLayer: header
			x: 14
			y: 15
			image: @options.headImg
			opacity: 0
			recall: this.extendRecommand
		
		focus = new FocusButton
			superLayer: header
			x: 317
			y: 19
			method: jumper.jump
	
	extendRecommand: () ->
		this.subLayers[0].opacity = 1
		this.subLayers[1].y = this.subLayers[0].height + this.subLayers[2].height + 12
		this.height = this.subLayers[0].height + this.subLayers[1].height + this.subLayers[2].height + 12
		if @options.recall != null
			@options.recall(content, 10)
	
	setToNormal: () ->
		this.subLayers[0].opacity = 0
		this.subLayers[1].y = this.subLayers[2].height
		this.height = this.subLayers[1].height + this.subLayers[2].height
		if @options.recall != null
			@options.recall(content, 10)


for i in [0...Resources.length]
	card = new Card
		superLayer: content
		headerImg: Resources[i].headerImg
		contentImg: Resources[i].contentImg
		headImg: Resources[i].headImg
		cardContentHeight: Resources[i].cardContentHeight
		recall: makeList
	
	Cards.push(card)
	Buttons.push(card.subLayers[2].subLayers[1])

makeList(content, 10)

navigationBar.on Events.Click, ->
	for i in [0...Buttons.length]
		Buttons[i].reset()
	for i in [0...Cards.length]
		Cards[i].setToNormal()