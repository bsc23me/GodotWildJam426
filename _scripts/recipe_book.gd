extends Sprite2D

@export var move_location: Vector2
var original_location
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	original_location = position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_panel_mouse_entered() -> void:
	var t: Tween = create_tween()
	t.tween_property(self, "position", move_location, 0.05).set_ease(Tween.EASE_OUT)
	#position = move_location


func _on_panel_mouse_exited() -> void:
	var t: Tween = create_tween()
	t.tween_property(self, "position", original_location, 0.05).set_ease(Tween.EASE_OUT)
