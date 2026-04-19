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
	var t = 0
	for i in Constants.UPGRADES.keys():
		price_labels[t].text = price_msgs[t]+"\n%9d%11d" % [prices[Constants.UPGRADES[i] - 1],prices[Constants.UPGRADES[i] - 1]]
		t += 1
	price_labels[0].text = price_msgs[0]+"\n%9d" % prices[Constants.UPGRADES[TileConstruct.TileType.BELT] - 1]
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
	var p = prices[Constants.UPGRADES[type]-1]
	match type:
		TileConstruct.TileType.BELT:
			sell_potions(p,
				[Constants.ItemType.SPEED_POTION])
		TileConstruct.TileType.PLANTER:
			sell_potions(p,
				[Constants.ItemType.SPEED_POTION,
				Constants.ItemType.LOVE_POTION])
		TileConstruct.TileType.PLANT_PROCESSOR:
			sell_potions(p,
				[Constants.ItemType.SPEED_POTION,
				Constants.ItemType.EXPLOSIVE_POTION])
		
	Constants.UPGRADES.set(type,Constants.UPGRADES[type] + 1)
	pass # Replace with function body.

func sell_potions(amount: int, potions: Array[Constants.ItemType]):
	var enough = true
	for i in potions.size():
		if !ResourceManager.has_potions(potions[i], amount):
			enough = false
	if enough:
		for i in potions.size():
			ResourceManager.adjust_potions(potions[i],-amount)
