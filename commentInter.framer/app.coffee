Framer.Extras.Hints.disable()

mainScreen.width = 414
mainScreen.height = 736

mainScreen.clip = true
mainScreen.centerY()
mainScreen.centerX()

if Screen.width < 414
	mainScreen.scale = Screen.width / 414
mainScreen.y = (Screen.height - mainScreen.height) / 2

Framer.Defaults.Animation =
	curve: Spring(damping: 1)
	time: 0.6

pop.clip = true

popScroll.draggable.enabled = true
popScroll.draggable.speedX = 0

contendConversationDown.states.extend1 = 
	y: contendConversationDown.y + 292

contendConversationDown.states.extend2 = 
	y: contendConversationDown.y + 374
	
extendBar.states.vanish = 
	opacity: 0
	options: 
		time: 0.3

freshPop.states.vanish =
	opacity: 0
	y: freshPop.y - 30
	options: 
		time: 0.3

freshPop.states.show =
	opacity: 1
	y: freshPop.y
	options: 
		time: 0.3

setPopScrollConstraints = () ->
	popScroll.draggable.constraints = 
		x: 0
		y: popScrollContainer.height - popScroll.height
		width: 414
		height: 2 * popScroll.height - popScrollContainer.height
		
init = () ->
	popScroll.height = contentHot.height + contentHot.y
	popScroll.y = 0
	setPopScrollConstraints()
	contendConversationExtend.visible = false
	contendConversationFresh.visible = false
	contentConversation.visible = false
	freshPop.visible = false
	freshPop.stateSwitch('vanish')
	extendBtn.visible = true
	extendBar.stateSwitch('default')
	freshPop.visible = false
	freshPop.stateSwitch('vanish')
	contendConversationDown.stateSwitch('default')
	btnHandler('hot')
	orderButtonImageHot.visible = true
	orderButtonImageConversation.visible = false
	orderButtonImageTime.visible = false
	pop.stateSwitch('vanishBottom')
	mask.stateSwitch('vanish')
	
#弹层逻辑

contendConversationFreshHighlighted.states.show = 
	opacity: 1
	options: 
		time: 0.3
contendConversationFreshHighlighted.states.vanish = 
	opacity: 0
	options: 
		time: 0.3
contendConversationFreshHighlighted.stateSwitch('vanish')

btnHandler = (btn) -> 
	loading.visible = false
	switch btn
		when 'hot'
			contentHot.visible = true
			contentTime.visible = false
			contentConversation.visible = false
			popScroll.height = contentHot.height + contentHot.y
			setPopScrollConstraints()
			
		when 'time'
			contentHot.visible = false
			contentTime.visible = true
			contentConversation.visible = false
			popScroll.height = contentTime.height + contentTime.y
			setPopScrollConstraints()
			
		when 'conversation'
			contentHot.visible = false
			contentTime.visible = false
			contentConversation.visible = true
			popScroll.height = contendConversationDown.y + contendConversationDown.height + 135
			setPopScrollConstraints()

contendConversationDown.on Events.AnimationEnd,->
	popScroll.height = contendConversationDown.y + contendConversationDown.height + 135
	setPopScrollConstraints()

extendBtn.on Events.MouseDown, ->
	extendBtnNormal.visible = false
	extendBtnHighlighted.visible = true
	
extendBtn.on Events.MouseUp, ->
	extendBtnNormal.visible = true
	extendBtnHighlighted.visible = false

extendBtn.on Events.Click, ->
	extendBtn.visible = false
	Utils.delay Utils.randomNumber(0.3, 0.8), ->
		extendBar.animate('vanish')
		contendConversationDown.animate('extend1')
		contendConversationExtend.visible = true
	Utils.delay Utils.randomNumber(2,3), ->
		freshPop.visible = true
		freshPop.animate('show')

ConversationExtend2 = () ->
	contendConversationDown.animate('extend2')
	contendConversationFresh.visible = true
	freshPop.animate('vanish').on Events.AnimationEnd, ->
		freshPop.visible = false
	popScroll.animate
		y: -480

freshPop.on Events.Click, ->
	ConversationExtend2()
	contendConversationFreshHighlighted.animate('show')
	Utils.delay 1, ->
		contendConversationFreshHighlighted.animate('vanish')

contentloading = (btn) ->
	contentHot.visible = false
	contentTime.visible = false
	contentConversation.visible = false
	loading.visible = true
	if btn != 'conversation' && freshPop.visible
		contendConversationDown.stateSwitch('extend2')
		contendConversationFresh.visible = true
		freshPop.animate('vanish').on Events.AnimationEnd, ->
			freshPop.visible = false
		
	Utils.delay Utils.randomNumber(0.3,0.7), ->
		btnHandler(btn)

btHot.on Events.Click, ->
	orderButtonImageHot.visible = true
	orderButtonImageConversation.visible = false
	orderButtonImageTime.visible = false
	contentloading('hot')
	
btConversation.on Events.Click, ->
	orderButtonImageConversation.visible = true
	orderButtonImageHot.visible = false
	orderButtonImageTime.visible = false
	contentloading('conversation')
	
btTime.on Events.Click, ->
	orderButtonImageHot.visible = false
	orderButtonImageConversation.visible = false
	orderButtonImageTime.visible = true
	contentloading('time')

popScrollContainer.states.fresh = 
	y: popScrollContainer.y + 60
	options: 
		time: 0.5

refreshing.visible = false

popScroll.on 'change:y', ->
	refreshBar.y = popScroll.y - 44
	if popScroll.y < 100
		d2f.visible = true
		r2f.visible = false
	else
		d2f.visible = false
		r2f.visible = true

popScroll.on Events.DragEnd, ->
	if @y >= 100
		refreshing.visible = true
		popScrollContainer.animate('fresh').on Events.AnimationEnd, ->
			Utils.delay Utils.randomNumber(1,2), ->
			popScrollContainer.animate('default').on Events.AnimationEnd, ->
				refreshing.visible = false
			


pop.states.show = pop.states.default
pop.stateSwitch('show')
pop.states.vanishBottom = 
	y: 736
	x: 0
pop.states.vanishRight = 
	x: 414
	y: 20
	
mask.states.show = 
	opacity: 1

mask.states.vanish = 
	opacity: 0

mask.stateSwitch('show')

topScrollHandler.draggable.enabled = true
topScrollHandler.draggable.constraints = topScrollHandler.frame
topScrollHandler.draggable.overdragScale = 1

topScrollHandler.on "change:y", ->
	if pop.states.current.name == 'show'
		pop.y = this.y

topScrollHandler.on Events.DragEnd, ->
	if this.y >= 200
		mask.animate('vanish')
		pop.animate('vanishBottom').on Events.AnimationEnd, ->
			topScrollHandler.visible = false
			leftScrollHandler.visible = false
			init()
			

leftScrollHandler.draggable.enabled = true
leftScrollHandler.draggable.constraints = leftScrollHandler.frame
leftScrollHandler.draggable.overdragScale = 1
leftScrollHandler.on "change:x", ->
	if pop.states.current.name == 'show'
		pop.x = this.x

leftScrollHandler.on Events.DragEnd, ->
	if this.x >= 414 / 3
		mask.animate('vanish')
		pop.animate('vanishRight').on Events.AnimationEnd, ->
			topScrollHandler.visible = false
			leftScrollHandler.visible = false
			pop.stateSwitch('vanishBottom')
			init()
			

popHeadCancelButton.on Events.Click, ->
	pop.animate('vanishBottom').on Events.AnimationEnd, ->
		init()
		topScrollHandler.visible = false
		leftScrollHandler.visible = false
		
	topScrollHandler.visible = false
	leftScrollHandler.visible = false
	mask.animate('vanish')

trigger.on Events.Click, ->
	pop.animate('show')
	topScrollHandler.visible = true
	leftScrollHandler.visible = true
	mask.animate('show')



init()
	