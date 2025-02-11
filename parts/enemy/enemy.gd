class_name Enemy extends CharacterBody2D

var player: Player

@export var max_speed: float = 350.0
@export var acceleration: float = 1500.0
@export var deceleration: float = 1500.0

@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D

func _ready():
    var player_nodes: Array = get_tree().get_nodes_in_group("player")
    if not player_nodes.is_empty():
        player = player_nodes[0]

func _physics_process(delta: float) -> void:
    navigation_agent_2d.target_position = player.global_position
    
    if navigation_agent_2d.is_navigation_finished():
        velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)
    else:
        var next_position: Vector2 = navigation_agent_2d.get_next_path_position()
        var direction_to_next_position: Vector2 = global_position.direction_to(next_position)
        velocity = velocity.move_toward(direction_to_next_position * max_speed, acceleration * delta)
        
        move_and_slide()
