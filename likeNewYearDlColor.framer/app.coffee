vanishiTime = 0
delayTime = 1.5
finalOpacity = 1
showTime = 0.2

# Import file and module
skt = Framer.Importer.load("imported/forframer@1x")
BodymovinLayer = require 'lottieLayer'

# ScreenScale
skt.Screen.center()
ratio = window.devicePixelRatio
skt.Screen.scale = ratio/2
skt.Screen.clip = true

#Init
Like1Enabled = false
Like2Enabled = false
Like3Enabled = false

Like1 = new BodymovinLayer
	superLayer: skt.FeedContent
	x: skt.AnimateArea1.x
	y: skt.AnimateArea1.y
	width: skt.AnimateArea1.width
	height: skt.AnimateArea1.height
	autoplay: false
	looping: false
Like2 = new BodymovinLayer
	width: skt.AnimateArea2.width
	height: skt.AnimateArea2.height
	autoplay: false
	looping: false
Like3 = new BodymovinLayer
	width: skt.AnimateArea3.width
	height: skt.AnimateArea3.height
	autoplay: false
	looping: false
LikeBig = new BodymovinLayer
	superLayer: skt.CardArea1
	jsonPath:'newyearlike.json'
	width: 400
	height: 400
	autoplay: false
	looping: false

AnimateAreaGroup = [skt.AnimateArea1, skt.AnimateArea2, skt.AnimateArea3]
HitAreaGroup = [skt.HitArea1, skt.HitArea2, skt.HitArea3]
LikeNumberGroup = [skt.LikeNumber1, skt.LikeNumber2, skt.LikeNumber3]
CardAreaGroup = [skt.CardArea1, skt.CardArea2, skt.CardArea3]
LikeGroup = [Like1, Like2, Like3]

for i in [0...3]
	AnimateAreaGroup[i].opacity = 0
	HitAreaGroup[i].opacity = 0
	LikeNumberGroup[i].opacity = 0
	CardAreaGroup[i].opacity = 0
	LikeGroup[i].superLayer = skt.FeedContent
	LikeGroup[i].x = AnimateAreaGroup[i].x
	LikeGroup[i].y = AnimateAreaGroup[i].y
	
skt.FeedContent.draggable.enabled = true
skt.FeedContent.draggable.speedX = 0
skt.FeedContent.draggable.constraints = {
	x: 0
	y: -1796
	width: 750
	height: 5000
}

#Animation
card1Show = new Animation
	layer: skt.CardArea1
	properties: {opacity: finalOpacity}
	time: showTime

card1Vanish = new Animation
	layer: skt.CardArea1
	properties: {opacity: 0}
	time: vanishiTime
	
card2Show = new Animation
	layer: skt.CardArea2
	properties: {opacity: finalOpacity}
	time: showTime

card2Vanish = new Animation
	layer: skt.CardArea2
	properties: {opacity: 0}
	time: vanishiTime

card3Show = new Animation
	layer: skt.CardArea3
	properties: {opacity: finalOpacity}
	time: showTime

card3Vanish = new Animation
	layer: skt.CardArea3
	properties: {opacity: 0}
	time: vanishiTime

#Event
bigAnimate = (i) ->
	if i == 0
		LikeBig.superLayer = skt.CardArea1
		if skt.CardArea1.height >= LikeBig.height
			if skt.CardArea1.height >= (skt.FeedContent.y + skt.CardArea1.y + skt.CardArea1.height - 128) >= 400
				LikeBig.y = 32 + (skt.CardArea1.height - skt.FeedContent.y - skt.CardArea1.y - LikeBig.height) / 2
			
			else if (skt.FeedContent.y + skt.CardArea1.y + skt.CardArea1.height - 128) < 400
				LikeBig.y = skt.CardArea1.height - 232 - LikeBig.height / 2
			else
				LikeBig.y = (skt.CardArea1.height - LikeBig.height) / 2 - 32
		else
			LikeBig.centerY()
		card1Show.start()
		Utils.delay delayTime, ->
			card1Vanish.start()
		Utils.delay delayTime+vanishiTime, -> 
			LikeBig.anim.goToAndStop(0, true)

	if i == 1
		LikeBig.superLayer = skt.CardArea2
		if skt.CardArea2.height >= LikeBig.height
			if skt.CardArea2.height >= (skt.FeedContent.y + skt.CardArea2.y + skt.CardArea2.height - 128) >= 400
				LikeBig.y = 32 + (skt.CardArea2.height - skt.FeedContent.y - skt.CardArea2.y - LikeBig.height) / 2
			
			else if (skt.FeedContent.y + skt.CardArea2.y + skt.CardArea2.height - 128) < 400
				LikeBig.y = skt.CardArea2.height - 232 - LikeBig.height / 2
			else
				LikeBig.y = (skt.CardArea2.height - LikeBig.height) / 2 - 32
		else
			LikeBig.centerY()
		card2Show.start()
		Utils.delay delayTime, ->
			card2Vanish.start()
		Utils.delay delayTime+vanishiTime, -> 
			LikeBig.anim.goToAndStop(0, true)

	if i == 2
		LikeBig.superLayer = skt.CardArea3
		if skt.CardArea3.height >= LikeBig.height
			if skt.CardArea3.height >= (skt.FeedContent.y + skt.CardArea3.y + skt.CardArea3.height - 128) >= 400
				LikeBig.y = 32 + (skt.CardArea3.height - skt.FeedContent.y - skt.CardArea3.y - LikeBig.height) / 2
			
			else if (skt.FeedContent.y + skt.CardArea3.y + skt.CardArea3.height - 128) < 400
				LikeBig.y = skt.CardArea3.height - 232 - LikeBig.height / 2
			else
				LikeBig.y = (skt.CardArea3.height - LikeBig.height) / 2 - 32
		else
			LikeBig.centerY()
		card3Show.start()
		Utils.delay delayTime, ->
			card3Vanish.start()
		Utils.delay delayTime + vanishiTime, -> 
			LikeBig.anim.goToAndStop(0, true)
	LikeBig.centerX()
	LikeBig.anim.play()
	

HitAreaGroup[0].on Events.Click, ->
	if Like1Enabled == false
		Like1.anim.play()
		LikeNumberGroup[0].opacity = 1
		Like1Enabled = true
		bigAnimate(0)
	else
		Like1.anim.goToAndStop(0, true)
		Like1Enabled = false
		LikeNumberGroup[0].opacity = 0
	

HitAreaGroup[1].on Events.Click, ->
	if Like2Enabled == false
		Like2.anim.play()
		LikeNumberGroup[1].opacity = 1
		Like2Enabled = true
		bigAnimate(1)
	else
		Like2.anim.goToAndStop(0, true)
		Like2Enabled = false
		LikeNumberGroup[1].opacity = 0

HitAreaGroup[2].on Events.Click, ->
	if Like3Enabled == false
		Like3.anim.play()
		LikeNumberGroup[2].opacity = 1
		Like3Enabled = true
		bigAnimate(2)
	else
		Like3.anim.goToAndStop(0, true)
		Like3Enabled = false
		LikeNumberGroup[2].opacity = 0

