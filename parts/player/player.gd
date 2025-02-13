class_name Player extends CharacterBody2D

signal died

const MAX_HEALTH: int = 10

@export var max_speed: float = 500.0
@export var acceleration: float = 2500.0
@export var deceleration: float = 1500.0

@export var _projectile_scene: PackedScene = preload("res://parts/projectile/projectile.tscn")
@export var shoot_distance: float = 400.0
@export var gold: int = 0:
    get:
        return gold
    set(value):
        gold = value
        update_gold_label()

@export_range(0, MAX_HEALTH) var health: int = 10:
    get:
        return health
    set(new_value):
        var new_health :int = clamp(new_value, 0, MAX_HEALTH)
        if health > 0 and new_health == 0:
            # it's better to extract code below to separate functions 
            died.emit()
            set_physics_process(false)
            _shoot_timer.stop()
        health = new_health
        update_health_label()

@onready var _health_label: Label = $HealthLabel
@onready var _gold_label: Label = $GoldLabel
@onready var _shoot_timer: Timer = $ShootTimer


func _ready() -> void:
    update_health_label()
    update_gold_label()


func _physics_process(delta: float) -> void:
    var input_direction: Vector2 = Input.get_vector(
        "move_left", "move_right", "move_up", "move_down"
    )

    if input_direction != Vector2.ZERO:
        velocity = velocity.move_toward(input_direction * max_speed, acceleration * delta)
    else:
        velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)
    move_and_slide()


func add_health_points(differense: int):
    health += differense


func update_health_label():
    if not is_instance_valid(_health_label):
        return
    _health_label.text = str(health) + "/" + str(MAX_HEALTH)

func update_gold_label():
    if not is_instance_valid(_gold_label):
        return
    _gold_label.text = str(gold) + "$"

func get_hit():
    health -= 1


func _on_shoot_timer_timeout() -> void:
    var closest_enemy: Enemy
    var smallest_distance: float = INF
    
    var all_enemies: Array = get_tree().get_nodes_in_group("enemy")
    
    for enemy in all_enemies:
        var distance_to_enemy: float = global_position.distance_to(enemy.global_position)
        if distance_to_enemy < smallest_distance:
            closest_enemy = enemy
            smallest_distance = distance_to_enemy
        if not closest_enemy:
            return
        if smallest_distance > shoot_distance:
            return
        var new_procjectile: Projectile = _projectile_scene.instantiate()
        new_procjectile.target = closest_enemy
        get_parent().add_child(new_procjectile)
        new_procjectile.global_position = global_position
        
        
        
        
