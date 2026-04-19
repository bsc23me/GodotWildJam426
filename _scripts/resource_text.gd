extends Label

enum ResourceLabelType {DEFAULT, BASIC, POTIONS_1, POTIONS_2}

@export var label_type: ResourceLabelType

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match label_type:
		ResourceLabelType.BASIC:
			text = "Money: %d\nWood: %d\nStone: %d" % [ResourceManager.get_money(), ResourceManager.get_wood(), ResourceManager.get_stone()]
		ResourceLabelType.POTIONS_1:
			var t = ""
			t = t + ": " + str(ResourceManager.POTION_AMOUNTS[GameConstants.ItemType.HEALTH_POTION]) + "\n"
			t=t + ": " + str(ResourceManager.POTION_AMOUNTS[GameConstants.ItemType.FIRE_POTION]) + "\n"
			t=t + ": " + str(ResourceManager.POTION_AMOUNTS[GameConstants.ItemType.POISON_POTION]) + "\n"
			t=t + ": " + str(ResourceManager.POTION_AMOUNTS[GameConstants.ItemType.MANA_POTION])
			text = t
		ResourceLabelType.POTIONS_2:
			var t = ""
			t = t + ": " + str(ResourceManager.POTION_AMOUNTS[GameConstants.ItemType.LOVE_POTION]) + "\n"
			t = t + ": " + str(ResourceManager.POTION_AMOUNTS[GameConstants.ItemType.ANTIDOTE]) + "\n"
			t = t + ": " + str(ResourceManager.POTION_AMOUNTS[GameConstants.ItemType.SPEED_POTION]) + "\n"
			t = t + ": " + str(ResourceManager.POTION_AMOUNTS[GameConstants.ItemType.EXPLOSIVE_POTION])
			text = t
