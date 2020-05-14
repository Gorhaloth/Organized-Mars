extends Position2D

var mouse_position


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	var space_state = get_world_2d().direct_space_state
	mouse_position = get_local_mouse_position()
	rotation += mouse_position.angle()
	var degree = rad2deg($Degree.global_rotation)
	if degree < -90:
		$Degree/Sprite.flip_v=true
	elif degree > 90:
		$Degree/Sprite.flip_v=true
	else:
		$Degree/Sprite.flip_v=false
	if Input.is_action_just_pressed("fire") and $Degree/RayCast2D.is_colliding() == true:	
		var distance = $Degree.get_global_position().distance_to($Degree/RayCast2D.get_collision_point())
		print(distance)
		$Degree/Beam.visible = true
		$Degree/Beam.add_point(Vector2(distance,0),0)
		$Degree/Beam.add_point(Vector2(0,0),1)
		var timer = $Degree/Timer.start()
#	elif Input.is_action_pressed("fire") and $Degree/RayCast2D.is_colliding()==false:
#		$Degree/Sprite/Beam.visible = true
#		var timer = $Degree/Timer.start()


func _on_Timer_timeout():
	$Degree/Beam.visible = false
	$Degree/Beam.clear_points()
