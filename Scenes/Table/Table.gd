extends Node2D


onready var tilemap = $Board
onready var player = $Rider
onready var PlayerText = $Camera2D/LineEdit

signal rider_moved

# Called when the node enters the scene tree for the first time.
func _ready():
	player.global_position = Vector2(16,96) + tilemap.cell_size/2
	pass
#	player.global_position = tilemap.to_global(4,5) + tilemap.cell_size/2

func _process(delta):
	if Input.is_action_just_pressed("left_click"):
		var cell_coords = tilemap.world_to_map(tilemap.get_local_mouse_position())
		var cell_type_index = tilemap.get_cellv(cell_coords)
		if cell_type_index != -1:
			var cell_world_pos_local = tilemap.map_to_world(cell_coords)
			var cell_world_pos_global = tilemap.to_global(cell_world_pos_local)
			print(cell_coords)
			player.global_position = cell_world_pos_global + tilemap.cell_size/2
		else:
			pass
#			print("Not valid")


func _on_LineEdit_text_entered(new_text):
	move_player(int(PlayerText.text))
	PlayerText.clear()
	PlayerText.grab_focus()

func move_player(spaces):
	var cell_coords = tilemap.world_to_map(tilemap.get_local_mouse_position())
	var current_position = player.global_position
	player.position.x += (tilemap.cell_size * spaces)[0]
	emit_signal("rider_moved")
