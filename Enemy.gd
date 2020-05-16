extends Node2D

var distance
var velocity = Vector2(0,0)
var Player 
var angle
var direction
var x
var y
var Gun

signal hit_player()


func _ready():
	Player = get_node_or_null("../Player")
	Gun = get_node_or_null("../Player/Gun")
	if Gun != null:
		Gun.connect("hit", self, "_on_hit")
	

func _physics_process(delta):
	if Player != null:
		if abs((Player.position - position).length()) > 2:
			velocity = (Player.position - position).normalized() * 1
			angle = velocity.angle()
			set_animation()
		else:
			velocity = Vector2(0,0)
		position += velocity
	#print(get_node("res://Player/Player.tscn"))

func _on_hit(body):
	if body == $Area2D:
		queue_free()

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
			$Sprite.animation = "Down"
		[true, false, false, false]:
			$Sprite.animation = "Down"



func _on_Area2D_body_entered(body):
	emit_signal("hit_player")
