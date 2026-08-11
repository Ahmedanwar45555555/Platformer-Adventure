extends Area2D

# ربط الـ GameManager
@onready var game_manager = %GameManager

# تعديل المسار لأن الـ AnimationPlayer موجود داخل PickupSound عندك
@onready var animation_player = $PickupSound/AnimationPlayer

func _on_body_entered(_body):
	game_manager.add_point()
	animation_player.play("Pickup")
