extends Node

enum ResourceType {DEFAULT, WOOD, STONE, MONEY}

var WOOD_AMOUNT: int
var STONE_AMOUNT: int
var MONEY_AMOUNT: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	WOOD_AMOUNT = 3
	STONE_AMOUNT = 3
	MONEY_AMOUNT = 0

func adjust_resource(type:ResourceType, amount: int):
	match type:
		ResourceType.WOOD:
			WOOD_AMOUNT += amount
		ResourceType.STONE:
			STONE_AMOUNT += amount
		ResourceType.MONEY:
			MONEY_AMOUNT += amount
	
func get_wood():
	return WOOD_AMOUNT

func get_stone():
	return STONE_AMOUNT

func get_money():
	return MONEY_AMOUNT
