extends TileConstruct

class_name Crafter
## Path to the subscene/root node/prefab to spawn
@export var product_path: String
var product
## If the crafter does not produce a physical product that goes on a belt you can specify a resource instead like money
@export var resource_type: ResourceManager.ResourceType
@export var resource_amount: int

@export var one_to_one: bool

## The necessary ingredients for each craft. Currently all recipies require only one of each item to proceed.
@export var needed_ingredients: Array[GameConstants.ItemType]
## Current items in the building. Type -> Quantity
var ingredient_list: Dictionary[GameConstants.ItemType,int]
## How many items the building can hold before it is full
@export var max_items: int

## Crafting time for each product
@export var delay: float
var timeout

@export var start_at_command : bool
var start : bool

@export var squish : Button

var tpe : GameConstants.ItemType = GameConstants.ItemType.POISON_PLANT
var last_type : GameConstants.ItemType = GameConstants.ItemType.POISON_PLANT

@export var scaling : Vector2 = Vector2(1,1.1)
@export var duration : float = 0.1
var original_scale : Vector2

signal sound

func _ready() -> void:
	if product_path:
		product = load(product_path)
		
	timeout = 1.0 if Constants.DEBUG_MODE else delay
	
	for i in needed_ingredients.size():
		ingredient_list.set(needed_ingredients[i],0)



func _physics_process(delta: float) -> void:
	
	if start_at_command:
		if !start:
			return
	
	if has_ingredients():
		timeout -= delta
	
	if timeout <= 0:
		if product:
			# check if belt is full
			var space_state = get_world_2d().direct_space_state
			var ray = PhysicsRayQueryParameters2D.create(position, position + output_direction * 16)
			var hit = space_state.intersect_ray(ray)
			if hit.size() == 0:
				# spawn the product
				squish.entered()
				sound.emit()
				var p : Node2D = product.instantiate()
				p.position = position + output_direction * GridManager.GRID_SCALE
				p.find_child("ItemTransport").type = tpe
				scene_root.add_child(p)
				squish.exited()
				# reset progress
				timeout = 1.0 if Constants.DEBUG_MODE else delay
				timeout *= 1.0 / Constants.UPGRADES[construct_type]
				for i in needed_ingredients.size():
					ingredient_list.set(needed_ingredients[i],ingredient_list[needed_ingredients[i]] - 1)
		elif resource_type != ResourceManager.ResourceType.DEFAULT:
			if resource_type == ResourceManager.ResourceType.POTIONS:
				ResourceManager.adjust_potions(tpe, 1)
			else:
				ResourceManager.adjust_resource(resource_type, resource_amount)
			squish.entered()
			squish.exited()
			# reset progress
			timeout = 1.0 if Constants.DEBUG_MODE else delay
			for i in needed_ingredients.size():
				ingredient_list.set(needed_ingredients[i],ingredient_list[needed_ingredients[i]] - 1)
	
func has_ingredients() -> bool:
	if one_to_one:
		var n : int = 0
		
		for i in needed_ingredients.size():
			if ingredient_list[needed_ingredients[i]] <= 0:
				n += 1
				if n >= needed_ingredients.size():
					return false
		return true
	else:
		for i in needed_ingredients.size():
			if ingredient_list[needed_ingredients[i]] <= 0:
				return false
		return true
func add_ingredient(type: int) -> void:
	if one_to_one:
		if ingredient_list.has(type):
			
			if last_type != tpe:
				last_type = tpe
				for i in needed_ingredients.size():
					ingredient_list.set(needed_ingredients[i],0)
				ingredient_list.set(type,ingredient_list[type] + 1)
			
			ingredient_list.set(type,ingredient_list[type] + 1)
	else:
		if ingredient_list.has(type):
			ingredient_list.set(type,ingredient_list[type] + 1)

func needs_ingredient(type: int) -> bool:
	return needed_ingredients.has(type) and ingredient_list[type] < max_items
	
func change_type(type: int):
	tpe = type
	needed_ingredients.clear()
	ingredient_list.clear()
	match type:
		GameConstants.ItemType.HEALTH_POTION:
			needed_ingredients.append(GameConstants.ItemType.ROSE_POWDER)
		GameConstants.ItemType.FIRE_POTION:
			needed_ingredients.append(GameConstants.ItemType.FIRE_POWDER)
		GameConstants.ItemType.POISON_POTION:
			needed_ingredients.append(GameConstants.ItemType.POISON_POWDER)
		GameConstants.ItemType.MANA_POTION:
			needed_ingredients.append(GameConstants.ItemType.MANA_POWDER)
		GameConstants.ItemType.LOVE_POTION:
			needed_ingredients.append(GameConstants.ItemType.ROSE_POWDER)
			needed_ingredients.append(GameConstants.ItemType.FIRE_POWDER)
		GameConstants.ItemType.ANTIDOTE:
			needed_ingredients.append(GameConstants.ItemType.ROSE_POWDER)
			needed_ingredients.append(GameConstants.ItemType.POISON_POWDER)
		GameConstants.ItemType.SPEED_POTION:
			needed_ingredients.append(GameConstants.ItemType.MANA_POWDER)
			needed_ingredients.append(GameConstants.ItemType.FIRE_POWDER)
		GameConstants.ItemType.EXPLOSIVE_POTION:
			needed_ingredients.append(GameConstants.ItemType.MANA_POWDER)
			needed_ingredients.append(GameConstants.ItemType.POISON_POWDER)
	for i in needed_ingredients.size():
		ingredient_list.set(needed_ingredients[i],0)
