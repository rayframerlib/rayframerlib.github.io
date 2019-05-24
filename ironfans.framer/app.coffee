MainScreen.width = 414
MainScreen.height = 736

Content.draggable.enabled = true
Content.draggable.speedX = 0
Content.draggable.constraints = {
	x: 0
	y: NavigationBar.height + (MainScreen.height - NavigationBar.height - BottomBar.height) - Content.height
	width: 414
	height: 2 * Content.height - (MainScreen.height - NavigationBar.height - BottomBar.height)
}

Content.on "change:y", ->
	if (this.y + 552) >= NavigationBar.height
		Sort.y = this.y + 552
	else
		Sort.y = NavigationBar.height

class LikeButton extends Layer
	constructor: (@options = {}) ->
		@options.width ?= 64
		@options.height ?= 32
		@options.num ?= 31
		@options.backgroundColor ?= "rgba(255, 255, 255, 0.6)"
		
		super @options
		
		num = @options.num
		
		text = new TextLayer
			x: 37
			superLayer: this
			text: "#{num}"
			fontSize: 12
			color: "#939393"
		
		text.centerY()
			
for layers in Content.subLayers
	button = new LikeButton
		superLayer: Content
		x: layers.x
		y: layers.y


