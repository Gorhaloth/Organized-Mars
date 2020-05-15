extends KinematicBody2D

const MAX_SPEED = 500
const ACCELERATION = 1300
const FRICTION = 800
var velocity = Vector2.ZERO
var direction = {
	Vector2(0,1): "Down",
	Vector2(0,-1): "Up",
	Vector2(1,0): "Right",
	Vector2(1,-1): "Right",
	Vector2(1,1): "Right",
	Vector2(-1,0): "Left",
	Vector2(-1,1): "Left",
	Vector2(-1,-1):"Left"
}

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	if input_vector == Vector2(0,0):
		$Sprite.frame = 1
		$Sprite.playing = false
	else:
		$Sprite.animation = direction[input_vector]
		$Sprite.playing = true
	input_vector = input_vector.normalized()
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	velocity = move_and_slide(velocity)


func _on_Area2D_body_entered(body):
	$AnimationPlayer.play("Hurt3")
