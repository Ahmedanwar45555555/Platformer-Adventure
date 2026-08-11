extends Area2D

@export var timer: Timer

func _on_body_entered(body):
	if body.has_method("take_damage") and get_parent() is AnimatedSprite2D:
		body.take_damage(1)
	else:
		print("You died")
		timer.start()

func _on_timer_timeout():
	get_tree().reload_current_scene()
