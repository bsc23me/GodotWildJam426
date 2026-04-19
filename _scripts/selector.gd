extends Node

@export var buttons : Array[Button]
@export var parent : Node2D
@export var products: Array[GameConstants.ItemType]

func _ready() -> void:
	for i in products.size():
		buttons[i].button_down.connect(set_plant.bind(products[i]))
	#buttons[0].button_down.connect(set_plant.bind(GameConstants.ItemType.ROSE_PLANT))
	#buttons[1].button_down.connect(set_plant.bind(GameConstants.ItemType.FIRE_PLANT))
	#buttons[2].button_down.connect(set_plant.bind(GameConstants.ItemType.POISON_PLANT))
	#buttons[3].button_down.connect(set_plant.bind(GameConstants.ItemType.MANA_PLANT))


func set_plant(id : GameConstants.ItemType) -> void:
	if !parent.one_to_one:
		parent.change_type(id)
	parent.tpe = id
	parent.start = true
	
	$"..".hide()
