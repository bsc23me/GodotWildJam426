extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var grid_position = GridManager.grid_position(get_parent().position)
	
	#print(grid_position)
	if GridManager.has_tile(grid_position):
		var tile = GridManager.get_tile(grid_position)
		var test_move = get_parent().test_move(get_parent().transform,tile.output_direction,null,0.08,false)
		if tile.construct_type == 1 and !test_move:
			get_parent().move_and_collide(tile.output_direction)
		if tile.construct_type == 7:
			get_parent().queue_free()
		pass
