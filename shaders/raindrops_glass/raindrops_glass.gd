extends Node3D


func _ready():
	%GlassWithVideo.material_override.set_shader_parameter(
		"raindrops_normal", %RainVideoStreamPlayer.get_video_texture()
	)


func _process(delta: float) -> void:
	%Pivot.rotation_degrees.y -= delta * 4.0;


func _on_distortion_size_value_changed(value: float) -> void:
	for glass in [%GlassWithVideo, %GlassWithParticles]:
		glass.material_override.set_shader_parameter(
			"distortion_size", value
		)
