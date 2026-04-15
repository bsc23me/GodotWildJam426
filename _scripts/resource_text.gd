extends Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = "  Wood: %d\n  Stone: %d\nMoney: %d" % [ResourceManager.get_wood(), ResourceManager.get_stone(), ResourceManager.get_money()]
