@tool
extends Node3D

@onready var video_player = $VideoStreamPlayer
@onready var glass_mesh = $GlassVideo


func _ready():
	glass_mesh.material_override.set_shader_parameter(
		"glass", video_player.get_video_texture()
	)
	video_player.play()


func _on_video_stream_player_finished():
	video_player.play()
