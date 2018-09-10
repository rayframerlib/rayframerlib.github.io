reset.visible = false

feed.draggable.enabled = true
feed.draggable.speedX = 0
feed.draggable.constraints = {
	x: 0
	y: mainScreen.height - bottomBar.height - feed.height - 10
	width: mainScreen.width
	height: 2 * feed.height - (mainScreen.height - navigationBar.height - bottomBar.height - 20)
}
feed.draggable.overdragScale = 0.4

scale.text = feed.draggable.overdragScale

feedDown = new Animation feed,
	y: mainScreen.height
	options:
		time: 0.4

naviOut = new Animation navigationBar,
	y: -navigationBar.height
	options:
		time: 0.4

bottomOut = new Animation bottomBar,
	y: mainScreen.height
	options:
		time: 0.4

setPosition = (yValue) ->
	feed.on Events.DragEnd, ->
		if feed.y > yValue + navigationBar.height + 10
			feed.draggable.enabled = false
			feedDown.start()
			naviOut.start()
			bottomOut.start()
			reset.visible = true
			
	feed.on "change:y", ->
		if feed.y > yValue + navigationBar.height + 10
			light.backgroundColor = "rgba(255, 0, 0, 0.5)"
		else
			light.backgroundColor = "rgba(0, 255, 0, 0.5)"

reset.on Events.Click, ->
	feed.draggable.enabled = true
	feed.y = navigationBar.height + 10
	navigationBar.y = 0
	bottomBar.y = mainScreen.height - bottomBar.height
	reset.visible = false
	
setPosition(110)

$110Button.on Events.Click, ->
	feed.off Events.DragEnd
	feed.off "change:y"
	setPosition(110)
	current.text = "110"

$140Button.on Events.Click, ->
	feed.off Events.DragEnd
	feed.off "change:y"
	setPosition(135)
	current.text = "135"

$180Button.on Events.Click, ->
	feed.off Events.DragEnd
	feed.off "change:y"
	setPosition(180)
	current.text = "180"

$1_3Button.on Events.Click, ->
	feed.off Events.DragEnd
	feed.off "change:y"
	setPosition(mainScreen.height / 3)
	current.text = "1/3"

$1_4Button.on Events.Click, ->
	feed.off Events.DragEnd
	feed.off "change:y"
	setPosition(mainScreen.height / 4)
	current.text = "1/4"

$1_5Button.on Events.Click, ->
	feed.off Events.DragEnd
	feed.off "change:y"
	setPosition(mainScreen.height / 5)
	current.text = "1/5"


	