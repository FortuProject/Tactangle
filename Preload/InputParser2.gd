extends Node

@onready var DisabledFunction: bool = true

enum Combo {
	UP, 
	DOWN, 
	DOWN_RIGHT,
	RIGHT,
	UP_RIGHT,
	LEFT, 
	UP_LEFT,
	DOWN_LEFT,
	GRAB, 
	KUZUSHI, 
	THROW, 
	COUNTER_GRAB,
	KUZUSHI_COUNTER,
	THROW_COUNTER,
	QUARTER_CIRCLE_FORWARD,
	QUARTER_CIRCLE_BACKWARD,
	NOTHING,
	GRAB_KUZUSHI,
	GRAB_THROW,
	GRAB_COUNTER,
	KUZUSHI_THROW,
}


# Add these helper variables at the top of your script
var last_direction := Vector2.ZERO
var quarter_circle_progress := 0
enum QuarterCircleState {NONE, DOWN, DOWN_RIGHT, RIGHT}

# Modify your get_current_input function to track quarter circle motions
const MAX_TIME_DIFF := 0.08  # 10 frames at 60 FPS

var input_times = {
	"UP": -1.0,
	"DOWN": -1.0,
	"LEFT": -1.0,
	"RIGHT": -1.0,
}

var input_history: Array = []      # Stores all recent inputs with timestamps
var current_move_sequence: Array = []  # Tracks the current sequence of moves
var exported_move = "DOWN"
const DIRECTION_BUFFER_TIME_MS := 700
var direction_history: Array = []  # List of {"time": int, "dir": Combo}
var action_history: Array = []  # List of {"time": int, "dir": Combo}

signal move_detected(move_name: String)

# Movement definitions - ordered from most specific to least specific
var MOVEMENTS = [
	# Full combos first (longest first!)
	# Later storted by length so it should be ok in any order. 
	
	{"name": "THROW_SPECIAL", "pattern": [Combo.DOWN, Combo.DOWN_RIGHT, Combo.RIGHT, Combo.THROW]},
	{"name": "THROW_SPECIAL", "pattern":[Combo.DOWN, Combo.DOWN_LEFT, Combo.LEFT, Combo.THROW]},
	
	
	{"name": "GRAB_SPECIAL", "pattern": [Combo.DOWN, Combo.DOWN_RIGHT, Combo.RIGHT, Combo.GRAB]},
	{"name": "GRAB_SPECIAL", "pattern": [Combo.DOWN, Combo.DOWN_LEFT, Combo.LEFT, Combo.GRAB]},
	{"name": "GRAB_SPECIAL", "pattern": [Combo.DOWN, Combo.RIGHT, Combo.GRAB]},
	{"name": "GRAB_SPECIAL", "pattern": [Combo.DOWN, Combo.LEFT, Combo.GRAB]},
	
	
	{"name": "KUZSHI_SPECIAL", "pattern": [Combo.DOWN, Combo.DOWN_RIGHT, Combo.RIGHT, Combo.KUZUSHI]},
	{"name": "KUZSHI_SPECIAL", "pattern":[Combo.DOWN, Combo.DOWN_LEFT, Combo.LEFT, Combo.KUZUSHI]},
	{"name": "KUZUSHI_SPECIAL", "pattern": [Combo.DOWN, Combo.RIGHT, Combo.KUZUSHI]},
	{"name": "KUZUSHI_SPECIAL", "pattern": [Combo.DOWN, Combo.LEFT, Combo.KUZUSHI]},
	
	{"name": "THROW_SPECIAL", "pattern": [Combo.DOWN, Combo.DOWN_RIGHT, Combo.RIGHT, Combo.THROW]},
	{"name": "THROW_SPECIAL", "pattern": [Combo.DOWN, Combo.DOWN_LEFT, Combo.LEFT, Combo.THROW]},
	{"name": "THROW_SPECIAL", "pattern": [Combo.DOWN, Combo.RIGHT, Combo.THROW]},
	{"name": "THROW_SPECIAL", "pattern": [Combo.DOWN, Combo.LEFT, Combo.THROW]},
	
	
	{"name": "GRAB_COMBO", "pattern": [Combo.GRAB, Combo.KUZUSHI, Combo.THROW]},
	
	{"name": "RAPID_GRAB", "pattern": [Combo.GRAB, Combo.NOTHING, Combo.GRAB, Combo.NOTHING, Combo.GRAB]},
	{"name": "RAPID_THROW", "pattern": [Combo.THROW, Combo.NOTHING, Combo.THROW, Combo.NOTHING, Combo.THROW]},
	{"name": "RAPID_KUZUSHI", "pattern": [Combo.KUZUSHI, Combo.NOTHING, Combo.KUZUSHI, Combo.NOTHING, Combo.KUZUSHI]},
	
	
	# Motion shortcuts or simplified versions
	#{"name": "QUARTER_CIRCLE_FORWARD", "pattern": [Combo.DOWN, Combo.DOWN_RIGHT, Combo.RIGHT]},
	#{"name": "QUARTER_CIRCLE_FORWARD", "pattern": [Combo.DOWN, Combo.RIGHT]},
	#{"name": "QUARTER_CIRCLE_BACKWARD", "pattern": [Combo.DOWN, Combo.DOWN_LEFT, Combo.LEFT]},
	#{"name": "QUARTER_CIRCLE_BACKWARD", "pattern": [Combo.DOWN, Combo.LEFT]},
	
	{"name": "HALF_CIRCLE_FORWARD", "pattern": [Combo.LEFT, Combo.DOWN_LEFT, Combo.DOWN, Combo.DOWN_RIGHT, Combo.RIGHT]},
	{"name": "HALF_CIRCLE_BACKWARD", "pattern": [Combo.RIGHT, Combo.DOWN_RIGHT, Combo.DOWN, Combo.DOWN_LEFT, Combo.LEFT]},
	{"name": "TOP_HALF_CIRCLE_FORWARD", "pattern": [Combo.LEFT, Combo.UP_LEFT, Combo.UP, Combo.UP_RIGHT, Combo.RIGHT]},
	{"name": "TOP_HALF_CIRCLE_BACKWARD", "pattern": [Combo.RIGHT, Combo.UP_RIGHT, Combo.UP, Combo.UP_LEFT, Combo.LEFT]},
	
	
	{"name": "DP_MOTION", "pattern": [Combo.RIGHT, Combo.DOWN, Combo.DOWN_RIGHT]},
	{"name": "DASH","pattern": [Combo.RIGHT,Combo.UP, Combo.RIGHT]},
	{"name": "DASH","pattern": [Combo.LEFT ,Combo.UP, Combo.LEFT]},
	
	
	# Simple motions
	{"name": "DOWN_RIGHT", "pattern": [Combo.DOWN_RIGHT]},
	{"name": "UP_RIGHT", "pattern": [Combo.UP_RIGHT]},
	{"name": "DOWN_LEFT", "pattern": [Combo.DOWN_LEFT]},
	{"name": "UP_LEFT", "pattern": [Combo.UP_LEFT]},
	{"name": "UP", "pattern": [Combo.UP]},
	{"name": "DOWN", "pattern": [Combo.DOWN]},
	{"name": "LEFT", "pattern": [Combo.LEFT]},
	{"name": "RIGHT", "pattern": [Combo.RIGHT]},
	{"name": "NOTHING", "pattern": [Combo.NOTHING]},
	# Button presses
	{"name": "GRAB", "pattern": [Combo.GRAB]},
	{"name": "KUZUSHI", "pattern": [Combo.KUZUSHI]},
	{"name": "THROW", "pattern": [Combo.THROW]},
]

func _ready():
	# Sort movements by pattern length (longest first) for priority in matching
	MOVEMENTS.sort_custom(func(a, b): return a["pattern"].size() > b["pattern"].size())

func _process(_delta):
	update_input_times()
	if DisabledFunction: 
		return
	#if current_move_sequence.has("QUARTER_CIRCLE_FORWARD") == true:
		#print("QUATER CIRCLE FORWARD ACHIVED")
	var dir := get_current_direction()
	var now := Time.get_ticks_msec()

	if dir != -1:
		if direction_history.size() == 0 or direction_history.back()["dir"] != dir:
			direction_history.append({"time": now, "dir": dir, "type": "direction"})

# For action:
	var act := get_current_actions()
	if act != -1: 
		if action_history.size() == 0 or action_history.back()["dir"] != act:
			action_history.append({"time": now, "dir": act, "type": "action"})

	
	direction_history = direction_history + action_history
	action_history.clear()
	direction_history.sort_custom(func(a, b): return a["time"] < b["time"])
	cleanup_old_directions()
	process_direction_buffer()
	
func cleanup_old_directions():
	var now := Time.get_ticks_msec()
	while direction_history.size() > 0 and now - direction_history[0]["time"] > DIRECTION_BUFFER_TIME_MS:
		direction_history.pop_front()


func process_direction_buffer():
	var sequence := []
	for entry in direction_history:
		sequence.append(entry["dir"])

	var matched_move := match_movement(sequence)
	if matched_move != "":
		exported_move = matched_move
		current_move_sequence.append(matched_move)
		if current_move_sequence.size() > 5:
			current_move_sequence = current_move_sequence.slice(current_move_sequence.size() - 5, current_move_sequence.size())
		move_detected.emit(matched_move)
		#current_move_sequence.clear()
		# Optionally clear history after a move to avoid repeats
		# Clearing this doesn't help with anything. 
		#direction_history.clear()


func match_movement(input_sequence: Array) -> String:
	for move in MOVEMENTS:
		if pattern_in_sequence(move["pattern"], input_sequence):
			return move["name"]
	return ""

func update_input_times():
	for dir in input_times.keys():
		if Input.is_action_just_pressed(dir):
			input_times[dir] = Time.get_ticks_msec() / 1000.0

func get_current_direction() -> int:
	var now = Time.get_ticks_msec() / 1000.0

	# Check diagonals
	if time_close("UP", "RIGHT", now):
		return Combo.UP_RIGHT
	elif time_close("DOWN", "RIGHT", now):
		return Combo.DOWN_RIGHT
	elif time_close("UP", "LEFT", now):
		return Combo.UP_LEFT
	elif time_close("DOWN", "LEFT", now):
		return Combo.DOWN_LEFT

	# Check single directions
	if Input.is_action_just_pressed("RIGHT_P2"):
		return Combo.RIGHT
	elif Input.is_action_just_pressed("LEFT_P2"):
		return Combo.LEFT
	elif Input.is_action_just_pressed("UP_P2"):
		return Combo.UP
	elif Input.is_action_just_pressed("DOWN_P2"):
		return Combo.DOWN

	return -1

func time_close(a: String, b: String, now: float) -> bool:
	return (
		input_times.has(a) and input_times.has(b) and
		abs(input_times[a] - input_times[b]) <= MAX_TIME_DIFF and
		(now - input_times[a] <= MAX_TIME_DIFF or now - input_times[b] <= MAX_TIME_DIFF)
	)

func get_current_actions() -> int:

	var now = Time.get_ticks_msec() / 1000.0

	# Check diagonals
	if time_close("GRAB", "KUZUSHI", now):
		return Combo.GRAB_KUZUSHI
	elif time_close("GRAB", "THROW", now):
		return Combo.GRAB_THROW
	elif time_close("GRAB", "COUNTER", now):
		return Combo.GRAB_COUNTER
	elif time_close("KUZUSHI", "THROW", now):
		return Combo.KUZUSHI_THROW
	elif time_close("KUZUSHI", "COUNTER", now):
		return Combo.KUZUSHI_COUNTER
	elif time_close("THROW", "COUNTER", now):
		return Combo.THROW_COUNTER


	# Check single directions
	if Input.is_action_just_pressed("GRAB_P2"):
		return Combo.GRAB
	elif Input.is_action_just_pressed("KUZUSHI_P2"):
		return Combo.KUZUSHI
	elif Input.is_action_just_pressed("THROW_P2"):
		return Combo.THROW
	elif Input.is_action_just_pressed("COUNTER_GRAB_P2"):
		return Combo.COUNTER_GRAB
	elif Input.is_action_just_pressed("COUNTER_KUZUSHI_P2"):
		return Combo.KUZUSHI_COUNTER
	elif Input.is_action_just_pressed("COUNTER_THROW_P2"):
		return Combo.THROW_COUNTER
	else: 
		return -1

	return -1

# New helper function to detect quarter circle motion
func check_quarter_circle(current_dir: Vector2) -> bool:
	# Quarter circle forward: Down -> Down+Right -> Right
	if current_dir.length() > 0.7:  # Significant input
		if quarter_circle_progress == 0 and current_dir.y > 0.7 and abs(current_dir.x) < 0.3:
			quarter_circle_progress = 1  # Down detected
		elif quarter_circle_progress == 1 and current_dir.y > 0.7 and current_dir.x > 0.7:
			quarter_circle_progress = 2  # Down+Right detected
		elif quarter_circle_progress == 2 and current_dir.x > 0.7 and abs(current_dir.y) < 0.3:
			quarter_circle_progress = 0  # Reset
			return true  # Full quarter circle detected
		else:
			# If input doesn't match expected sequence, reset
			if not (current_dir.y > 0.5 and current_dir.x > 0.5):
				quarter_circle_progress = 0
	return false

# Convert the Vector2 direction to the closest Combo direction (or NONE)
func vector_to_direction(v: Vector2) -> int:
	if v.length() < 0.5:
		return -1  # no direction

	var angle = v.angle()
	# Map angle ranges to your enum directions (approximate)
	# Angles in radians, 0 points right, positive CCW
	
	# RIGHT = 0
	# UP_RIGHT = -45 deg = -PI/4
	# UP = -90 deg = -PI/2
	# UP_LEFT = -135 deg = -3PI/4
	# LEFT = PI or -PI
	# DOWN_LEFT = 135 deg = 3PI/4
	# DOWN = 90 deg = PI/2
	# DOWN_RIGHT = 45 deg = PI/4
	
	# We'll do this in degrees for readability
	var deg = rad_to_deg(angle)
	if deg < 0:
		deg += 360

	if deg >= 337.5 or deg < 22.5:
		return Combo.RIGHT
	elif deg >= 22.5 and deg < 67.5:
		return Combo.DOWN_RIGHT
	elif deg >= 67.5 and deg < 112.5:
		return Combo.DOWN
	elif deg >= 112.5 and deg < 157.5:
		return Combo.DOWN_LEFT
	elif deg >= 157.5 and deg < 202.5:
		return Combo.LEFT
	elif deg >= 202.5 and deg < 247.5:
		return Combo.UP_LEFT
	elif deg >= 247.5 and deg < 292.5:
		return Combo.UP
	elif deg >= 292.5 and deg < 337.5:
		return Combo.UP_RIGHT
	
	return -1

# Check if a pattern is a subsequence of inputs with optional gaps
func pattern_in_sequence(patterns, sequence: Array) -> bool:
	# Normalize single pattern to a list of patterns
	if typeof(patterns[0]) != TYPE_ARRAY:
		patterns = [patterns]  # wrap in array
	
	for pattern in patterns:
		var pi = 0  # pattern index
		for item in sequence:
			if item == pattern[pi]:
				pi += 1
				if pi >= pattern.size():
					return true
	return false

func detect_quarter_circle_in_buffer() -> bool:
	# Extract directions from recent inputs (e.g., from input_history)
	var directions = []
	for entry in input_history:
		# Convert each Vector2 input to closest direction
		for dir_vec in entry["input"]:
			if typeof(dir_vec) == TYPE_VECTOR2:
				var dir_enum = vector_to_direction(dir_vec)
				if dir_enum != -1:
					directions.append(dir_enum)
			else:
				# If input is already enum (like Combo.DOWN), just append
				directions.append(dir_vec)
	
	# Check quarter circle forward pattern
	var qcf_pattern = [Combo.DOWN, Combo.DOWN_RIGHT, Combo.RIGHT]
	if pattern_in_sequence(qcf_pattern, directions):
		return true
	
	# Check quarter circle backward pattern
	var qcb_pattern = [Combo.DOWN, Combo.DOWN_LEFT, Combo.LEFT]
	if pattern_in_sequence(qcb_pattern, directions):
		return true
	
	return false
