BodymovinLayer = require 'lottieLayer'
ratio = 3
unitWidth = 256 * ratio
emotionPadding = 6 * ratio
emotionVerticalPadding = 5 * ratio
emotionSizeBig = 72 * ratio
emotionSizeNormal = (unitWidth - emotionPadding * 6) / 5
unitHeightNormal = emotionSizeNormal + emotionPadding * 2
emotionSizeSmall = (unitWidth - emotionSizeBig - emotionPadding * 6) / 4
unitHeightSmall = emotionSizeSmall + emotionVerticalPadding * 2
activeAreaTop = 100 * ratio
activeAreaBottom = 50 * ratio
downDistance = 50 * ratio
halfDistance = 35 * ratio
unitStat = 0
touchStat = 0
panstat = 0

emotionSwitchAnimation = 
	time: 0.2
	curve: Spring(damping: 1)

activeAnimation = 
	time: 0.15
	curve: "ease-in"

#Set up layers
mainScreen = new Layer
	width: 375 * ratio
	height: 667 * ratio
	clip: true
	backgroundColor: "white"

bg = new Layer
	superLayer: mainScreen
	width: 375 * ratio
	height: 667 * ratio
	image: "images/IMG_1653.PNG"

hitArea = new Layer
	superLayer: mainScreen
	height: 33 * ratio
	width: 120 * ratio
	backgroundColor: "transparent"

emotionUnit = new Layer
	superLayer: mainScreen
	width: unitWidth
	height: unitHeightNormal
	backgroundColor: "transparent"

emotionBg = new Layer
	superLayer: emotionUnit
	width: unitWidth
	height: unitHeightNormal
	borderRadius: (unitHeightNormal / 2)
	backgroundColor: "rgba(255, 255, 255, 0.98)"
	borderColor: "rgba(0, 0, 0, 0.1)"
	borderWidth: 0.5 * ratio
	shadowY: 1 * ratio
	shadowBlur: 3 * ratio
	shadowColor: "rgba(0, 0, 0, 0.08)"

emotionArea1 = new Layer
	superLayer: emotionBg
	size: emotionSizeNormal
	borderRadius: emotionSizeBig / 2
	x: emotionPadding
	y: emotionPadding
	backgroundColor: "rgba(250,198,64,1)"
	
emotionArea2 = new Layer
	superLayer: emotionBg
	size: emotionSizeNormal
	borderRadius: emotionSizeBig / 2
	x: emotionPadding * 2 + emotionSizeNormal
	y: emotionPadding
	backgroundColor: "transparent"

emotionArea3 = new Layer
	superLayer: emotionBg
	size: emotionSizeNormal
	borderRadius: emotionSizeBig / 2
	x: emotionPadding * 3 + emotionSizeNormal * 2
	y: emotionPadding
	backgroundColor: "transparent"

emotionArea4 = new Layer
	superLayer: emotionBg
	size: emotionSizeNormal
	borderRadius: emotionSizeBig / 2
	x: emotionPadding * 4 + emotionSizeNormal * 3
	y: emotionPadding
	backgroundColor: "transparent"

emotionArea5 = new Layer
	superLayer: emotionBg
	size: emotionSizeNormal
	borderRadius: emotionSizeBig / 2
	x: emotionPadding * 5 + emotionSizeNormal * 4
	y: emotionPadding
	backgroundColor: "transparent"

emotion1 = new BodymovinLayer
	superLayer: emotionArea1
	jsonPath:'like1.json'
	autoplay: true
	looping: true
	width: emotionArea1.width
	height: emotionArea2.height

emotion2 = new BodymovinLayer
	superLayer: emotionArea2
	jsonPath:'haha.json'
	autoplay: true
	looping: true
	width: emotionArea1.width
	height: emotionArea2.height

emotion3= new BodymovinLayer
	superLayer: emotionArea3
	jsonPath:'wow.json'
	autoplay: true
	looping: true
	width: emotionArea1.width
	height: emotionArea2.height

emotion4 = new BodymovinLayer
	superLayer: emotionArea4
	jsonPath:'cry.json'
	autoplay: true
	looping: true
	width: emotionArea1.width
	height: emotionArea2.height

emotion5 = new BodymovinLayer
	superLayer: emotionArea5
	jsonPath:'angry.json'
	autoplay: true
	looping: true
	width: emotionArea1.width
	height: emotionArea2.height

holder = new Layer
	visible: false
	x: 0
	y: 0


#Normal states
emotionArea1.states.normal = 
	size: emotionSizeNormal
	y: emotionPadding
	opacity: 1
	animationOptions: emotionSwitchAnimation

emotionArea2.states.normal = 
	size: emotionSizeNormal
	y: emotionPadding
	opacity: 1
	animationOptions: emotionSwitchAnimation

emotionArea3.states.normal = 
	size: emotionSizeNormal
	y: emotionPadding
	opacity: 1
	animationOptions: emotionSwitchAnimation

emotionArea4.states.normal = 
	size: emotionSizeNormal
	y: emotionPadding
	opacity: 1
	animationOptions: emotionSwitchAnimation

emotionArea5.states.normal = 
	size: emotionSizeNormal
	y: emotionPadding
	opacity: 1
	animationOptions: emotionSwitchAnimation

#Big states
emotionArea1.states.big = 
	size: emotionSizeBig
	y: - (emotionSizeBig - unitHeightSmall + emotionPadding)
	animationOptions: emotionSwitchAnimation
		
emotionArea2.states.big = 
	size: emotionSizeBig
	y: - (emotionSizeBig - unitHeightSmall + emotionPadding)
	animationOptions: emotionSwitchAnimation

emotionArea3.states.big = 
	size: emotionSizeBig
	y: - (emotionSizeBig - unitHeightSmall + emotionPadding)
	animationOptions: emotionSwitchAnimation

emotionArea4.states.big = 
	size: emotionSizeBig
	y: - (emotionSizeBig - unitHeightSmall + emotionPadding)
	animationOptions: emotionSwitchAnimation
	
emotionArea5.states.big = 
	size: emotionSizeBig
	y: - (emotionSizeBig - unitHeightSmall + emotionPadding)
	animationOptions: emotionSwitchAnimation

#Small states
emotionArea1.states.small = 
	y: emotionVerticalPadding
	size: emotionSizeSmall
	animationOptions: emotionSwitchAnimation

emotionArea2.states.small = 
	y: emotionVerticalPadding
	size: emotionSizeSmall
	animationOptions: emotionSwitchAnimation

emotionArea3.states.small = 
	y: emotionVerticalPadding
	size: emotionSizeSmall
	animationOptions: emotionSwitchAnimation

emotionArea4.states.small = 
	y: emotionVerticalPadding
	size: emotionSizeSmall
	animationOptions: emotionSwitchAnimation

emotionArea5.states.small = 
	y: emotionVerticalPadding
	size: emotionSizeSmall
	animationOptions: emotionSwitchAnimation

#Active states
emotionArea1.states.activeZero = 
	x: emotionPadding
	y: emotionPadding
	size: emotionSizeNormal
	opacity: 0
	animationOptions: activeAnimation

emotionArea2.states.activeZero = 
	x: emotionPadding
	y: emotionPadding
	size: emotionSizeNormal
	opacity: 0
	animationOptions: activeAnimation

emotionArea3.states.activeZero = 
	x: emotionPadding
	y: emotionPadding
	size: emotionSizeNormal
	opacity: 0
	animationOptions: activeAnimation

emotionArea4.states.activeZero = 
	x: emotionPadding
	y: emotionPadding
	size: emotionSizeNormal
	opacity: 0
	animationOptions: activeAnimation

emotionArea5.states.activeZero = 
	x: emotionPadding
	size: emotionSizeNormal
	y: emotionPadding
	opacity: 0
	animationOptions: activeAnimation

emotionArea1.states.active = 
	x: emotionPadding
	y: emotionPadding
	size: emotionSizeNormal
	opacity: 1
	animationOptions: activeAnimation

emotionArea2.states.active = 
	x: emotionPadding
	y: emotionPadding
	size: emotionSizeNormal
	opacity: 1
	animationOptions: activeAnimation

emotionArea3.states.active = 
	x: emotionPadding
	y: emotionPadding
	size: emotionSizeNormal
	opacity: 1
	animationOptions: activeAnimation

emotionArea4.states.active = 
	x: emotionPadding
	y: emotionPadding
	size: emotionSizeNormal
	opacity: 1
	animationOptions: activeAnimation

emotionArea5.states.active = 
	x: emotionPadding
	size: emotionSizeNormal
	y: emotionPadding
	opacity: 1
	animationOptions: activeAnimation

# emotionBg states
emotionBg.states.normal = 
	height: unitHeightNormal
	y: 0
	opacity: 1
	animationOptions: emotionSwitchAnimation
	
emotionBg.states.small = 
	height: unitHeightSmall
	y: unitHeightNormal - unitHeightSmall
	animationOptions: emotionSwitchAnimation

emotionBg.states.vanish = 
	x: 0
	width: unitWidth
	y: downDistance
	opacity: 0
	animationOptions: emotionSwitchAnimation

emotionBg.states.activeVanish = 
	x: 170 * ratio
	y: halfDistance
	width: emotionSizeNormal + emotionPadding * 2
	height: unitHeightNormal
	animationOptions: activeAnimation

emotionBg.states.activeVanishSecond =
		y: downDistance
		opacity: 0
		animationOptions: 
			time: 0.15
			curve: "ease-out"

#Init
mainScreen.center()
emotionUnit.x = 108 * ratio
emotionUnit.y = 480 * ratio
hitArea.x = 250 * ratio
hitArea.y = 574 * ratio
emotionBg.stateSwitch("vanish")

# Emotion position control
emotionXpositon = () ->
	if emotionBg.states.current.name != "activeVanish" 
		emotionArea2.x = emotionPadding * 2 + emotionArea1.width
		emotionArea3.x = emotionPadding * 3 + emotionArea1.width + emotionArea2.width
		emotionArea4.x = emotionPadding * 4 + emotionArea1.width + emotionArea2.width + emotionArea3.width
		emotionArea5.x = emotionPadding * 5 + emotionArea1.width + emotionArea2.width + emotionArea3.width + emotionArea4.width

#Emotion Width Control
emotionArea1.on "change:width", ->
	emotionXpositon()
	emotion1.subLayers[0].size = emotionArea1.size
emotionArea2.on "change:width", ->
	emotionXpositon()
	emotion2.subLayers[0].size = emotionArea2.size
emotionArea3.on "change:width", ->
	emotionXpositon()
	emotion3.subLayers[0].size = emotionArea3.size
emotionArea4.on "change:width", ->
	emotionXpositon()
	emotion4.subLayers[0].size = emotionArea4.size
emotionArea5.on "change:width", ->
	emotionXpositon()
	emotion5.subLayers[0].size = emotionArea5.size

#Switch function
emotionStateSwitch = (chose) ->
	switch chose
		when 1
			emotionArea1.animate("big")
			emotionArea2.animate("small")
			emotionArea3.animate("small")
			emotionArea4.animate("small")
			emotionArea5.animate("small")
			
		when 2
			emotionArea1.animate("small")
			emotionArea2.animate("big")
			emotionArea3.animate("small")
			emotionArea4.animate("small")
			emotionArea5.animate("small")
			
		when 3
			emotionArea1.animate("small")
			emotionArea2.animate("small")
			emotionArea3.animate("big")
			emotionArea4.animate("small")
			emotionArea5.animate("small")
			
		when 4
			emotionArea1.animate("small")
			emotionArea2.animate("small")
			emotionArea3.animate("small")
			emotionArea4.animate("big")
			emotionArea5.animate("small")
			
		when 5
			emotionArea1.animate("small")
			emotionArea2.animate("small")
			emotionArea3.animate("small")
			emotionArea4.animate("small")
			emotionArea5.animate("big")
			
		else
			emotionArea1.animate("normal")
			emotionArea2.animate("normal")
			emotionArea3.animate("normal")
			emotionArea4.animate("normal")
			emotionArea5.animate("normal")

# Active function
active = (holder)->
	if unitStat == 1
		switch holder
			when 1
				emotionArea1.placeBefore(emotionArea5)
				emotionBg.animate("activeVanish")
				emotionArea1.animate("active")
				emotionArea2.animate("activeZero")
				emotionArea3.animate("activeZero")
				emotionArea4.animate("activeZero")
				emotionArea5.animate("activeZero")
				unitStat = 0
			when 2
				emotionArea2.placeBefore(emotionArea5)
				emotionBg.animate("activeVanish")
				emotionArea1.animate("activeZero")
				emotionArea2.animate("active")
				emotionArea3.animate("activeZero")
				emotionArea4.animate("activeZero")
				emotionArea5.animate("activeZero")
				unitStat = 0
			when 3
				emotionArea3.placeBefore(emotionArea5)
				emotionBg.animate("activeVanish")
				emotionArea1.animate("activeZero")
				emotionArea2.animate("activeZero")
				emotionArea3.animate("active")
				emotionArea4.animate("activeZero")
				emotionArea5.animate("activeZero")
				unitStat = 0
			when 4
				emotionArea4.placeBefore(emotionArea5)
				emotionBg.animate("activeVanish")
				emotionArea1.animate("activeZero")
				emotionArea2.animate("activeZero")
				emotionArea3.animate("activeZero")
				emotionArea4.animate("active")
				emotionArea5.animate("activeZero")
				unitStat = 0
			when 5
				emotionArea5.placeBefore(emotionArea5)
				emotionBg.animate("activeVanish")
				emotionArea1.animate("activeZero")
				emotionArea2.animate("activeZero")
				emotionArea3.animate("activeZero")
				emotionArea4.animate("activeZero")
				emotionArea5.animate("active")	
				unitStat = 0

#Holder control function
holderControl = ->
	if y0 <= event.point.y <= y1
		if x0 <= event.point.x < x1
			holder.x = 1
		else if x1 <= event.point.x < x2
			holder.x = 2
		else if x2 <= event.point.x < x3
			holder.x = 3
		else if x3 <= event.point.x < x4
			holder.x = 4
		else if x4 <= event.point.x < x5
			holder.x = 5
		else
			holder.x = 0
		
		if x0 <= event.point.x <= x5
			holder.y = 1
		else 
			holder.y = 0
	else
		holder.x = 0
		holder.y = 0

#Position Define
x0 = mainScreen.x + emotionUnit.x
x1 = mainScreen.x + emotionUnit.x + emotionPadding * 1.5 + emotionArea1.width
x2 = mainScreen.x + emotionUnit.x + emotionPadding * 2.5 + emotionArea1.width + emotionArea2.width
x3 = mainScreen.x + emotionUnit.x + emotionPadding * 3.5 + emotionArea1.width + emotionArea2.width + emotionArea3.width 
x4 = mainScreen.x + emotionUnit.x + emotionPadding * 4.5 + emotionArea1.width + emotionArea2.width + emotionArea3.width + emotionArea4.width
x5 = mainScreen.x + emotionUnit.x + emotionPadding * 6 + emotionArea1.width + emotionArea2.width + emotionArea3.width + emotionArea4.width + emotionArea5.width

y0 = mainScreen.y + emotionUnit.y - activeAreaTop
y1 = mainScreen.y + emotionUnit.y + unitHeightNormal + activeAreaBottom

holder.on "change:x", ->
	emotionStateSwitch(holder.x)

holder.on "change:y", ->
	if emotionBg.states.current.name != "activeVanishSecond"
		switch holder.y
			when 1
				emotionBg.animate("small")
			else
				emotionBg.animate("normal")

emotionBg.on Events.Pan, (event)->
	if unitStat == 1 && emotionBg.states.current.name != "activeVanish" 
		holderControl()

emotionBg.on Events.PanEnd, ->
	active(holder.x)

hitArea.on Events.LongPress, ->
	unitStat = 1
	emotionStateSwitch(0)
	if emotionBg.states.current.name == "vanish"
		emotionBg.animate ("normal")
	hitArea.on Events.Pan, (event)->
		holderControl()
	hitArea.on Events.PanEnd, ->
		active(holder.x)

hitArea.on Events.LongPressEnd, ->
	Utils.delay 0.1, ->
		hitArea.off Events.PanEnd
		hitArea.off Events.Pan

hitArea.on Events.TouchStart, ->
	if unitStat == 1
		touchStat = 1

hitArea.on Events.TouchEnd, ->
	if touchStat == 1
		emotionBg.animate ("vanish")
		unitStat = 0
		touchStat = 0

emotionBg.on Events.AnimationEnd, ->
	if emotionBg.states.current.name == "activeVanish"
		emotionBg.animate("activeVanishSecond")
		emotionArea4.placeBehind(emotionArea5)
		emotionArea3.placeBehind(emotionArea4)
		emotionArea2.placeBehind(emotionArea3)
		emotionArea1.placeBehind(emotionArea2)
		
		Utils.delay 0.15, ->
			holder.x = 0
			holder.y = 0
			emotionBg.stateSwitch("vanish")
			emotionXpositon()
			emotion1.subLayers[0].size = emotionArea1.size
			emotion2.subLayers[0].size = emotionArea2.size
			emotion3.subLayers[0].size = emotionArea3.size
			emotion4.subLayers[0].size = emotionArea4.size
			emotion5.subLayers[0].size = emotionArea5.size


emotionArea1.on Events.TouchEnd, ->
	if unitStat == 1
		active(1)

emotionArea2.on Events.TouchEnd, ->
	if unitStat == 1
		active(2)
	
emotionArea3.on Events.TouchEnd, ->
	if unitStat == 1
		active(3)

emotionArea4.on Events.TouchEnd, ->
	if unitStat == 1
		active(4)

emotionArea5.on Events.TouchEnd, ->
	if unitStat == 1
		active(5)
# emotionBg.on Events.PanEnd, (event)->
# 	print event.point

	

