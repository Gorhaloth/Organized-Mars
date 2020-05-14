extends Position2D

var mouse_position


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var space_state = get_world_2d().direct_space_state
	mouse_position = get_local_mouse_position()
	rotation += mouse_position.angle()
	var degree = rad2deg($Degree.global_rotation)
	if degree < -90:
		$Degree/Sprite.flip_v=true
	elif degree > 90:
		$Degree/Sprite.flip_v=true
	else:
		$Degree/Sprite.flip_v=false
	if Input.is_action_just_pressed("fire") and $Degree/RayCast2D.is_colliding():	
#		var result = space_state.intersect_ray($Degree.global_position,$Degree.global_position + transform.x * 1000,[self])
#		print($Degree/RayCast2D.is_colliding())
#		print($Degree.global_position)
#		print(result)
		$Degree/Beam.set_point_position(0,$Degree.global_position)
		$Degree/Beam.set_point_position(1,$Degree/RayCast2D.get_collision_point())
		print($Degree/RayCast2D.get_collision_point())
	elif Input.is_action_pressed("fire") and $Degree/RayCast2D.is_colliding()==false:
		$Degree/Beam.visible = true
		var timer = $Degree/Timer.start()


func _on_Timer_timeout():
	$Degree/Beam.visible = true
