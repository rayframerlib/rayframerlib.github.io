Framer.Extras.Hints.disable()

mainScreen.width = 375
mainScreen.height = 812

mainScreen.clip = true
mainScreen.centerY()
mainScreen.centerX()

# 视频们 VIDEO_LIST
VIDEO_LIST = [
	{
		type: '合集'
		videos: [
			{
				video:''
				coverImg:''
				title:''
			},
			{
				video:''
				coverImg:''
				title:''
			},
			{
				video:''
				coverImg:''
				title:''
			},
			{
				video:''
				coverImg:''
				title:''
			},
			{
				video:''
				coverImg:''
				title:''
			},
			{
				video:''
				coverImg:''
				title:''
			},
			{
				video:''
				coverImg:''
				title:''
			},
			{
				video:''
				coverImg:''
				title:''
			},
		]
	},
	{
		type: '旅行'
		videos: [
			{
				video:''
				coverImg:''
				title:''
			},
			{
				video:''
				coverImg:''
				title:''
			},
			{
				video:''
				coverImg:''
				title:''
			},
			{
				video:''
				coverImg:''
				title:''
			},
		]
	},
	{
		type: '二次元'
		videos: [
			{
				video:''
				coverImg:''
				title:''
			},
			{
				video:''
				coverImg:''
				title:''
			},
			{
				video:''
				coverImg:''
				title:''
			},
			{
				video:''
				coverImg:''
				title:''
			},
		]
	},
	{
		type: '哈哈哈哈'
		videos: [
			{
				video:''
				coverImg:''
				title:''
			},
			{
				video:''
				coverImg:''
				title:''
			},
			{
				video:''
				coverImg:''
				title:''
			},
			{
				video:''
				coverImg:''
				title:''
			},
		]
	}
]

class VideoListUnit extends Layer
	constructor: (@options={}) ->
		@options.width ?= 54
		@options.height ?= 72
		@options.image ?= ''
		@options.title ?= ''
		@options.borderRadius ?= 4
		@options.borderWidth ?= 2
		@options.borderColor ?= 'rgba(255, 255, 255, 0)'
		@options.listLayer ?= null
		
		super @options
		
		_self = @
		
		_self.on Events.Click, ->
			@selected()
	
	selected: () ->
		_self = @
		_self.options.listLayer.cleanSelected()
		(_self.animate
			scale: 0.9
			options:
				time: 0.1
				curve: 'ease-in-out').on Events.AnimationEnd, ->
					_self.animate
						scale: 1
						borderColor: 'rgba(255, 255, 255, 1)'
						options:
							time: 0.1
							curve: 'ease-in-out'
			
	unSelected: () ->
		@animate
			borderColor: 'rgba(255, 255, 255, 0)'
			options:
				time: 0.1
				curve: 'ease-in-out'

class VideoListGroup extends Layer
	constructor: (@options={}) ->
		@options.width ?= 54
		@options.height ?= 0
		@options.backgroundColor ?= ''
		@options.group ?= ''
		@options.listGap ?= 6
		@options.unitHeight ?= 72
		@options.listLayer ?= null
		@options.virtualList ?= []
		
		super @options
		
		_self = @
		
		#业务标题
		@titleUnit = new Layer
			superLayer: _self
			width: _self.width
			height: 36
			z: 1000
			backgroundColor: '#161616'
		
		_titleUnit = @titleUnit
		
		#业务标题文字
		titleButton = new Layer
			superLayer: _titleUnit
			height: _titleUnit.height - 2 * _self.options.listGap
			width: _self.width
			borderRadius: 4
			backgroundColor: 'rgba(255, 255, 255, 0.06)'
		
		titleButton.center()
		
		text = new TextLayer
			x: 4
			superLayer: titleButton
			fontSize: 10
			fontWeight: 500
			text: _self.options.group.type
		
		text.centerY()
			
		for i in [0..._self.options.group.videos.length]
			unit = new VideoListUnit
				superLayer: _self 
				width: _self.options.width
				y: _titleUnit.height + i *  (_self.options.listGap + _self.options.unitHeight)
				listLayer: _self.options.listLayer
			_self.height = _titleUnit.height + (_self.options.listGap + _self.options.unitHeight) * (i + 1) - _self.options.listGap
			_self.options.virtualList.push(unit)
		
		_titleUnit.on Events.Click, ->
			_self.options.listLayer.jumpToGroup(_self)

class VideoList extends Layer
	constructor: (@options={}) ->
		@options.width ?= 54
		@options.height ?= 0
		@options.image ?= ''
		@options.title ?= ''
		@options.list ?= ''
		@options.listGap ?= 6
		@options.unitHeight ?= 72
		@options.clip ?= true
		@options.backgroundColor ?= 'transparent'
		
		super @options
		
		_self = @
		
		@virtualList = []
		_virtualList = @virtualList
		
		@listContent = new Layer
			superLayer: _self
			height: 0
			width: _self.options.width
			backgroundColor: 'transparent'
		
		_listContent = @listContent
		
		for i in [0..._self.options.list.length]
			offsetY = 0
			
			if _listContent.subLayers.length
				latestGroup = _listContent.subLayers[_listContent.subLayers.length - 1]
				offsetY = latestGroup.y + latestGroup.height
			
			group = new VideoListGroup
				superLayer: _listContent
				y: offsetY
				width: _self.options.width
				group: _self.options.list[i]
				listGap: _self.options.listGap
				unitHeight: _self.options.unitHeight
				listLayer: _self
				virtualList: _virtualList
				
			_listContent.height += group.height
		
		_listContent.draggable.enabled = true
		_listContent.draggable.speedX = 0
		_listContent.draggable.constraints = {
			x: 0
			y: _self.height - _listContent.height
			width: _self.options.width
			height: _listContent.height * 2 - _self.height 
		}
		
		_listContent.on 'change:y', ->
			for i in [0..._listContent.subLayers.length]
				if _listContent.subLayers[i].y + _listContent.y >= _self.height - _listContent.subLayers[i].subLayers[0].height * (_listContent.subLayers.length - i)
					_listContent.subLayers[i].subLayers[0].y = -(_listContent.subLayers[i].y + _listContent.y - _self.height) - _listContent.subLayers[i].subLayers[0].height * (_listContent.subLayers.length - i)
				else if _listContent.subLayers[i].y + _listContent.y <= 0 + i * _listContent.subLayers[i].subLayers[0].height
					_listContent.subLayers[i].subLayers[0].y = -_listContent.subLayers[i].y - _listContent.y + i * _listContent.subLayers[i].subLayers[0].height
				else
					_listContent.subLayers[i].subLayers[0].y = 0
		
	jumpToGroup: (group) -> 
		index = @listContent.subLayers.indexOf(group)
		titleHeight = @listContent.subLayers[0].subLayers[0].height
		spareHeight = 0
		for i in [index... @listContent.subLayers.length]
			spareHeight += @listContent.subLayers[i].height
		if spareHeight > @height
			@listContent.animate
				y: index * titleHeight - group.y 
				options:
					time: 0.45
					curve: Spring(damping: 1)
		else
			@listContent.animate
				y: @height - @listContent.height
				options:
					time: 0.45
					curve: Spring(damping: 1)
	
	cleanSelected: (unit) ->
		_virtualList = @virtualList
		for i in [0... _virtualList.length]
			if _virtualList[i] != unit
				_virtualList[i].unSelected()
		

List = new VideoList
	superLayer: listContainer
	x: 0
	y: 0
	list: VIDEO_LIST
	listGap: 4
	width: 60
	height: 586