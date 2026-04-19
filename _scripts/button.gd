extends Button

@export var node : Node
@export var scaling : Vector2 = Vector2(1,1.1)
@export var duration : float = 0.1

@export var to_show: Control
@export var audio : AudioStreamPlayer

@export_group("Building mode")
@export var consider : bool

var original_scale : Vector2

func _ready() -> void:
	mouse_entered.connect(entered.bind())
	mouse_exited.connect(exited.bind())
	
	if !node:
		node = self
	original_scale = node.scale
func entered() -> void:
	if consider:
		if GridManager.building_mode:
			return
	
	if audio:
		audio.play()
	
	var tween : Tween = create_tween()
	tween.tween_property(node, "scale", scaling, duration).set_trans(Tween.TRANS_CUBIC)
	
	if to_show:
		to_show.show()
func exited() -> void:
	if consider:
		if GridManager.building_mode:
			return

	var tween : Tween = create_tween()
	tween.tween_property(node, "scale", original_scale, duration).set_trans(Tween.TRANS_CUBIC)
	
	if to_show:
		to_show.hide()
