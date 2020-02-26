extends Spatial

onready var camera = $Viewport/Camera
onready var viewport = $Viewport
onready var screen = $Screen

onready var player_camera = $Player/Camera


func _ready():
	player_camera.get_node(
		"MeshInstance"
	).get_surface_material(0).set_shader_param(
		"tex", camera.get_viewport().get_texture()
	)


func _process(_delta):
	camera.global_transform = player_camera.global_transform
