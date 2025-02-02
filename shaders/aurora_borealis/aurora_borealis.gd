extends Node3D


func _process(delta: float) -> void:
	%Pivot.rotation_degrees.y += delta * 4


func set_param(value, param_name):
	%Aurora.material_override.set_shader_parameter(param_name, value)


func _on_defaults_pressed() -> void:
	%Color.color = Color.html("61eb6e")
	# Setting the color manually doesn't emit the signal
	%Color.emit_signal("color_changed", %Color.color)
	%Speed.value = 0.01
	%Smoothness.value = 0.15
	%Distort.value = 1.0
	%Scale.value = 0.02
	%Step.value = 0.01
	%BaseDensity.value = 2.0


func _on_color_color_changed(color: Color) -> void:
	set_param(color, "color")


func _on_speed_value_changed(value: float) -> void:
	set_param(value, "speed")


func _on_smoothness_value_changed(value: float) -> void:
	set_param(value, "smoothness")


func _on_distort_value_changed(value: float) -> void:
	set_param(value, "distort")


func _on_scale_value_changed(value: float) -> void:
	set_param(value, "scale")


func _on_step_value_changed(value: float) -> void:
	set_param(value, "STEP")


func _on_base_density_value_changed(value: float) -> void:
	set_param(value, "BASE_DENSITY")
