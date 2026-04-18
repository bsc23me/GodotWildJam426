extends AudioStreamPlayer

func _ready() -> void:
	if randi_range(0,1) == 1:
		stream = load("res://audio/GodotWildJam1.2.mp3")
	else:
		stream = load("res://audio/GodotWildJam2.mp3")
	
	play()


func _on_finished() -> void:
	if randi_range(0,1) == 1:
		stream = load("res://audio/GodotWildJam1.2.mp3")
	else:
		stream = load("res://audio/GodotWildJam2.mp3")
	
	play()
