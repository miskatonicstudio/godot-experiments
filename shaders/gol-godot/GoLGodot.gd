extends Control

@onready var viewport_container = $SubViewportContainer
@onready var viewport = $SubViewportContainer/SubViewport
@onready var texture_rect = $SubViewportContainer/SubViewport/TextureRect

const GOL_SIZE = 128

var _gol_texture: ImageTexture


func _ready():
	# The trick is to plug in the output of the shader as it's input ;)
	# That way each iteration works on the results of the previous one
	RenderingServer.force_draw()
	_gol_texture = ImageTexture.create_from_image(viewport.get_texture().get_image())
	texture_rect.material.set_shader_parameter('gol', _gol_texture);
	_on_GoLGodot_resized()


func _process(_delta: float) -> void:
	_gol_texture.update(viewport.get_texture().get_image())


func _on_GoLGodot_resized():
	if viewport_container == null:
		return
	var size = self.size
	var min_size = min(size.x, size.y)
	var scale = min_size / GOL_SIZE
	viewport_container.scale = Vector2(scale, scale)


func _on_TextureRect_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			var img = viewport.get_texture().get_image()
			var tex = ImageTexture.create_from_image(img)
			texture_rect.material.set_shader_parameter('gol', tex)
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			texture_rect.material.set_shader_parameter('gol', _gol_texture);
