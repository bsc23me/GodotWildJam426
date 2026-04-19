extends Node

enum ResourceType {DEFAULT, WOOD, STONE, MONEY, POTIONS}

var WOOD_AMOUNT: int
var STONE_AMOUNT: int
var MONEY_AMOUNT: int
var POTION_AMOUNTS: Dictionary[GameConstants.ItemType, int]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	WOOD_AMOUNT = 9999 if Constants.DEBUG_MODE else 3
	STONE_AMOUNT = 9999 if Constants.DEBUG_MODE else 3
	MONEY_AMOUNT = 9999 if Constants.DEBUG_MODE else 0
	for i in 8:
		POTION_AMOUNTS.set(i+9, 0)

func adjust_resource(type:ResourceType, amount: int):
	match type:
		ResourceType.WOOD:
			WOOD_AMOUNT += amount
		ResourceType.STONE:
			STONE_AMOUNT += amount
		ResourceType.MONEY:
			MONEY_AMOUNT += amount
			
func adjust_potions(type:int, amount:int):
	if POTION_AMOUNTS.has(type):
		POTION_AMOUNTS.set(type, POTION_AMOUNTS[type] + amount)
	else:
		POTION_AMOUNTS.set(type, amount)
	
func get_wood():
	return WOOD_AMOUNT

func get_stone():
	return STONE_AMOUNT

func get_money():
	return MONEY_AMOUNT
