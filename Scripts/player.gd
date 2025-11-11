extends CharacterBody2D

const SPEED = 100.0
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var move_dir: Vector2 = Vector2.ZERO
var facing: String = "down"

func _physics_process(delta: float) -> void:
	move_dir = Vector2.ZERO

	# Strict 4-direction movement (no diagonals)
	if Input.is_action_pressed("right"):
		move_dir.x = 1
		facing = "right"
	elif Input.is_action_pressed("left"):
		move_dir.x = -1
		facing = "left"
	elif Input.is_action_pressed("down"):
		move_dir.y = 1
		facing = "down"
	elif Input.is_action_pressed("up"):
		move_dir.y = -1
		facing = "up"

	velocity = move_dir * SPEED
	move_and_slide()

	_update_animation()


func _update_animation() -> void:
	# Walking
	if move_dir != Vector2.ZERO:
		match facing:
			"down":
				sprite.play("WalkDown")
				sprite.flip_h = false
			"up":
				sprite.play("WalkUp")
				sprite.flip_h = false
			"left":
				sprite.play("WalkLeft")
				sprite.flip_h = false
			"right":
				sprite.play("WalkLeft")
				sprite.flip_h = true
	else:
		# Standing: single-frame stand animation
		sprite.play("Stand")
		sprite.flip_h = facing == "right"
		match facing:
			"down":
				sprite.frame = 0
			"up":
				sprite.frame = 1
			"left", "right":
				sprite.frame = 2
