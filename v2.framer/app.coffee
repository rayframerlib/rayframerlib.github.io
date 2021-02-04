Framer.Extras.Hints.disable()

sub.width = 375
sub.height = 812

sub.clip = true
sub.centerY()
sub.centerX()

pageHandler = new PageComponent
	superLayer: sub
	width: Screen.width
	height: Screen.height
	scrollHorizontal: false
	
for number in [0...8]
	pageContent = new Layer
		width: pageHandler.width
		height: pageHandler.height
		y: pageHandler.height * number
		backgroundColor: 'transparent'
		parent: pageHandler.content

animateHandler = new Layer
	visible: false

scene2Video.clip = true
scene1Video.clip = true

scene2Clip = new VideoLayer
	superLayer: scene2Video
	width: 343
	height: 610
	video: "images/kk.mp4"

scene2Clip.player.loop = true
scene2Clip.centerY()

scene1Clip = new VideoLayer
	superLayer: scene1Video
	width: 343
	height: 610
	video: "images/kk1.mp4"

scene1Clip.player.loop = true
scene1Clip.centerY()

#第零幕动画
scene0.states.show = 
	opacity: 1
	y: scene0.y
	options: 
		time: 0.8

scene0.states.showVanish1 = 
	opacity: 0.05
	y: scene0.y - 200
	options: 
		time: 0.8
		
scene0.states.showVanish2 = 
	opacity: 0.05
	y: scene0.y - 300
	options: 
		time: 0.8

scene0.states.showVanish3 = 
	opacity: 0
	y: scene0.y - 400
	options: 
		time: 0.8

scene0.stateSwitch('show')

# 第零幕球球动画
scene0Balls.states.step0 = 
	y: scene0Balls.y
	options: 
		time: 0.8
		
scene0Balls.states.step1 = 
	y: scene0Balls.y - 200
	options: 
		time: 0.8


# 第零幕字动画
scene0Text.states.step0 = 
	y: scene0Text.y
	opacity: 1
	options: 
		time: 0.8
		
scene0Text.states.step1 = 
	y: scene0Text.y - 100
	opacity: 0
	options: 
		time: 0.8

#第一幕动画
scene1Text2.text = ''
scene1Text4.text = ''

# 场景一
scene1.states.vanish = 
	y: scene1.y + 200
	opacity: 0
	options: 
		time: 0.8

scene1.states.show1 = 
	y: scene1.y
	opacity: 1
	options: 
		time: 0.8

scene1.states.show2 = 
	y: scene1.y - 150
	opacity: 1
	options: 
		time: 0.8

scene1.states.show3 = 
	y: scene1.y - 550
	opacity: 1
	options: 
		time: 0.8

scene1.states.showVanish = 
	y: scene1.y - 900
	opacity: 0
	options: 
		time: 0.8

#场景一第一行字
scene1Text1.states.vanish =
	y: scene1Text1.y + 20
	blur: 20
	opacity: 0
	options: 
		time: 0.4

scene1Text1.states.show = 
	y: scene1Text1.y
	blur: 0
	opacity: 1
	options: 
		time: 0.4
		
scene1Text1.states.showVanish = 
	y: scene1Text1.y - 20
	blur: 20
	opacity: 0
	options: 
		time: 0.4

#场景一第二行字
scene1Text3.states.vanish =
	y: scene1Text3.y + 20
	blur: 20
	opacity: 0
	options: 
		time: 0.4

scene1Text3.states.show = 
	y: scene1Text3.y
	blur: 0
	opacity: 1
	options: 
		time: 0.4

scene1Text3.states.showVanish = 
	y: scene1Text3.y + 80
	blur: 20
	opacity: 0
	options: 
		time: 0.4

#场景一小球球
scene1Diseace.states.normal = 
	x: scene1Diseace.x
	y: scene1Diseace.y
	opacity: 1
	options: 
		time: 1
		curve: Spring(damping: 1)
		
scene1Diseace.states.change = 
	x: scene1Diseace.x - 100
	y: scene1Diseace.y + 80
	opacity: 1
	options: 
		time: 1.5
		curve: Spring(damping: 1)
		
scene1Diseace.states.change2 = 
	x: scene1Diseace.x - 100
	y: scene1Diseace.y + 160
	opacity: 0
	options: 
		time: 0.8

#场景一大球球
scene1Diseace2.states.normal = 
	y: scene1Diseace.y
	opacity: 1
	options: 
		time: 1.5
		curve: Spring(damping: 1)
		
scene1Diseace2.states.change = 
	y: scene1Diseace.y + 40
	opacity: 0
	options: 
		time: 0.8

#场景一小球球背景
scene1DiseaceCircle.states.show = 
	scale: 1
	opacity: 1
	options: 
		time: 1.5
		curve: Spring(damping: 1)

scene1DiseaceCircle.states.vanish = 
	scale: 0.2
	opacity: 0
	options: 
		time: 0.5
		curve: Spring(damping: 1)

#场景一大球球背景
scene1DiseaceCircle2.states.show = 
	scale: 1
	opacity: 1
	options: 
		time: 1.5
		curve: Spring(damping: 1)

scene1DiseaceCircle2.states.vanish = 
	scale: 0.2
	opacity: 0
	options: 
		time: 0.5
		curve: Spring(damping: 1)

# 场景一大球球数字
scene1DiseaceNumber.states.show = 
	opacity: 1
	options: 
		time: 0.5

scene1DiseaceNumber.states.vanish = 
	opacity: 0
	options: 
		time: 0.5
		
# 场景一小球球数字
scene1DiseaceNumber2.states.show = 
	opacity: 1
	options: 
		time: 0.5

scene1DiseaceNumber2.states.vanish = 
	opacity: 0
	options: 
		time: 0.5

# 场景一视频
scene1Video.states.show1 = 
	y: scene1Video.y
	opacity: 1
	options: 
		time: 0.8

scene1Video.states.show2 = 
	y: scene1Video.y + 30
	opacity: 1
	options: 
		time: 0.8

scene1Video.states.show3 = 
	y: scene1Video.y - 60
	opacity: 1
	options: 
		time: 0.8

#场景一灯塔
scene1Lighthouse.states.step0 = 
	opacity: 0
	y: scene1Lighthouse.y + 60
	options:
		time: 0.8

scene1Lighthouse.states.step1 = 
	opacity: 1
	y: scene1Lighthouse.y
	options:
		time: 0.8

scene1.stateSwitch('vanish')
scene1Text1.stateSwitch('vanish')
scene1Text3.stateSwitch('vanish')
scene1DiseaceNumber.stateSwitch('vanish')
scene1DiseaceNumber2.stateSwitch('vanish')
scene1DiseaceCircle.stateSwitch('vanish')
scene1DiseaceCircle2.stateSwitch('vanish')
scene1Lighthouse.stateSwitch('step0')

#第二幕动画
scene1Text2.text = ''
scene1Text4.text = ''

# 第二幕场景动画
scene2.states.vanish = 
	y: scene2.y + 200
	opacity: 0
	options: 
		time: 0.8

scene2.states.show1 = 
	y: scene2.y
	opacity: 1
	options: 
		time: 0.8

scene2.states.show2 = 
	y: scene2.y - 50
	opacity: 1
	options: 
		time: 0.8
		
scene2.states.show3 = 
	y: scene2.y - 300
	opacity: 1
	options: 
		time: 0.8

scene2.states.showVanish = 
	y: scene2.y - 600
	opacity: 0
	options: 
		time: 0.8

# 第二幕第一行文字
scene2Text1.states.vanish =
	y: scene2Text1.y - 10
	blur: 20
	opacity: 0
	options: 
		time: 0.4

scene2Text1.states.show = 
	y: scene2Text1.y
	blur: 0
	opacity: 1
	options: 
		time: 0.4

scene2Text1.states.showVanish = 
	y: scene2Text1.y - 20
	blur: 20
	opacity: 0
	options: 
		time: 0.4

# 第二幕第二行文字
scene2Text3.states.vanish =
	y: scene2Text3.y + 20
	blur: 20
	opacity: 0
	options: 
		time: 0.4

scene2Text3.states.show = 
	y: scene2Text3.y
	blur: 0
	opacity: 1
	options: 
		time: 0.4

scene2Text3.states.show2 = 
	y: scene2Text3.y
	blur: 20
	opacity: 0
	options: 
		time: 0.8
		
# 第二幕第一个条条背景
	
scene2DiseaceArea.states.show = 
	width: 194
	opacity: 1
	options: 
		time: 1.5
		curve: Spring(damping: 1)

scene2DiseaceArea.states.show = 
	width: 194
	opacity: 1
	options: 
		time: 1.5
		curve: Spring(damping: 1)

scene2DiseaceArea.states.vanish = 
	width: 150
	opacity: 0
	options: 
		time: 0.5
		curve: Spring(damping: 1)

# 第二幕第一个条条
scene2Diseace.states.show1 = 
	y: scene2Diseace.y
	opacity: 1
	options: 
		time: 0.5

scene2Diseace.states.show2 = 
	y: scene2Diseace.y + 60
	opacity: 0.34
	options: 
		time: 0.5

scene2Diseace.states.show3 = 
	y: scene2Diseace.y + 60
	opacity: 0
	options: 
		time: 0.8

# 第二幕第二个条条背景
scene2DiseaceArea2.states.show = 
	width: 342
	opacity: 1
	options: 
		time: 1.5
		curve: Spring(damping: 1)

scene2DiseaceArea2.states.vanish = 
	width: 150
	opacity: 0
	options: 
		time: 0.5
		curve: Spring(damping: 1)
		

# 第二幕第二个条
scene2Diseace2.states.vanish = 
	opacity: 0
	options: 
		time: 0.5

scene2Diseace2.states.show = 
	opacity: 1
	options: 
		time: 0.5

scene2Diseace2.states.show2 = 
	opacity: 0
	options: 
		time: 0.8

# 第二幕视频

scene2Video.states.show1 = 
	y: scene2Video.y
	opacity: 1
	options: 
		time: 0.8

scene2Video.states.show2 = 
	y: scene2Video.y - 60
	opacity: 1
	options: 
		time: 0.8

scene2Video.states.show3 = 
	y: scene2Video.y - 350
	opacity: 1
	options: 
		time: 0.8

scene2Text2.on 'change:width', ->
	scene2DiseaceNumberGroup.x = scene2Text2.x + scene2Text2.width + 9

scene2Text4.on 'change:width', ->
	scene2DiseaceNumberGroup2.x = scene2Text4.x + scene2Text4.width + 9

scene2.stateSwitch('vanish')
scene2Text1.stateSwitch('vanish')
scene2Text3.stateSwitch('vanish')
scene2DiseaceArea.stateSwitch('vanish')
scene2DiseaceArea2.stateSwitch('vanish')
# scene1DiseaceNumber.stateSwitch('vanish')
# scene1DiseaceNumber2.stateSwitch('vanish')
# scene1DiseaceCircle.stateSwitch('vanish')
# scene1DiseaceCircle2.stateSwitch('vanish')

#第三幕动画
scene3.states.vanish = 
	y: scene3.y + 200
	opacity: 0
	options: 
		time: 0.8

scene3.states.show1 = 
	y: scene3.y
	opacity: 1
	options: 
		time: 0.8
		
scene3.stateSwitch('vanish')



pageHandler.content.on Events.DragEnd, ->
	if pageHandler.currentPage == pageHandler.content.subLayers[0]
		animateHandler.x = 0
	else if pageHandler.currentPage == pageHandler.content.subLayers[1]
		animateHandler.x = 1
	else if pageHandler.currentPage == pageHandler.content.subLayers[2]
		animateHandler.x = 2
	else if pageHandler.currentPage == pageHandler.content.subLayers[3]
		animateHandler.x = 3
	else if pageHandler.currentPage == pageHandler.content.subLayers[4]
		animateHandler.x = 4
	else if pageHandler.currentPage == pageHandler.content.subLayers[5]
		animateHandler.x = 5
	else if pageHandler.currentPage == pageHandler.content.subLayers[6]
		animateHandler.x = 6
	else if pageHandler.currentPage == pageHandler.content.subLayers[7]
		animateHandler.x = 7

animateHandler.on 'change:x', ->
	if @x == 0
		#
		scene1Text1.animate('vanish')
		scene1DiseaceCircle.animate('vanish')
		scene1Text2.text = ''
		scene1DiseaceNumber.text = ''
		scene1DiseaceNumber.animate('vanish')
		scene0.animate('show')
		scene0Balls.animate('step0')
		scene0Text.animate('step0')
		scene1.animate('vanish')
	else if @x == 1
		scene0.animate('showVanish1')
		scene0Balls.animate('step1')
		scene0Text.animate('step1')
		scene1Text4.text = ''
		scene1.animate('show1')
		scene1Text1.animate('show')
		scene1DiseaceCircle.animate('show')
		textType(['疫', '情'], scene1Text2)
		numberGrowth(0, 50, 2, scene1DiseaceNumber, 'w次搜索')
		scene1DiseaceNumber.animate('show')
		scene1Diseace.animate('normal')
		scene1DiseaceCircle2.animate('vanish')
		scene1Text3.animate('vanish')
		scene1DiseaceNumber2.animate('vanish')
		scene1Video.animate('show1')
		scene1Lighthouse.animate('step0')
	else if @x == 2
		scene0.animate('showVanish2')
		scene1.animate('show2')
		scene1Text3.animate('show')
		scene1DiseaceCircle2.animate('show')
		scene1Text1.animate('showVanish')
		scene1Diseace.animate('change')
		scene1Diseace2.animate('normal')
		scene1Clip.player.pause()
		textType(['抗','击', '疫', '情'], scene1Text4)
		numberGrowth(0, 405, 2, scene1DiseaceNumber2, 'w次搜索')
		scene1DiseaceNumber2.animate('show')
		scene1Video.animate('show2')
		scene2.animate('vanish')
		scene2Text1.animate('vanish')
		scene2DiseaceArea.animate('vanish')
		scene1Lighthouse.animate('step1')
		
	else if @x == 3
		scene0.animate('showVanish3')
		scene1.animate('show3')
		scene1Text3.animate('showVanish')
		scene1Diseace.animate('change2')
		scene1Diseace2.animate('change')
		scene1Video.animate('show3')
		scene2.animate('vanish')
		scene2Text1.animate('vanish')
		scene1Clip.player.play()
	else if @x == 4
		scene1.animate('showVanish')
		scene1Clip.player.pause()
		scene2.animate('show1')
		scene2Text1.animate('show')
		scene2Video.animate('show1')
		scene2Text3.animate('vanish')
		textType(['隔','离'], scene2Text2)
		numberGrowth(0, 12, 2, scene2DiseaceNumber, 'w次搜索')
		scene2DiseaceArea.animate('show')
		scene2DiseaceArea2.animate('vanish')
		scene2Diseace2.animate('vanish')
		scene2Diseace.animate('show1')
		
	else if @x == 5
		scene2.animate('show2')
		scene2Text1.animate('showVanish')
		scene2Video.animate('show2')
		scene2Text3.animate('show')
		textType(['做','饭'], scene2Text4)
		numberGrowth(0, 50, 2, scene2DiseaceNumber2, 'w次搜索')
		scene2DiseaceArea2.animate('show')
		scene2Diseace2.animate('show')
		scene2Diseace.animate('show2')
		scene2Clip.player.pause()
	
	else if @x == 6
		scene2.animate('show3')
		scene2Video.animate('show3')
		scene2Text3.animate('show2')
		scene2Diseace.animate('show3')
		scene2Diseace2.animate('show2')
		scene3.animate('vanish')
		scene2Clip.player.play()
		
	else if @x == 7
		scene2.animate('showVanish')
		scene3.animate('show1')
		scene2Clip.player.pause()
	

# 打字效果
addText = (texts, layer, i) ->
	Utils.delay i * 0.2 + Utils.randomNumber(0,0.2), ->
		layer.text = layer.text + texts[i]

textType = (texts, layer) ->
	layer.text = ''
	for i in [0...texts.length]
		addText(texts, layer, i)

# 数字上涨效果

numberGrowth = (start, target, duration, number, text) ->
	numberGrowthHandler = new Layer
		x: 0
		visible:  false
	numberGrowthHandler.x = start
	(numberGrowthHandler.animate
		x: target
		options: 
			time: duration
			curve: Spring(damping: 1)).on Events.AnimationEnd, ->
				numberGrowthHandler.destroy()
	numberGrowthHandler.on 'change:x', ->
		number.text = Math.round(@x) + text

