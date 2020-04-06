# Import file "forframer"
skt = Framer.Importer.load("imported/forframer@2x", scale: 1)
# Import file "forframer"

skt.mainScreen.clip = true
skt.mainScreen.center()
Framer.Extras.Hints.disable()
skt.naviMask.opacity = 0
skt.mainMask.opacity = 0
skt.pageContainerLow.image = null
skt.pageContainerHigh.image = null
skt.pageContainerTop.image = null


hitArea = new Layer
	superLayer: skt.mainScreen
	x: 310
	y: 360
	width: 62.5
	height: 49
	backgroundColor: "transparent"

textHitArea = new Layer
	superLayer: skt.mainScreen
	x: 0
	y: 64
	width: 375
	height: 260
	backgroundColor: "transparent"
	visible: false

page = new PageComponent
	x: 0
	y: 64
	width: 375
	height: 301
	superLayer: skt.mainScreen

page.placeBehind(skt.navigationBar)

page.content.draggable.speedX = 0
page.addPage(skt.pageContainerTop,"bottom")
page.addPage(skt.pageContainerHigh, "bottom")
page.addPage(skt.pageContainerLow,"bottom")
page.clip = false
page.content.clip = false
page.content.draggable = false
skt.newList.superLayer = skt.pageContainerLow
skt.newList.y = 0
skt.newList.draggable.speedX = 0
skt.newList.draggable.constraints = {
	x: 0
	y: 667 - 64 - skt.newList.height
	width: skt.pageContainerLow.width
	height: 2 * skt.newList.height - (667 - 64)
}
skt.newList.draggable.enabled = false

skt.keyboard.states.down =
	y: skt.keyboard.y + skt.keyboard.height
	animationOptions:
		time: 0.5
		curve: Spring(damping: 1)

skt.keyboard.states.up =
	y: skt.keyboard.y
	animationOptions:
		time: 0.5
		curve: Spring(damping: 1)

page.content.on Events.DragEnd, ->
	if page.currentPage == skt.pageContainerLow
		page.content.draggable.enabled = false
		skt.newList.draggable.enabled = true
		textHitArea.visible = false
	if page.currentPage == skt.pageContainerTop
		page.content.draggable.enabled = false
		skt.keyboard.animate("up")

skt.newList.on Events.DragEnd, ->
	if skt.newList.y > 100
		skt.newList.draggable.enabled = false
		page.content.draggable.enabled = true
		page.snapToPage(
			skt.pageContainerHigh,
			true
			animationOptions = 
				time: 1 
				curve: Spring(damping: 1))
		textHitArea.visible = true

hitArea.on Events.Click, ->
	if page.currentPage == skt.pageContainerTop
		textHitArea.visible = true
		page.content.draggable.enabled = true
		page.snapToPage(
				skt.pageContainerHigh,
				true
				animationOptions = 
					time: 0.5
					curve: Spring(damping: 1))
		skt.keyboard.animate("down")

textHitArea.on Events.Click, ->
	if page.currentPage == skt.pageContainerHigh
		page.content.draggable.enabled = false
		skt.keyboard.animate("up")
		page.snapToPage(
			skt.pageContainerTop,
			true
			animationOptions = 
				time: 0.5
				curve: Spring(damping: 1))

page.content.on "change:y", ->
	skt.toolBar.opacity = Utils.modulate(page.content.y, [-301, -256], [0, 1], true)
	skt.naviMask.opacity = Utils.modulate(page.content.y, [-470, -602], [0, 1])
	skt.mainMask.opacity = Utils.modulate(page.content.y, [-470, -602], [0, 1])