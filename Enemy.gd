extends Node2D

var distance
var velocity = Vector2(0,0)
var Player 
var angle
var direction
var x
var y


func _ready():
	if get_parent().has_node("Player"):
		Player = get_node("../Player")

func _physics_process(delta):
	if get_parent().has_node("Player"):
		if abs((Player.position - position).length()) > 2:
			velocity = (Player.position - position).normalized() * 2
			angle = velocity.angle()
			set_animation()
		else:
			velocity = Vector2(0,0)
		position += velocity

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
			$Sprite.flip_v = true
		[true, false, false, false]:
			$Sprite.animation = "Down"
			$Sprite.flip_v = false
