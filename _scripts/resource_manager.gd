extends Node

enum ResourceType {DEFAULT, WOOD, STONE, MONEY}

var WOOD_AMOUNT: int
var STONE_AMOUNT: int
var MONEY_AMOUNT: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	WOOD_AMOUNT = 0
	STONE_AMOUNT = 0
	MONEY_AMOUNT = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#adjust_money(1)
	pass

func adjust_resource(type:int, amount: int):
	match type:
		1:
			WOOD_AMOUNT += amount
		2:
			STONE_AMOUNT += amount
		3:
			MONEY_AMOUNT += amount

func adjust_wood(amount: int):
	WOOD_AMOUNT += amount

func adjust_stone(amount: int):
	STONE_AMOUNT += amount

func adjust_money(amount: int):
	MONEY_AMOUNT += amount
	
func get_wood():
	return WOOD_AMOUNT

func get_stone():
	return STONE_AMOUNT

func get_money():
	return MONEY_AMOUNT
