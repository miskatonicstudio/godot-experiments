extends StaticBody

# TODO: for now a semi-transparent cube is shown as highlight
# consider highlighting an object
onready var highlight = $Highlight

var allowed_direction = null

func _ready():
	global.connect('reset_puzzle_piece_directions', self, 'reset_direction')

func highlight_on():
	if allowed_direction:
		highlight.visible = true

func highlight_off():
	highlight.visible = false

func reset_direction():
	allowed_direction = null
	highlight_off()

func select():
	if allowed_direction:
		global.emit_signal('move_puzzle_piece', allowed_direction)