extends Spatial

export var SENSITIVITY_X = 1.0
export var SENSITIVITY_Y = 1.0

var angle_x = 0.0
var angle_y = 0.0

var current_angle_vertical = 0

func _ready():
	pass
#	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event):
	if Input.is_action_pressed('rotate'):
		if event is InputEventMouseMotion:
			var angles = event.relative
			var angle_horizontal = deg2rad(angles.x * SENSITIVITY_X)

			var angle_vertical = current_angle_vertical + (angles.y * SENSITIVITY_Y)
			angle_vertical = clamp(angle_vertical, -80, 80)
			var delta_angle_vertical = deg2rad(angle_vertical - current_angle_vertical)
			current_angle_vertical = angle_vertical

			self.rotate_object_local(Vector3(0, 1, 0), angle_horizontal)
			self.rotate_x(delta_angle_vertical)
#
#			var rot_deg = self.rotation_degrees
#			rot_deg.x += angles.y * SENSITIVITY_X
#			rot_deg.x = clamp(rot_deg.x, -80, 80)
#			rot_deg.y += angles.x * SENSITIVITY_Y
#			self.rotation_degrees = rot_deg
#
#			angle_x += angles.y * SENSITIVITY_X
#			angle_x = clamp(rot_deg.x, -80, 80)
#			angle_y += angles.x * SENSITIVITY_Y
#			self.setrotatio

#func _rotate_camera_vertically(angle):
#	var camera_rot = camera.rotation_degrees
#	camera_rot.x += angle
#	camera_rot.x = clamp(camera_rot.x, -80, 80)
#	camera.rotation_degrees = camera_rot