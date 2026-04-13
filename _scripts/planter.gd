extends TileConstruct

var rose_path = "res://sub_scenes/rose.tscn"
var rose_scene

var delay = 1
var timeout
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("loaded new planter")
	rose_scene = load(rose_path)
	timeout = 0.0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	timeout -= delta
	if timeout <= 0:
		var space_state = get_world_2d().direct_space_state
		var ray = PhysicsRayQueryParameters2D.create(position, position + output_direction * 16)
		var hit = space_state.intersect_ray(ray)
		if hit.size() == 0:
			timeout = delay
			var rose = rose_scene.instantiate()
			rose.position = position + output_direction * GridManager.GRID_SCALE
			scene_root.add_child(rose)
	pass
