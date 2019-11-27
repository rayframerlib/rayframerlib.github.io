Framer.Extras.Hints.disable()

mainScreen.width = 414
mainScreen.height = 736

mainScreen.clip = true
mainScreen.center()

if Screen.width < 414
	mainScreen.scale = Screen.width / 414
mainScreen.y = (Screen.height - mainScreen.height) / 2

Framer.Defaults.Animation =
	curve: Spring(damping: 1)
	time: 1

feed.draggable.enabled = true
feed.draggable.speedX = 0
feed.draggable.constraints = 
	x: 0 
	y: mainScreen.height - bottomBar.height - feed.height
	width: mainScreen.width 
	height: 2 * feed.height - (mainScreen.height - navigationBar.height - bottomBar.height)

content.image = 'images/feed.PNG'
subPage.image = 'images/sub.png'


# bottomBar.on Events.Click, ->
# 	carrier.show()

# buttons.subLayers[0].on Events.Click, ->
# 	carrier.show()