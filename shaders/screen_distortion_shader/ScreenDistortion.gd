extends Node3D


func _on_HSlider_value_changed(value):
	$Distortion.material.set_shader_parameter("BIAS", value)
