extends Camera2D

@export var camera_distance: float = 200
@export var position_interpolation_speed: float = 1.0

@onready var _player: CharacterBody2D = get_parent()


func _physics_process(delta: float) -> void:
    var move_direction: Vector2 = _player.velocity.normalized()
    var target_position: Vector2 = move_direction * camera_distance

    offset = offset.lerp(target_position, position_interpolation_speed * delta)

    if move_direction == Vector2.ZERO:
        var z = move_toward(zoom.x, 1, 0.1 * delta)
        zoom = Vector2(z, z)
    else:
        var z = move_toward(zoom.x, 0.8, 0.1 * delta)
        zoom = Vector2(z, z)
