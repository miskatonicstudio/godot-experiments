extends Spatial

export (int) var SIZE = 4
export (Image) var IMAGE = preload('res://icon.png')
export (int) var SHUFFLE_ITERATIONS = 100

# TODO: display frame around the puzzle
# TODO: extract game backend

# TODO: check if this is required
var empty_coords = Vector2(0, 0)
# TODO: check if this is required
var PUZZLE_PIECE_IDS = null
var SOLVED_PUZZLE_PIECE_IDS = null

onready var front_material = load('res://front_puzzle_material.tres')
var puzzle_piece_scene = load('res://PuzzlePiece.tscn')
onready var tween = $Tween

func _ready():
	front_material.albedo_texture = IMAGE
	PUZZLE_PIECE_IDS = []
	for x in range(SIZE):
		PUZZLE_PIECE_IDS.append([])
		for y in range(SIZE):
			if x == 0 and y == 0:
				PUZZLE_PIECE_IDS[x].append(null)
				continue
			var puzzle_piece_id = coords_to_id(x, y)
			PUZZLE_PIECE_IDS[x].append(puzzle_piece_id)
			var puzzle_piece = puzzle_piece_scene.instance()
			puzzle_piece.add_to_group(puzzle_piece_id)
			puzzle_piece.set_uv(x, y, SIZE)
			puzzle_piece.translation = get_translation_from_coords(Vector2(x, y))
			$Rotator.add_child(puzzle_piece)
	
	set_solved_puzzle_piece_ids(PUZZLE_PIECE_IDS)	
	shuffle_puzzle_pieces()	
	enable_fields()
	global.connect('move_puzzle_piece', self, 'move_puzzle_piece')
	tween.start()

func shuffle_puzzle_pieces():
	for i in range(SHUFFLE_ITERATIONS):
		var allowed_direction_vectors = get_allowed_direction_vectors()
		var direction_vector = allowed_direction_vectors[randi() % allowed_direction_vectors.size()]
		swap_puzzle_piece_with_empty(direction_vector)

func swap_puzzle_piece_with_empty(direction_vector):
	var puzzle_piece_coords = empty_coords - direction_vector
	var puzzle_piece = get_puzzle_piece_by_id(get_puzzle_piece_id_by_coords(puzzle_piece_coords))
	puzzle_piece.translation = get_translation_from_coords(empty_coords)
	swap_puzzle_piece_ids(empty_coords, puzzle_piece_coords)
	empty_coords = puzzle_piece_coords

func get_translation_from_coords(coords):
	return Vector3(-SIZE/2 + 0.5 + coords.x, -SIZE/2 + 0.5 + coords.y, 0)

func move_puzzle_piece(direction_vector):
	global.emit_signal('reset_puzzle_piece_directions')
	var destination_coords = empty_coords - direction_vector
	var puzzle_piece_id = get_puzzle_piece_id_by_coords(destination_coords)
	var puzzle_piece = get_puzzle_piece_by_id(puzzle_piece_id)
	tween.interpolate_property(
		puzzle_piece, 'translation',
		puzzle_piece.translation, get_translation_from_coords(empty_coords),
		0.2, Tween.TRANS_SINE, Tween.EASE_IN_OUT
	)
	tween.resume_all()
	swap_puzzle_piece_ids(empty_coords, destination_coords)
	empty_coords = destination_coords

func enable_fields():
	for direction_vector in get_allowed_direction_vectors():
		enable_field(direction_vector)

func enable_field(direction_vector):
	var field_coords = empty_coords - direction_vector
	var puzzle_piece_id = get_puzzle_piece_id_by_coords(field_coords)
	var puzzle_piece = get_puzzle_piece_by_id(puzzle_piece_id)
	puzzle_piece.set_allowed_direction(direction_vector)

# TODO: we have * -1 more than once, consider changing this method
func get_vector_from_direction(direction):
	if direction == 'up':
		return Vector2(0, 1)
	elif direction == 'down':
		return Vector2(0, -1)
	elif direction == 'left':
		return Vector2(-1, 0)
	else:
		return Vector2(1, 0)

func field_exists(coords):
	return coords.x >=0 and coords.y >= 0 and coords.x < SIZE and coords.y < SIZE

func coords_to_id(x, y):
	return 'piece_' + str(y * SIZE + x)

func get_puzzle_piece_by_id(puzzle_piece_id):
	return get_tree().get_nodes_in_group(puzzle_piece_id).pop_back()

func _on_Tween_tween_completed(object, key):
	if PUZZLE_PIECE_IDS == SOLVED_PUZZLE_PIECE_IDS:
		global.emit_signal('victory')
	else:
		enable_fields()

func get_puzzle_piece_id_by_coords(coords):
	return PUZZLE_PIECE_IDS[coords.x][coords.y]

func set_puzzle_piece_id_by_coords(coords, puzzle_piece_id):
	PUZZLE_PIECE_IDS[coords.x][coords.y] = puzzle_piece_id

func swap_puzzle_piece_ids(coords1, coords2):
	var temp_puzzle_piece_id = get_puzzle_piece_id_by_coords(coords1)
	set_puzzle_piece_id_by_coords(coords1, get_puzzle_piece_id_by_coords(coords2))
	set_puzzle_piece_id_by_coords(coords2, temp_puzzle_piece_id)

func get_allowed_direction_vectors():
	var allowed_direction_vectors = []
	for direction in ['up', 'down', 'left', 'right']:
		var direction_vector = get_vector_from_direction(direction)
		var field_coords = empty_coords - direction_vector
		if field_exists(field_coords):
			allowed_direction_vectors.append(direction_vector)
	return allowed_direction_vectors

func set_solved_puzzle_piece_ids(puzzle_piece_ids):
	SOLVED_PUZZLE_PIECE_IDS = []
	for row in puzzle_piece_ids:
		SOLVED_PUZZLE_PIECE_IDS.append(row.duplicate())
