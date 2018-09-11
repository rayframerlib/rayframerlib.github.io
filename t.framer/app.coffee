area.draggable.enabled = true
area.draggable.constraints = area.frame

area.on Events.DragStart, ->
	area.backgroundColor = "red"

area.on Events.DragEnd, ->
	area.backgroundColor = "#00AAFF"