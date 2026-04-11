extends Node

var tiles: Dictionary[Vector2i, Node] = {}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func add_tile(position: Vector2i, tile: Node):
	tiles.set(position, tile)

func remove_tile(position: Vector2i):
	var tile = tiles[position]
	tile.queue_free()
	tiles.erase(position)

func has_tile(position: Vector2i):
	return tiles.has(position)
