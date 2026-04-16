extends Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = "Money: %d\nWood: %d\nStone: %d" % [ResourceManager.get_money(), ResourceManager.get_wood(), ResourceManager.get_stone()]
