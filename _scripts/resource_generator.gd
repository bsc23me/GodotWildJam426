extends Node

@export var type: ResourceManager.ResourceType
@export var delay: float
@export var amount: int

var timeout

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timeout = delay


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timeout -= delta
	if timeout <= 0:
		timeout = delay
		ResourceManager.adjust_resource(type, 1)
