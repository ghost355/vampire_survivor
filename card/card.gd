extends Node2D

@export var flip_time: float = 0.1
@export var rotate_angle: float = PI/2

@onready var front = $front
@onready var back = $back

func _unhandled_input(event: InputEvent) -> void:
    
    if event.is_action_pressed("flip"):
        flip_card()
    
    if event.is_action_pressed("rotate_cw"):
        rotate_card()
    if event.is_action_pressed("rotate_ccw"):
        rotate_card(-PI/2)
        

func flip_card():
    var factor = 1.15
    var tween = create_tween().set_ease(Tween.EASE_IN_OUT)
    tween.tween_property(self, "scale", scale * factor, flip_time/2)
    await tween.finished
    
    tween = create_tween().set_trans(Tween.TRANS_QUAD)
    tween.tween_property(self, "scale", Vector2(0, 1 * factor), flip_time)
    await tween.finished
    front.visible = !front.visible
    back.visible = !back.visible
    
    tween = create_tween().set_trans(Tween.TRANS_QUAD)
    tween.tween_property(self, "scale", Vector2(1 * factor, 1 * factor), flip_time)
    await tween.finished

    tween = create_tween().set_ease(Tween.EASE_OUT)
    tween.tween_property(self, "scale", scale / factor, flip_time/2)
    await tween.finished
    
    
func rotate_card(angle: float = PI/2):
    var new_rotation = round_to_nearest(rotation + angle, PI/2) 
    
    var tween = create_tween().set_ease(Tween.EASE_IN_OUT)
    tween.tween_property(self, "rotation", new_rotation, flip_time)
    
# Округляет значение до ближайшего кратного шага
func round_to_nearest(value: float, step: float) -> float:
    return step * round(value / step)
