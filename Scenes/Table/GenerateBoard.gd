extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const TRACK = [0,0,6,0,0,0,0,0,0,2,2,2,4,4,4,0,0,0,0,2,2,4,4,4,2,2,0,0,8,0,0]
onready var tilemap = $Board


# Called when the node enters the scene tree for the first time.
func _ready():
	create_track(TRACK, tilemap)


func create_track(_track, _tilemap):
	for x in range(_track.size()):
		self.set_cell(x+1,5, _track[x])
		self.set_cell(x+1,6, _track[x]+1)
#		for y in range(_track[x].size()):


#func set_cell(x, y, tile, flip_x=false, flip_y=false, transpose=false, autotile_coord=Vector2()):
#	# Write your custom logic here.
#	# To call the default method:
#	self.set_cell(x, y, tile, flip_x, flip_y, transpose, autotile_coord)
