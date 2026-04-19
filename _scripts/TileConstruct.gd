extends Sprite2D

class_name TileConstruct

enum TileType {DEFAULT, BELT, PIPE, PLANTER, SIPHON, DRILL, WOOD_CUTTER, PLANT_PROCESSOR, BREWERY}

var scene_root: Node2D
var construct_type: TileType
var output_direction: Vector2
