extends Node3D


func _on_option_button_item_selected(index: int) -> void:
	%Mesh.material_override.set_shader_parameter("flag_type", index)
