extends Sprite2D

var shop_open = false
@export var shop_window: Node
@export var price_labels: Array[Label]
@export var price_msgs: Array[String]

var prices = [25,100,500,2000]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_ESCAPE:
			shop_open = false
			shop_window.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for i in price_labels.size():
		price_labels[i].text = price_msgs[i] + ""
	pass

func toggle_shop_window():
	if shop_open:
		shop_window.hide()
		shop_open = false
	else:
		shop_window.show()
		shop_open = true

func _upgrade(type: int) -> void:
	# ADD PRICES 25, 100, 500, 2000
	match type:
		TileConstruct.TileType.PLANTER:
			if(ResourceManager.POTION_AMOUNTS[Constants.ItemType.SPEED_POTION] > prices[Constants.UPGRADES[type]-1]
			and ResourceManager.POTION_AMOUNTS[Constants.ItemType.LOVE_POTION] > prices[Constants.UPGRADES[type]-1]):
				Constants.UPGRADES.set(type,Constants.UPGRADES[type] + 1)
				ResourceManager.POTION_AMOUNTS.set(
					ResourceManager.POTION_AMOUNTS[Constants.ItemType.SPEED_POTION],
					ResourceManager.POTION_AMOUNTS[Constants.ItemType.SPEED_POTION] - prices[Constants.UPGRADES[type]-1])
				ResourceManager.POTION_AMOUNTS.set(
					ResourceManager.POTION_AMOUNTS[Constants.ItemType.LOVE_POTION],
					ResourceManager.POTION_AMOUNTS[Constants.ItemType.LOVE_POTION] - prices[Constants.UPGRADES[type]-1])
	pass # Replace with function body.
