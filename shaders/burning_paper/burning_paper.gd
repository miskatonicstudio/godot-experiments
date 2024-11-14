extends Node3D

@onready var sheet_material = $Sheet.material_override
@onready var pivot = $Pivot

func _process(delta: float) -> void:
	pivot.rotation_degrees.y += delta * 10


func _on_burn_slider_value_changed(value: float) -> void:
	sheet_material.set_shader_parameter("burn", value)


func _on_emission_slider_value_changed(value: float) -> void:
	sheet_material.set_shader_parameter("emission_strength", value)
