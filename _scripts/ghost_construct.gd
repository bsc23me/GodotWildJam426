extends Sprite2D

@export var scene_root: Node2D
@export var tile_node: Array[String]
@export var tile_texture: AtlasTexture
@export var default_texture: Texture
@export var tile_tex_offsets: Array[Vector2i]

var tile_scene
var scenes: Array[PackedScene]
var selected_tile_type: int

var left_held
var right_held
var can_place: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	can_place = true
	selected_tile_type = 0
	scenes.resize(tile_node.size())
	for i in tile_node.size():
		scenes[i] = load(tile_node[i])
	
	left_held = false
	right_held = false
	
	self_modulate = Color(1.0, 1.0, 1.0, 0.376)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		position = GridManager.grid_position(event.position)
		#position = snap(event.position, GridManager.GRID_SCALE)
		
#func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		# Place Construct
		if event.button_index == MOUSE_BUTTON_LEFT:
			left_held = event.pressed
			#place_tile(selected_tile_type)
			#print(position)
			
		# Pickup Construct
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			right_held = event.pressed
			
	if event is InputEventKey:
		if event.pressed:
			if event.keycode == KEY_R: # Rotation
				if event.shift_pressed:
					rotation -= PI / 2
				else:
					rotation += PI / 2
			if event.keycode >= KEY_1 and event.keycode <= KEY_8: # Tile Selection
				scale = Vector2(1,1)
				var tile = event.keycode - KEY_1
				var off = tile_tex_offsets[tile] * GridManager.GRID_SCALE
				tile_texture.region = Rect2(off.x,off.y,GridManager.GRID_SCALE,GridManager.GRID_SCALE)
				texture = tile_texture
				if tile == 0:
					texture = default_texture
					scale = Vector2(0.25,0.25)
				selected_tile_type = tile + 1
			#if event.keycode == KEY_2: # Temp Default Selection / DEPRECATED
				#scale = Vector2(0.125,0.125)
				#texture = default_texture
				#selected_tile_type = 0

# Called once per frame
func _process(delta: float) -> void:
	if left_held and !GridManager.has_tile(position):
		place_tile(selected_tile_type)
	if right_held:
		var pos = Vector2i(position)
		if GridManager.has_tile(pos):
			GridManager.remove_tile(pos)

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
	#if tile_type == 1 or tile_type == 2:
	tile.rotation = rotation
	tile.construct_type = tile_type
	tile.output_direction = dir_from_rot(rotation)
	tile.scene_root = scene_root
	scene_root.add_child(tile)
	GridManager.add_tile(tile.position, tile)
	
func dir_from_rot(rot):
	return Vector2i(round(cos(rot)), round(sin(rot)))


func _select_construct(extra_arg_0: int) -> void:
	scale = Vector2(1,1)
	var off = tile_tex_offsets[extra_arg_0] * GridManager.GRID_SCALE
	tile_texture.region = Rect2(off.x,off.y,GridManager.GRID_SCALE,GridManager.GRID_SCALE)
	texture = tile_texture
	selected_tile_type = extra_arg_0 + 1
