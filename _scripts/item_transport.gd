extends Node2D

@export var type: GameConstants.ItemType
@export var sprite : Sprite2D

var p : Node2D


func _ready() -> void:
	p = get_parent()
	set_type()


func _physics_process(_delta: float) -> void:
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
				tile.tpe = transfer_type()
				p.queue_free()

func transfer_type() -> GameConstants.ItemType:
	match type:
		GameConstants.ItemType.ROSE_PLANT:
			return GameConstants.ItemType.ROSE_POWDER
		GameConstants.ItemType.FIRE_PLANT:
			return GameConstants.ItemType.FIRE_POWDER
		GameConstants.ItemType.POISON_PLANT:
			return GameConstants.ItemType.POISON_POWDER
		GameConstants.ItemType.MANA_PLANT:
			return GameConstants.ItemType.MANA_POWDER
	return GameConstants.ItemType.ROSE_POWDER

func set_type() -> void:
	match type:
		GameConstants.ItemType.ROSE_PLANT:
			sprite.frame = 1
		GameConstants.ItemType.FIRE_PLANT:
			sprite.frame = 7
		GameConstants.ItemType.POISON_PLANT:
			sprite.frame = 13
		GameConstants.ItemType.MANA_PLANT:
			sprite.frame = 19
		GameConstants.ItemType.ROSE_POWDER:
			sprite.frame = 2
		GameConstants.ItemType.FIRE_POWDER:
			sprite.frame = 8
		GameConstants.ItemType.POISON_POWDER:
			sprite.frame = 14
		GameConstants.ItemType.MANA_POWDER:
			sprite.frame = 20
