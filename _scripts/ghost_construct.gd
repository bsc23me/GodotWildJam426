extends Sprite2D

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

func _input(event):
	if event is InputEventMouseMotion:
		position = GridManager.grid_position(event.position)
		
		#position = snap(event.position, GridManager.GRID_SCALE)
		
	if event is InputEventMouseButton:
		# Place Construct
		if event.button_index == MOUSE_BUTTON_LEFT and !GridManager.has_tile(position):
			place_tile(selected_tile_type)
			print(position)
		# Pickup Construct
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			var pos = Vector2i(position)
			if GridManager.has_tile(pos):
				GridManager.remove_tile(pos)
				
	if event is InputEventKey:
		if event.pressed:
			if event.keycode == KEY_R: # Rotation
				if event.shift_pressed:
					rotation -= PI / 2
				else:
					rotation += PI / 2
			if event.keycode == KEY_1: # Belt Selection
				scale = Vector2(1,1)
				texture = belt_texture
				selected_tile_type = 1
			if event.keycode == KEY_2: # Temp Default Selection
				scale = Vector2(0.5,0.5)
				texture = default_texture
				selected_tile_type = 0

# Snap to the grid
func snap(pos, gridScale):
	pos /= gridScale
	pos = floor(pos)
	pos += Vector2(0.5,0.5)
	pos *= gridScale
	return pos
	
# Place a construct based on the currently selected type
func place_tile(tile_type):
	var tile = scenes[tile_type].instantiate()
	tile.position = position
	tile.rotation = rotation
	tile.construct_type = tile_type
	scene_root.add_child(tile)
	GridManager.add_tile(tile.position, tile)
