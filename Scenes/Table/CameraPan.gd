extends Camera2D


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if event.button_mask == BUTTON_MASK_RIGHT:
			position -= Vector2(event.relative.x, 0) * zoom
 
