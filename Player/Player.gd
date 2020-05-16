extends KinematicBody2D


const MAX_SPEED = 500
const ACCELERATION = 1300
const FRICTION = 800
var velocity = Vector2.ZERO
var input_vector
var Enemy

func _ready():
	Enemy = get_node_or_null("../Enemy")
	if Enemy != null:
		Enemy.connect("hit_player", self, "been_hit")

func _physics_process(delta):
	input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	direction()
	input_vector = input_vector.normalized()
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	velocity = move_and_slide(velocity)

func been_hit():
	$AnimationPlayer.play("Hurt")

func direction():
	match input_vector:
		Vector2(-1,0), Vector2(-1,1), Vector2(-1,-1):
			$Sprite.animation = "Left"
			$Sprite.playing = true
			$Gun.z_index = -1
		Vector2(1,0), Vector2(1,-1), Vector2(1,1):
			$Sprite.animation = "Right"
			$Sprite.playing = true
			$Gun.z_index = 0
		Vector2(0,-1):
			$Sprite.animation = "Up"
			$Sprite.playing = true
			$Gun.z_index = -1
		Vector2(0,1):
			$Sprite.animation = "Down"
			$Sprite.playing = true
			$Gun.z_index = 0
		Vector2(0,0):
			$Sprite.playing = false
			$Sprite.frame = 1	
