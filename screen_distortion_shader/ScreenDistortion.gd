extends Spatial


func _on_HSlider_value_changed(value):
	$Distortion.material.set_shader_param("BIAS", value)
