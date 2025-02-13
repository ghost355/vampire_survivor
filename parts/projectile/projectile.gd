class_name Projectile
extends Node2D

@export var speed: float = 600.0

var target: Node2D

func _physics_process(delta: float) -> void:
    if is_instance_valid(target):
        global_position = global_position.move_toward(target.global_position, speed * delta)
        look_at((target.global_position))


func _on_enemy_detection_area_body_entered(body: Node2D) -> void:
    body.get_hit()
    queue_free()


func _on_destroy_timer_timeout() -> void:
    if is_instance_valid(self):
        queue_free()
