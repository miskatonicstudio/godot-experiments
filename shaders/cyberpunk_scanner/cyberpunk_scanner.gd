extends Node3D


func _process(delta: float) -> void:
	%Pivot.rotation_degrees.y -= delta * 4
	# Ensure that the scanning camera has the same position as the main camera
	%ScanningCamera.global_transform = %Camera.global_transform


func set_param(value, shader_param_name):
	%ScanningViewport.material.set_shader_parameter(shader_param_name, value)


func get_param(shader_param_name):
	return %ScanningViewport.material.get_shader_parameter(shader_param_name)


func _on_scan_toggled(toggled_on: bool) -> void:
	%Scan.text = ("Stop" if toggled_on else "Start") + " scanning"
	if get_param("visibility") < 0.5:
		set_param(1, "visibility")
		set_param(0, "scanning_progress")
		get_tree().create_tween().tween_method(set_param.bind("scanning_progress"), 0.0, 1.0, 1.2)
	else:
		get_tree().create_tween().tween_method(set_param.bind("visibility"), 1.0, 0.0, 0.2)


func _on_color_picker_button_color_changed(color: Color) -> void:
	set_param(color, "color")


func _on_init_outline_value_changed(value: float) -> void:
	set_param(value, "initial_outline_pixel_size")


func _on_final_outline_value_changed(value: float) -> void:
	set_param(value, "final_outline_pixel_size")


func _on_init_fill_value_changed(value: float) -> void:
	set_param(value, "initial_fill_transparency")


func _on_final_fill_value_changed(value: float) -> void:
	set_param(value, "final_fill_transparency")


func _on_init_pixel_value_changed(value: float) -> void:
	set_param(value, "initial_pixelize_power")


func _on_final_pixel_value_changed(value: float) -> void:
	set_param(value, "final_pixelize_power")
