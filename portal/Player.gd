class_name Player
extends KinematicBody

export (float) var SPEED = 3.0

var movement_direction = Vector3()

onready var camera = $Camera
onready var scope = $Scope


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event):
	if event is InputEventMouseMotion:
		rotate_camera(event.relative)
	update_movement_direction()


func _physics_process(_delta):
	if movement_direction:
		move_and_slide(movement_direction * SPEED, Vector3(0, 1, 0))
	# Make sure that collisions didn't accidentally move the Player up or down 
	translation.y = 0


func rotate_camera(relative_movement):
	var mouse_sensitivity = 0.3
	# Rotate horizontally
	camera.rotate_y(deg2rad(relative_movement.x * mouse_sensitivity * -1))
	# Rotate vertically
	var angle = -relative_movement.y * mouse_sensitivity
	var camera_rot = camera.rotation_degrees
	camera_rot.x += angle
	camera_rot.x = clamp(camera_rot.x, -80, 80)
	camera.rotation_degrees = camera_rot


func update_movement_direction():
	# Reset movement direction
	movement_direction = Vector3()
	
	var input_movement_vector = Vector2()
	
	if Input.is_action_pressed("ui_up"):
		input_movement_vector.y += 1
	if Input.is_action_pressed("ui_down"):
		input_movement_vector.y -= 1
	if Input.is_action_pressed("ui_left"):
		input_movement_vector.x -= 1
	if Input.is_action_pressed("ui_right"):
		input_movement_vector.x = 1
	
	input_movement_vector = input_movement_vector.normalized()
	
	var camera_basis = camera.get_global_transform().basis
	movement_direction += -camera_basis.z.normalized() * input_movement_vector.y
	movement_direction += camera_basis.x.normalized() * input_movement_vector.x
	movement_direction.y = 0
	movement_direction = movement_direction.normalized()
