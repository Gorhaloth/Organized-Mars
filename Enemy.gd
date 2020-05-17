extends KinematicBody2D

var distance
var velocity = Vector2(0,0)
var Player 
var angle
var direction
var x
var y
var Gun
var aggro = false
var health = 3

signal hit_player()


func _ready():
	Player = get_node_or_null("../Player")
	Gun = get_node_or_null("../Player/Gun")
	if Gun != null:
		Gun.connect("hit", self, "_on_hit")
	$Area2D.add_to_group('Enemy')
	

func _physics_process(delta):
	if Player != null && aggro:
		if abs((Player.position - position).length()) > 25:
			velocity = (Player.position - position).normalized() * 1
			angle = velocity.angle()
			set_animation()
		else:
			velocity = Vector2(0,0)
		move_and_collide(velocity)
	#print(get_node("res://Player/Player.tscn"))

func _on_hit(body):
	if body == $Area2D:
		health -= 1
		$AnimationPlayer.play("Hurt")
	if body == $Area2D && health <= 0:
		Player = null
		$Sprite.playing = false
		$Area2D.queue_free()
		$AnimationPlayer.play("Die")


func set_animation():
	x = cos(angle)
	y = sin(angle)
	direction = [
		abs(y) > abs(x) && y > 0,
		abs(y) > abs(x) && y < 0,
		abs(x) > abs(y) && x > 0,
		abs(x) > abs(y) && x < 0,
		]
	match direction:
		[false, false, false, true]:
			$Sprite.animation = "Side"
			$Sprite.flip_h = true
		[false, false, true, false]:
			$Sprite.animation = "Side"
			$Sprite.flip_h = false
		[false, true, false, false]:
			$Sprite.animation = "Up"
			$Sprite.flip_h = false
		[true, false, false, false]:
			$Sprite.animation = "Down"
			$Sprite.flip_h = false
	if abs((Player.position - position).length()) < 28:
		$Sprite.animation += "Attack"



func _on_Area2D_body_entered(body):
	emit_signal("hit_player")

func _on_DetectionArea_body_entered(body):
	if body == Player:
		aggro = true

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Die":
		queue_free()
