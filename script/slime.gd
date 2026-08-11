extends Node2D


const speed = 60
var direction = 1

@onready  var  ray_cast_right = $RayCast2D
@onready  var  ray_cast_left = $RayCast2D2
@onready var animated_sprite = $AnimatedSprite2D
func _process(delta):
	
	if ray_cast_right.is_colliding():
		direction = -1 
		animated_sprite.flip_h= true
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
	position.x += speed * direction * delta


func _on_kill_zone_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	pass
