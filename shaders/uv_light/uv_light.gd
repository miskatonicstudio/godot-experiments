extends Node3D


func _on_uv_light_position_value_changed(value: float) -> void:
	%UVLight.position.x = value


func _on_attenuation_value_changed(value: float) -> void:
	%UVLight.spot_attenuation = value


func _on_range_value_changed(value: float) -> void:
	%UVLight.spot_range = value


func _on_energy_value_changed(value: float) -> void:
	# Sets the shader material energy, not the light energy
	for hidden in [%HiddenObject, %HiddenMessage]:
		hidden.material_override.set_shader_parameter("energy", value)
