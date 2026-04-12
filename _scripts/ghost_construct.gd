extends Sprite2D

@export var grid_scale = 128
@export var scene_root: Node2D
@export var tile_node: Array[String]
@export var belt_texture: Texture
@export var default_texture: Texture

var tile_scene
var scenes: Array[PackedScene]
var selected_tile_type: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	selected_tile_type = 0
	scenes.resize(tile_node.size())
	for i in tile_node.size():
		scenes[i] = load(tile_node[i])
	self_modulate = Color(1.0, 1.0, 1.0, 0.376)
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseMotion:
		position = snap(event.position, grid_scale)
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and !GridManager.has_tile(position):
			place_tile(selected_tile_type)
			
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			var pos = Vector2i(position)
			if GridManager.has_tile(pos):
				GridManager.remove_tile(pos)
	if event is InputEventKey:
		if event.pressed:
			if event.keycode == KEY_R:
				if event.shift_pressed:
					rotation -= PI / 2
				else:
					rotation += PI / 2
			if event.keycode == KEY_1:
				scale *= 2
				texture = belt_texture
				selected_tile_type = 1
			if event.keycode == KEY_2:
				scale *= 0.5
				texture = default_texture
				selected_tile_type = 0
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
	
func place_tile(tile_type):
	var tile = scenes[tile_type].instantiate()
	tile.position = position
	tile.rotation = rotation
	scene_root.add_child(tile)
	GridManager.add_tile(tile.position, tile)
