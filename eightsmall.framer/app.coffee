# Import file "forframer2"
skt = Framer.Importer.load("imported/forframer2@1x")
# Import file "forframer"

skt.mainScreen.clip = true
skt.mainScreen.height = 1334
skt.mainScreen.width = 750
screenWidth = screen.width * window.devicePixelRatio
screenHeight = screen.height * window.devicePixelRatio

if Utils.isPhone()
	Framer.Device.fullScreen = true
	if screenWidth > 750
		skt.mainScreen.scale = screenWidth/900
		skt.mainScreen.y = (screenHeight - 64*devicePixelRatio - skt.mainScreen.height)/2
	else
		skt.mainScreen.y = (screenHeight - skt.mainScreen.height)/2
	skt.mainScreen.x = (screenWidth - skt.mainScreen.width)/2

skt.gm1.image = "images/1.gif"
skt.gm2.image = "images/2.gif"
skt.gm3.image = "images/3.gif"
skt.gm4.image = "images/4.gif"
skt.gm5.image = "images/5.gif"
skt.gm6.image = "images/6.gif"
skt.gm7.image = "images/5.gif"
skt.gm8.image = "images/4.gif"
skt.gm9.image = "images/3.gif"
skt.gm10.image = "images/2.gif"

skt.gifs.draggable.enabled = true
skt.gifs.draggable.speedY = 0
skt.gifs.draggable.constraints = {
	y: 324
	width: 1200
	height: 400
	x: -216
}