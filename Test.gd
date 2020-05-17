extends Node2D
var number = RandomNumberGenerator.new()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const enemy = preload("res://Enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	number.randomize()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	var new = enemy.instance()
	add_child(new)
	new.position.x = number.randi_range(0,425)
	new.position.y = number.randi_range(0,225)
