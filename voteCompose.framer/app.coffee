Framer.Defaults.Animation =
	time: 0.5
	curve: Spring(damping: 1)

mainScreen.width = 375
mainScreen.height = 667
mainScreen.center()

AddNewSelection = () ->
	Selection = new Layer
		superLayer: SelectionArea
		x: 8
		y: SelectionArea.subLayers.length * 50
		width: 359
		height: 42
		backgroundColor: "transparent"
	
	SelectionText = new Layer
		superLayer: Selection
		width: 359
		height: 42
		borderWidth: 1
		borderRadius: 2
		borderColor: "#e9e9e9"
		backgroundColor: "white"
	
	Text = new TextLayer
		x: 10
		text: "选项"
		fontSize: 16
		color: "#939393"
		superLayer: SelectionText
	
	Text.centerY()
	
	SelectionText.states.long = 
		width: 359
	
	SelectionText.states.short = 
		width: 329
	
	IconArea = new Layer
		superLayer: Selection
		x: 337
		y: 10
		size: 22
		backgroundColor: "transparent"
	
	IconArea.states.vanish = 
		opacity: 0
	
	IconArea.states.show = 
		opacity: 1
	
	SubsIcon = new Layer
		superLayer: IconArea
		size: 22
		image: "images/grayd.png"
	
	SubsIcon.states.rota = 
		rotation: -45
	
	SubsIcon.states.normal = 
		rotation: 0
	
	DelIcon = new Layer
		superLayer: IconArea
		size: 22
		image: "images/redd.png"
		rotation: 45
	
	DelIcon.states.rota = 
		rotation: 0
		opacity: 1
	
	DelIcon.states.normal = 
		rotation: 45
		opacity: 0
	
	SelectionArea.height = SelectionArea.subLayers.length * 50
	AddSelection.y = SelectionArea.height
	FunctionArea.height = SelectionArea.height + 50
	
	IconArea.stateSwitch("vanish")
	SubsIcon.stateSwitch("normal")
	DelIcon.stateSwitch("normal")
	
	DeleteSelection = () ->	
		Selection.animate
			x: -359
			
		Selection.on Events.AnimationEnd, -> 
			Selection.destroy()
			SelectionArea.height = SelectionArea.subLayers.length * 50
			FunctionArea.height = SelectionArea.height + 50
			AddSelection.animate
				y: SelectionArea.height
			CheckLength()
			Reorder()
			
	
	ShowDeleteIcon = () ->
		for selection in SelectionArea.subLayers
			selection.CancelDelete()
		SubsIcon.animate("rota")
		DelIcon.animate("rota")
		IconArea.off Events.Click
		IconArea.on Events.Click, -> DeleteSelection()
	
	Selection.setShort = () ->
		SelectionText.animate("short")
		IconArea.animate("show")
		IconArea.off Events.Click
		IconArea.on Events.Click, -> ShowDeleteIcon()
	
	Selection.setLong = () ->
		SelectionText.animate("long")
		IconArea.animate("vanish")
		IconArea.off Events.Click
	
	Selection.CancelDelete = () ->
		SubsIcon.animate("normal")
		DelIcon.animate("normal")
		IconArea.off Events.Click
		IconArea.on Events.Click, -> ShowDeleteIcon()

	CheckLength()
		
	return Selection

Reorder = () ->
	for index in [0...SelectionArea.subLayers.length]
		SelectionArea.subLayers[index].animate
			y: 50 * index

CheckLength = () ->
	if SelectionArea.subLayers.length > 2
		for selection in SelectionArea.subLayers
			selection.setShort()
	else
		for selection in SelectionArea.subLayers
			selection.setLong()
		
AddSelection.on Events.Click, ->
	AddNewSelection()

bg.on Events.Click, ->
	for selection in SelectionArea.subLayers
		selection.CancelDelete()

AddNewSelection()
AddNewSelection()