extends KinematicBody2D


const MAX_SPEED = 500
const ACCELERATION = 1300
const FRICTION = 800
var velocity = Vector2.ZERO
var input_vector
var Enemy
var mouse_position
var health = 11
var power = 30
onready var timer = $Timer
var alive = true
var invincible = false

signal dead()

func _ready():
	pass

func _physics_process(delta):
	input_vector = Vector2.ZERO
	if alive:
		input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		direction()
	input_vector = input_vector.normalized()
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	velocity = move_and_slide(velocity)
	if Input.is_action_just_pressed("teleport") && power >= 8:
		teleport()

func direction():
	match input_vector:
		Vector2(-1,0), Vector2(-1,1), Vector2(-1,-1):
			$Sprite.animation = "Left"
			$Sprite.playing = true
			$Gun.z_index = 0
		Vector2(1,0), Vector2(1,-1), Vector2(1,1):
			$Sprite.animation = "Right"
			$Sprite.playing = true
			$Gun.z_index = 1
		Vector2(0,-1):
			$Sprite.animation = "Up"
			$Sprite.playing = true
			$Gun.z_index = 0
		Vector2(0,1):
			$Sprite.animation = "Down"
			$Sprite.playing = true
			$Gun.z_index = 1
		Vector2(0,0):
			$Sprite.playing = false
			$Sprite.frame = 1	

func hurt():
	health = clamp(health -1, 0 ,11)
	$HUD/HealthBar.frame = health
	$AnimationPlayer.play("Hurt")
	if health <= 0:
		$Sprite.animation = "Death"
		$Sprite.playing = true
		alive = false
		$Gun.queue_free()
		timer.stop()
	else:
		timer.start()

func _on_Area2D_area_entered(area):
	if area.is_in_group('Enemy') && !invincible:
		hurt()

func _on_Timer_timeout():
	hurt()

func _on_Area2D_area_exited(area):
	timer.stop()

func teleport():
	mouse_position = get_global_mouse_position()
	position = mouse_position
	power = clamp(power -8, 0, 30)
	$HUD/PowerBar.frame = power

func _on_Sprite_animation_finished():
	if $Sprite.animation == "Death":
		emit_signal("dead")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Hurt":
		invincible = false

func _on_Recharge_timeout():
	power = clamp(power +1, 0, 30)
	$HUD/PowerBar.frame = power
