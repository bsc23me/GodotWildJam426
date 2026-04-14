extends Node2D

var p
@export var type: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	p = get_parent()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var grid_position = GridManager.grid_position(p.position)
	
	#print(grid_position)
	if GridManager.has_tile(grid_position):
		var tile = GridManager.get_tile(grid_position)
		if tile.construct_type == 1:
			var is_blocked = p.test_move(p.transform,tile.output_direction,null,0.08,false)
			if !is_blocked:
				var center = tile.position - p.position
				var amount = tile.output_direction.rotated(PI / 2).abs()
				p.move_and_collide(tile.output_direction + (center * amount * GridManager.GRID_SNAP_SPEED))
		#if tile.construct_type == 7:
		if tile is Crafter:
			if tile.needs_ingredient(type):
				tile.add_ingredient(type)
				p.queue_free()
		pass
