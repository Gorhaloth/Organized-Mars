extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Player


# Called when the node enters the scene tree for the first time.
func _ready():
	Player = get_node_or_null("../../Player")
	if Player != null:
		Player.connect("dead", self, "game_over")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func game_over():
	print('hello')
	visible = not visible
	get_tree().paused = not get_tree().paused


func _on_TextureButton_pressed():
	pass # Replace with function body.


func _on_TextureButton2_pressed():
	get_tree().quit()
