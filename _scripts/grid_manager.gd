extends Node


var GRID_SCALE: int = 16
var GRID_SNAP_SPEED: float = 0.5

var tiles: Dictionary[Vector2i, TileConstruct] = {}

func add_tile(position: Vector2i, tile: TileConstruct):
	tiles.set(position, tile)

func remove_tile(position: Vector2i):
	var tile = tiles[position]
	tile.queue_free()
	tiles.erase(position)

func has_tile(position: Vector2i):
	return tiles.has(position)
	
func get_tile(position: Vector2i):
	return tiles[position]
	
## Returns a position which has been snapped to the nearest grid square
func grid_position(position: Vector2):
	position /= GRID_SCALE
	position = floor(position)
	position += Vector2(0.5,0.5)
	position *= GRID_SCALE
	return position
