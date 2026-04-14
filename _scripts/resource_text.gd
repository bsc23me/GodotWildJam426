extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = "  Wood: %d\n  Stone: %d\nMoney: %d" % [ResourceManager.get_wood(), ResourceManager.get_stone(), ResourceManager.get_money()]
	pass
