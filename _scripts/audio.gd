extends AudioStreamPlayer

var parent : Node
@export var start_at : float = 0

func _ready() -> void:
	parent = get_parent()
	parent.sound.connect(play.bind(start_at))
