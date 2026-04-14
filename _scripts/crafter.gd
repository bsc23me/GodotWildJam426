extends TileConstruct

class_name Crafter

@export var product_path: String
var product

@export var needed_ingredients: Array[int]
var ingredient_list: Dictionary[int,int]
@export var max_items: int

@export var delay: float
var timeout

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if product_path:
		product = load(product_path)
	timeout = delay
	for i in needed_ingredients.size():
		ingredient_list.set(needed_ingredients[i],0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if has_ingredients():
		timeout -= delta
	if product and timeout <= 0:
		var space_state = get_world_2d().direct_space_state
		var ray = PhysicsRayQueryParameters2D.create(position, position + output_direction * 16)
		var hit = space_state.intersect_ray(ray)
		if hit.size() == 0:
			timeout = delay
			var p = product.instantiate()
			p.position = position + output_direction * GridManager.GRID_SCALE
			scene_root.add_child(p)
			for i in needed_ingredients.size():
				ingredient_list.set(needed_ingredients[i],ingredient_list[needed_ingredients[i]] - 1)
	
func has_ingredients() -> bool:
	for i in needed_ingredients.size():
		if ingredient_list[needed_ingredients[i]] <= 0:
			return false
	return true
	
func add_ingredient(type: int) -> void:
	if ingredient_list.has(type):
		ingredient_list.set(type,ingredient_list[type] + 1)
	else:
		ingredient_list.set(type,1)
	
func needs_ingredient(type: int) -> bool:
	return needed_ingredients.has(type) and ingredient_list[type] < max_items
