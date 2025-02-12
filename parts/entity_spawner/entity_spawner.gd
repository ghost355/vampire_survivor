extends Node2D


@export var entity_scene: PackedScene

@onready var _positions: Node2D = $Positions

func spawn_entity():
	var random_position: Marker2D = _positions.get_children().pick_random()
	
	var new_entity: Node2D = entity_scene.instantiate()
	new_entity.position = random_position.positions
	add_child(new_entity)
