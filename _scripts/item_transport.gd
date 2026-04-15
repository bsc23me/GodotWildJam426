extends Node2D

var p
@export var type: GameConstants.ItemType

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	p = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var grid_position = GridManager.grid_position(p.position)
	
	if GridManager.has_tile(grid_position):
		var tile = GridManager.get_tile(grid_position)
		# Move items on belts
		if tile.construct_type == TileConstruct.TileType.BELT:
			var is_blocked = p.test_move(p.transform,tile.output_direction,null,0.08,false)
			if !is_blocked:
				var center = tile.position - p.position
				var amount = tile.output_direction.rotated(PI / 2).abs()
				p.move_and_collide(tile.output_direction + (center * amount * GridManager.GRID_SNAP_SPEED))
		# Destroy items on crafter collection
		if tile is Crafter:
			if tile.needs_ingredient(type):
				tile.add_ingredient(type)
				p.queue_free()
