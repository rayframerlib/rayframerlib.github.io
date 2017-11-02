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

mainScreen = new Layer
	width: 375 * ratio
	height: 667 * ratio
	clip: true
	backgroundColor: "white"

mainScreen.center()

hitArea = new Layer
	superLayer: mainScreen

#Set up layers
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


emotionUnit.center()
hitArea.centerX()
hitArea.y = 400 * ratio

emotionSwitchAnimation = 
	time: 0.2
	curve: Spring(damping: 1)

#Normal states
emotionArea1.states.normal = 
	size: emotionSizeNormal
	y: emotionPadding
	animationOptions: emotionSwitchAnimation

emotionArea2.states.normal = 
	size: emotionSizeNormal
	y: emotionPadding
	animationOptions: emotionSwitchAnimation

emotionArea3.states.normal = 
	size: emotionSizeNormal
	y: emotionPadding
	animationOptions: emotionSwitchAnimation

emotionArea4.states.normal = 
	size: emotionSizeNormal
	y: emotionPadding
	animationOptions: emotionSwitchAnimation

emotionArea5.states.normal = 
	size: emotionSizeNormal
	y: emotionPadding
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
	y: 50 * ratio
	opacity: 0
	animationOptions: emotionSwitchAnimation

emotionBg.stateSwitch("vanish")

emotionXpositon = () ->
	emotionArea2.x = emotionPadding * 2 + emotionArea1.width
	emotionArea3.x = emotionPadding * 3 + emotionArea1.width + emotionArea2.width
	emotionArea4.x = emotionPadding * 4 + emotionArea1.width + emotionArea2.width + emotionArea3.width
	emotionArea5.x = emotionPadding * 5 + emotionArea1.width + emotionArea2.width + emotionArea3.width + emotionArea4.width

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

holder = new Layer
	visible: false
	x: 0
	y: 0

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

x0 = mainScreen.x + emotionUnit.x
x1 = mainScreen.x + emotionUnit.x + emotionPadding * 1.5 + emotionArea1.width
x2 = mainScreen.x + emotionUnit.x + emotionPadding * 2.5 + emotionArea1.width + emotionArea2.width
x3 = mainScreen.x + emotionUnit.x + emotionPadding * 3.5 + emotionArea1.width + emotionArea2.width + emotionArea3.width 
x4 = mainScreen.x + emotionUnit.x + emotionPadding * 4.5 + emotionArea1.width + emotionArea2.width + emotionArea3.width + emotionArea4.width
x5 = mainScreen.x + emotionUnit.x + emotionPadding * 6 + emotionArea1.width + emotionArea2.width + emotionArea3.width + emotionArea4.width + emotionArea5.width

emotionBg.on Events.Pan, (event)->
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

emotionArea1.on Events.LongPressStart, (event)->
	if holder.y == 0 
		emotionStateSwitch(1)
	emotionBg.animate("small")

emotionArea2.on Events.LongPressStart, ->
	if holder.y == 0 
		emotionStateSwitch(2)
	emotionBg.animate("small")

emotionArea3.on Events.LongPressStart, ->
	if holder.y == 0 
		emotionStateSwitch(3)
	emotionBg.animate("small")

emotionArea4.on Events.LongPressStart, ->
	if holder.y == 0 
		emotionStateSwitch(4)
	emotionBg.animate("small")

emotionArea5.on Events.LongPressStart, ->
	if holder.y == 0 
		emotionStateSwitch(5)
	emotionBg.animate("small")

holder.on "change:x", ->
	emotionStateSwitch(holder.x)

holder.on "change:y", ->
	switch holder.y
		when 1
			emotionBg.animate("small")
		else
			emotionBg.animate("normal")

hitArea.on Events.LongPress, ->
	if emotionBg.states.current.name == "vanish"
		emotionBg.animate ("normal")
	hitArea.on Events.Pan, (event)->
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

# emotionBg.on Events.PanEnd, (event)->
# 	print event.point
	