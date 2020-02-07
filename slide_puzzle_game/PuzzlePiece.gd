extends Spatial

export (int) var SIZE = 1

var arrays = null

func _init():
	arrays = _generate_quad_mesh_arrays(SIZE)

func _ready():
	# TODO: consider moving this to init, with MeshInstance creation there
	# TODO: consider material render priority instead of moving MeshInstance.z
	# TODO: use a model instead of ObjectMesh, consider adding a frame to the puzzle
	var array_mesh = ArrayMesh.new()
	array_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLE_FAN, arrays)
	$MeshInstance.mesh = array_mesh

func _generate_quad_mesh_arrays(size=1):
	var new_quad_mesh = QuadMesh.new()
	new_quad_mesh.size = Vector2(size, size)
	return new_quad_mesh.get_mesh_arrays().duplicate()

func set_uv(index_x, index_y, size):
	index_y = size - index_y - 1 # UV starts top left
	var uv_delta = 1 / float(size)
	# TODO: consider using a loop here
	arrays[ArrayMesh.ARRAY_TEX_UV][0] = Vector2(uv_delta * (index_x), uv_delta * (index_y + 1))
	arrays[ArrayMesh.ARRAY_TEX_UV][1] = Vector2(uv_delta * (index_x), uv_delta * (index_y))
	arrays[ArrayMesh.ARRAY_TEX_UV][2] = Vector2(uv_delta * (index_x + 1), uv_delta * (index_y))
	arrays[ArrayMesh.ARRAY_TEX_UV][3] = Vector2(uv_delta * (index_x + 1), uv_delta * (index_y + 1))
	arrays[ArrayMesh.ARRAY_TEX_UV][4] = Vector2(uv_delta * (index_x + 1), uv_delta * (index_y))
	arrays[ArrayMesh.ARRAY_TEX_UV][5] = Vector2(uv_delta * (index_x + 1), uv_delta * (index_y + 1))

func set_allowed_direction(direction):
	$Detectable.allowed_direction = direction