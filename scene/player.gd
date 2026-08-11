extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -300.0

const DASH_SPEED = 500.0
const DASH_DURATION = 0.15
const DASH_COOLDOWN = 0.8

var is_dashing = false
var dash_timer = 0.0
var dash_cooldown_timer = 0.0

var original_scale = Vector2.ONE
var dash_stretch = Vector2(1.25, 0.85)

var jump_count = 0
const MAX_JUMPS = 2

var max_health = 3
var health = 3
var can_take_damage = true
const DAMAGE_COOLDOWN = 1.0

@onready var animated_sprite = $AnimatedSprite2D


func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:

	# --- DASH TIMERS ---
	if dash_timer > 0:
		dash_timer -= delta

	if dash_cooldown_timer > 0:
		dash_cooldown_timer -= delta


	# --- START DASH ---
	if Input.is_action_just_pressed("dash") and dash_cooldown_timer <= 0:
		start_dash()


	# --- DASHING ---
	if is_dashing:
		velocity.x = DASH_SPEED * (-1 if animated_sprite.flip_h else 1)
		velocity.y = 0

		animated_sprite.scale = dash_stretch
		animated_sprite.play("run")

		move_and_slide()

		if dash_timer <= 0:
			is_dashing = false
			dash_cooldown_timer = DASH_COOLDOWN
			animated_sprite.scale = original_scale

		return


	# --- GRAVITY ---
	if not is_on_floor():
		velocity += get_gravity() * delta


	# --- RESET JUMP COUNT ---
	if is_on_floor():
		jump_count = 0


	# --- DOUBLE JUMP ---
	if Input.is_action_just_pressed("ui_accept") and jump_count < MAX_JUMPS:
		velocity.y = JUMP_VELOCITY
		jump_count += 1


	# --- MOVEMENT ---
	var direction := Input.get_axis("ui_left", "ui_right")

	if direction != 0:
		velocity.x = direction * SPEED

		if direction > 0:
			animated_sprite.flip_h = false
		elif direction < 0:
			animated_sprite.flip_h = true

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)


	# --- ANIMATION ---
	if not is_on_floor():
		animated_sprite.play("jump")
	else:
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")


	move_and_slide()




func start_dash() -> void:
	is_dashing = true
	dash_timer = DASH_DURATION




func take_damage(amount: int) -> void:

	if not can_take_damage:
		return

	can_take_damage = false

	health -= amount

	print("Player Health:", health)

	if health <= 0:
		die()
	else:
		await get_tree().create_timer(DAMAGE_COOLDOWN).timeout
		can_take_damage = true


func die() -> void:
	get_tree().reload_current_scene()
