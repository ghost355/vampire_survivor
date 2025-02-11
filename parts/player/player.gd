extends CharacterBody2D

const MAX_HEALTH: int = 10

@export var max_speed: float = 500.0
@export var acceleration: float = 2500.0
@export var deceleration: float = 1500.0

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
        health = clamp(new_value, 0, MAX_HEALTH)
        update_health_label()

@onready var _health_label: Label = $HealthLabel
@onready var _gold_label: Label = $GoldLabel


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
