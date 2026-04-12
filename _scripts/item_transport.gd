extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var grid_position = GridManager.grid_position(get_parent().position)
	#print(grid_position)
	if GridManager.has_tile(grid_position):
		var tile = GridManager.get_tile(grid_position)
		if tile.construct_type == 1:
			get_parent().position += Vector2(1,0)
		pass
