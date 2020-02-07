extends Camera

var current_detectable = null
onready var ray_cast = $RayCast

# TODO: allow movement of camera or scale the game when SIZE > 4
func _input(event):
	if event is InputEventMouseMotion:
		find_detectable()
	elif Input.is_action_just_pressed('select_puzzle_piece') and current_detectable:
		current_detectable.select()

func find_detectable():
		var ray = project_ray_normal(get_viewport().get_mouse_position())
		ray_cast.cast_to = ray * 10 # TODO: find a way to ignore distance or adjust to camera position
		
		var collider = null
		
		if ray_cast.is_colliding():
			collider = ray_cast.get_collider()
			if collider and collider != current_detectable:
				collider.highlight_on()
				if current_detectable:
					current_detectable.highlight_off()
				current_detectable = collider
		
		if not collider and current_detectable:
			current_detectable.highlight_off()
			current_detectable = null

#func set_enabled(enabled):
#	ray_cast.enabled = enabled
#	if enabled:
#		find_detectable()
#	else:
#		current_detectable = null