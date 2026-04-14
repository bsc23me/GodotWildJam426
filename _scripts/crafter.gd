extends TileConstruct

class_name Crafter

## Path to the subscene/root node/prefab to spawn
@export var product_path: String
var product
## If the crafter does not produce a physical product that goes on a belt you can specify a resource instead like money
@export var resource_type: ResourceManager.ResourceType
@export var resource_amount: int

## The necessary ingredients for each craft. Currently all recipies require only one of each item to proceed.
@export var needed_ingredients: Array[GameConstants.ItemType]
## Current items in the building. Type -> Quantity
var ingredient_list: Dictionary[GameConstants.ItemType,int]
## How many items the building can hold before it is full
@export var max_items: int

## Crafting time for each product
@export var delay: float
var timeout


func _ready() -> void:
	if product_path:
		product = load(product_path)
	timeout = delay
	for i in needed_ingredients.size():
		ingredient_list.set(needed_ingredients[i],0)



func _physics_process(delta: float) -> void:
	if has_ingredients():
		timeout -= delta
	if timeout <= 0:
		if product:
			var space_state = get_world_2d().direct_space_state
			var ray = PhysicsRayQueryParameters2D.create(position, position + output_direction * 16)
			var hit = space_state.intersect_ray(ray)
			if hit.size() == 0:
				var p = product.instantiate()
				p.position = position + output_direction * GridManager.GRID_SCALE
				scene_root.add_child(p)
				timeout = delay
				for i in needed_ingredients.size():
					ingredient_list.set(needed_ingredients[i],ingredient_list[needed_ingredients[i]] - 1)
		elif resource_type != ResourceManager.ResourceType.DEFAULT:
			ResourceManager.adjust_resource(resource_type, resource_amount)
			timeout = delay
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
