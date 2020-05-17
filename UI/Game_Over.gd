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




func game_over():
	print('hello')
	visible = not visible
	get_tree().paused = not get_tree().paused


func _on_TextureButton_pressed():
	print('hello')


func _on_TextureButton2_pressed():
	print('hello')
	get_tree().quit()
