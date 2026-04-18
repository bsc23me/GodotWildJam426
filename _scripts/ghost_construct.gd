extends Sprite2D

@export var scene_root: Node2D
@export var tile_paths: Array[String]
@export var tile_texture: AtlasTexture
@export var default_texture: Texture
@export var tile_tex_offsets: Array[Vector2i]


var scenes: Array[PackedScene]
var selected_tile_type: TileConstruct.TileType
var tile_cost : PackedVector2Array = [
	Vector2(0,0),
	Vector2(4,2),
	Vector2(2,2),
	Vector2(4,4),
	Vector2(6,8),
	Vector2(0,3),
	Vector2(3,0),
	Vector2(4,4),
	Vector2(6,6),
]

var left_held: bool
var right_held: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#_select_construct(TileConstruct.TileType.BELT)
	_select_construct(TileConstruct.TileType.DRILL)
	
	scenes.resize(tile_paths.size())
	for i in tile_paths.size():
		scenes[i] = load(tile_paths[i])
	
	left_held = false
	right_held = false
	
	self_modulate = Color(1.0, 1.0, 1.0, 0.376)
	hide()

func _unhandled_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("building"):
		if !GridManager.building_mode:
			GridManager.building_mode = true
			show()
			return
		GridManager.building_mode = false
		hide()
	
	if !GridManager.building_mode:
		return
	
	if event is InputEventMouseMotion:
		position = GridManager.grid_position(event.position)
	
	if event is InputEventMouseButton:
		# Place Construct
		if event.button_index == MOUSE_BUTTON_LEFT:
			left_held = event.pressed
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
				var tile = event.keycode - KEY_1
				_select_construct(tile + 1)
				# probably unused
				if tile == 0:
					texture = default_texture
					scale = Vector2(0.25,0.25)

# Called once per frame
func _process(_delta: float) -> void:
	if left_held and !GridManager.has_tile(position):

		place_tile(selected_tile_type)
	if right_held:
		var pos = Vector2i(position)
		if GridManager.has_tile(pos):
			GridManager.remove_tile(pos)
			$AudioStreamPlayer.play()
	
## Place a construct based on the currently selected type
func place_tile(tile_type):
	if ResourceManager.WOOD_AMOUNT < tile_cost[selected_tile_type].x or ResourceManager.STONE_AMOUNT < tile_cost[selected_tile_type].y:
		return
	
	ResourceManager.WOOD_AMOUNT -= int(tile_cost[tile_type].x)
	ResourceManager.STONE_AMOUNT -= int(tile_cost[tile_type].y)
	
	var tile = scenes[tile_type].instantiate()
	tile.position = position
	tile.rotation = rotation
	tile.construct_type = tile_type
	tile.output_direction = dir_from_rot(rotation)
	tile.scene_root = scene_root
	scene_root.add_child(tile)
	GridManager.add_tile(tile.position, tile)

## Converts a rotation to a direction vector
func dir_from_rot(rot):
	return Vector2i(round(cos(rot)), round(sin(rot)))

## Change the ghost construct to tile
func _select_construct(tile: TileConstruct.TileType) -> void:
	GridManager.building_mode = true
	show()
	scale = Vector2(1,1)
	var off = tile_tex_offsets[tile] * GridManager.GRID_SCALE
	tile_texture.region = Rect2(off.x,off.y,GridManager.GRID_SCALE,GridManager.GRID_SCALE)
	texture = tile_texture
	selected_tile_type = tile 
