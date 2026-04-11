extends Node2D

var grid_scale = 128
@export var scene_root: Node2D
@export var tile_node: String
var tile_scene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tile_scene = load(tile_node)
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseMotion:
		position = snap(event.position, grid_scale)
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			var tile = tile_scene.instantiate()
			tile.position = position
			scene_root.add_child(tile)
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func snap(pos, gridScale):
	pos /= gridScale
	pos.x = floor(pos.x)
	pos.y = floor(pos.y)
	pos += Vector2(0.5,0.5)
	pos *= gridScale
	return pos
