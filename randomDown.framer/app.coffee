Framer.Extras.Hints.disable()

mainScreen.width = 375
mainScreen.height = 812

mainScreen.clip = true
mainScreen.centerY()
mainScreen.centerX()

LayerDestroy = (layer, animate) ->
	animate.on Events.AnimationEnd, ->
		layer.destroy()	

# 粒子数量（以 375 屏幕宽度为基准）
particleNum = 0
# 粒子大小比率范围
particleSizeRange = []
# 粒子 x 轴生成范围
particleProductionXRange = []
# 单粒子生成间隔
particleProductionDelay = 0
# 粒子飘落终点 x 范围（相对于生成位置）
particleFallXRange = []
# 粒子飘落终点 y 范围
particleFallYRange = []
# 粒子飘落曲线
particleFallCurve = ''
# 粒子飘落平均速度范围
particleFallSpeedRange = []
# 粒子透明度变化范围
particleOpacityRange = []
# 粒子变化起始时间（相对飘落动画时长，0 为从头到尾，1 为没有动画）
particleOpacityAnimationStartTime = 0

imagePic = ""

down = () ->
	
	for i in [0...Math.round(area.width * particleNum / 375)]
		particleSize = Utils.randomNumber(particleSizeRange[0], particleSizeRange[1])
		randomX = Utils.randomNumber(particleProductionXRange[0], particleProductionXRange[1])
		particleFallHeight = Utils.randomNumber(particleFallYRange[0], particleFallYRange[1])
		particleFallSpeed = Utils.randomNumber(particleFallSpeedRange[0], particleFallSpeedRange[1])
		
		emoji = new Layer
			superLayer: area
			width: particleSize
			height: particleSize
			opacity: particleOpacityRange[0]
			image: imagePic
			x: randomX
			y: -particleSizeRange[1]
			
		emojiDown = new Animation emoji,
			x: randomX + Utils.randomNumber(particleFallXRange[0], particleFallXRange[1])
			y: particleFallHeight
			options:
				curve: particleFallCurve
				time: particleFallHeight / particleFallSpeed
				delay: i * particleProductionDelay
		
		emojiOpacity = new Animation emoji,
			opacity: particleOpacityRange[1]
			options:
				curve: 'linear'
				time: particleFallHeight / particleFallSpeed * (1 - particleOpacityAnimationStartTime)
				delay: i * particleProductionDelay + particleFallHeight / particleFallSpeed * particleOpacityAnimationStartTime
		
		emojiOpacity.start()
		emojiDown.start()
# 		LayerRotate(emoji, i)
		LayerDestroy(emoji, emojiDown)


jumpHitArea.on Events.Click, ->
	# 掉落
	# 粒子数量（以 375 屏幕宽度为基准）
	particleNum = 18
	# 粒子大小比率范围
	particleSizeRange = [30, 36]
	# 粒子 x 轴生成范围
	particleProductionXRange = [0, area.width]
	# 单粒子生成间隔
	particleProductionDelay = 0.25
	# 粒子飘落终点 x 范围（相对于生成位置）
	particleFallXRange = [-100, 100]
	# 粒子飘落重点 y 范围
	particleFallYRange = [area.height, area.height]
	# 粒子飘落曲线
	particleFallCurve = 'cubic-bezier(0,0,1,1)'
	# 粒子飘落平均速度范围
	particleFallSpeedRange = [160, 160]
	# 粒子透明度变化范围
	particleOpacityRange = [1, 1]
	# 粒子变化起始时间（相对飘落动画时长，0 为从头到尾，1 为没有动画）
	particleOpacityAnimationStartTime = 1
	
	imagePic = "images/laugh.png"
	
	down()

fallHitArea.on Events.Click, ->
	# 雪花
	# 粒子数量（以 375 屏幕宽度为基准）
	particleNum = 22
	# 粒子大小范围
	particleSizeRange = [30, 36]
	# 粒子 x 轴生成范围
	particleProductionXRange = [0, area.width]
	# 单粒子生成间隔
	particleProductionDelay = 0.2
	# 粒子飘落终点 x 范围（相对于生成位置）
	particleFallXRange = [-150, 150]
	# 粒子飘落重点 y 范围
	particleFallYRange = [360, 400]
	# 粒子飘落曲线
	particleFallCurve = 'cubic-bezier(0,0,1,1)'
	# 粒子飘落平均速度范围
	particleFallSpeedRange = [140, 160]
	# 粒子透明度变化范围
	particleOpacityRange = [1, 0]
	# 粒子变化起始时间（相对飘落动画时长，0 为从头到尾，1 为没有动画）
	particleOpacityAnimationStartTime = 0.6
	
	imagePic = "images/snow.png"
	
	down()


		
		