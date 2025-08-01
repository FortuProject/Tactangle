extends Node2D
var act_timers_player := [0, 0, 0, 0, 0, 0]
var dir_timers_player := [0, 0, 0, 0]

var act_timers_player2 := [0, 0, 0, 0, 0, 0]
var dir_timers_player2 := [0, 0, 0, 0]

#WHAT BUTTONS ARE PRESSED RIGHT NOW? 
@onready var ACT_BUTTONS_PLAYER = [$"UI/MoveHistoryPlayer/1st", $"UI/MoveHistoryPlayer/2nd", $"UI/MoveHistoryPlayer/3rd", $"UI/MoveHistoryPlayer/4th", $"UI/MoveHistoryPlayer/5th", $"UI/MoveHistoryPlayer/6th"]
@onready var DIR_BUTTONS_PLAYER = [$"UI/MoveHistoryPlayer/1st2", $"UI/MoveHistoryPlayer/2nd2", $"UI/MoveHistoryPlayer/3rd2",$"UI/MoveHistoryPlayer/4th2"]
@onready var ACT_BUTTONS_PLAYER2 = [$"UI/MoveHistoryEnemy/1st", $"UI/MoveHistoryEnemy/2nd", $"UI/MoveHistoryEnemy/3rd", $"UI/MoveHistoryEnemy/4th", $"UI/MoveHistoryEnemy/5th", $"UI/MoveHistoryEnemy/6th"]
@onready var DIR_BUTTONS_PLAYER2 = [$"UI/MoveHistoryEnemy/1st2", $"UI/MoveHistoryEnemy/2nd2", $"UI/MoveHistoryEnemy/3rd2",$"UI/MoveHistoryEnemy/4th2"]

# WHO IS WINNING THE EXCHANGES, WHAT'S ACTIVE? 
@onready var GRIP_SPRITE = $UI/Piece1_Sprite
@onready var KUZUSHI_SPRITE = $UI/Piece2_Sprite
@onready var THROW_SPRITE = $UI/Piece3_Sprite


func _ready():
	for button in ACT_BUTTONS_PLAYER:
		button.frame = 0
	for button in ACT_BUTTONS_PLAYER2:
		button.frame = 0
	for button in DIR_BUTTONS_PLAYER:
		button.frame = 0
	for button in DIR_BUTTONS_PLAYER2:
		button.frame = 0
	# SET SPRITES
	GRIP_SPRITE.frame = 14
	KUZUSHI_SPRITE.frame = 29
	THROW_SPRITE.frame = 44
	
func _process(_delta):
	for i in range(4):
		# Decrease countdowns
		if dir_timers_player[i] > 0:
			dir_timers_player[i] -= 1
		
		if dir_timers_player2[i] > 0: 
			dir_timers_player2[i] -= 1
	for i in range(6):
		# Decrease countdowns
		if act_timers_player[i] > 0:
			act_timers_player[i] -= 1
		
		if act_timers_player2[i] > 0:
			act_timers_player2[i] -= 1
	
	

	
	$UI/MoveHistoryPlayer/Label.text = str(InputParser.exported_move)
	
	# Direction inputs
	if Input.is_action_just_pressed("RIGHT"):
		dir_timers_player[1] = 10
		DIR_BUTTONS_PLAYER[1].frame = 1
	elif Input.is_action_pressed("RIGHT"):
		dir_timers_player[1] = 10
		DIR_BUTTONS_PLAYER[1].frame = 3
	elif Input.is_action_just_released("RIGHT"):
		dir_timers_player[1] = 10
		DIR_BUTTONS_PLAYER[1].frame = 2

	if Input.is_action_just_pressed("LEFT"):
		dir_timers_player[0] = 10
		DIR_BUTTONS_PLAYER[0].frame = 1
	elif Input.is_action_pressed("LEFT"):
		dir_timers_player[0] = 10
		DIR_BUTTONS_PLAYER[0].frame = 3
	elif Input.is_action_just_released("LEFT"):
		dir_timers_player[0] = 10
		DIR_BUTTONS_PLAYER[0].frame = 2
	
	if Input.is_action_just_pressed("UP"):
		dir_timers_player[2] = 10
		DIR_BUTTONS_PLAYER[2].frame = 1
	elif Input.is_action_pressed("UP"):
		dir_timers_player[2] = 10
		DIR_BUTTONS_PLAYER[2].frame = 3
	elif Input.is_action_just_released("UP"):
		dir_timers_player[2] = 10
		DIR_BUTTONS_PLAYER[2].frame = 2

	if Input.is_action_just_pressed("DOWN"):
		dir_timers_player[3] = 10
		DIR_BUTTONS_PLAYER[3].frame = 1
	elif Input.is_action_pressed("DOWN"):
		dir_timers_player[3] = 10
		DIR_BUTTONS_PLAYER[3].frame = 3
	elif Input.is_action_just_released("DOWN"):
		dir_timers_player[3] = 10
		DIR_BUTTONS_PLAYER[3].frame = 2

	# Action inputs
	if Input.is_action_just_pressed("GRAB"):
		act_timers_player[0] = 10
		ACT_BUTTONS_PLAYER[0].frame = 1
	elif Input.is_action_pressed("GRAB"):
		act_timers_player[0] = 10
		ACT_BUTTONS_PLAYER[0].frame = 3
	elif Input.is_action_just_released("GRAB"):
		act_timers_player[0] = 10
		ACT_BUTTONS_PLAYER[0].frame = 2

	if Input.is_action_just_pressed("KUZUSHI"):
		act_timers_player[1] = 10
		ACT_BUTTONS_PLAYER[1].frame = 1
	elif Input.is_action_pressed("KUZUSHI"):
		act_timers_player[1] = 10
		ACT_BUTTONS_PLAYER[1].frame = 3
	elif Input.is_action_just_released("KUZUSHI"):
		act_timers_player[1] = 10
		ACT_BUTTONS_PLAYER[1].frame = 2

	if Input.is_action_just_pressed("THROW"):
		act_timers_player[2] = 10
		ACT_BUTTONS_PLAYER[2].frame = 1
	elif Input.is_action_pressed("THROW"):
		act_timers_player[2] = 10
		ACT_BUTTONS_PLAYER[2].frame = 3
	elif Input.is_action_just_released("THROW"):
		act_timers_player[2] = 10
		ACT_BUTTONS_PLAYER[2].frame = 2

	if Input.is_action_just_pressed("COUNTER_GRAB"):
		act_timers_player[3] = 10
		ACT_BUTTONS_PLAYER[3].frame = 1
	elif Input.is_action_pressed("COUNTER_GRAB"):
		act_timers_player[3] = 10
		ACT_BUTTONS_PLAYER[3].frame = 3
	elif Input.is_action_just_released("COUNTER_GRAB"):
		act_timers_player[3] = 10
		ACT_BUTTONS_PLAYER[3].frame = 2
	
	if Input.is_action_just_pressed("COUNTER_KUZUSHI"):
		act_timers_player[4] = 10
		ACT_BUTTONS_PLAYER[4].frame = 1
	elif Input.is_action_pressed("COUNTER_KUZUSHI"):
		act_timers_player[4] = 10
		ACT_BUTTONS_PLAYER[4].frame = 3
	elif Input.is_action_just_released("COUNTER_KUZUSHI"):
		act_timers_player[4] = 10
		ACT_BUTTONS_PLAYER[4].frame = 2
	
	if Input.is_action_just_pressed("COUNTER_THROW"):
		act_timers_player[5] = 10
		ACT_BUTTONS_PLAYER[5].frame = 1
	elif Input.is_action_pressed("COUNTER_THROW"):
		act_timers_player[5] = 10
		ACT_BUTTONS_PLAYER[5].frame = 3
	elif Input.is_action_just_released("COUNTER_THROW"):
		act_timers_player[5] = 10
		ACT_BUTTONS_PLAYER[5].frame = 2


	## Direction inputs
	if Input.is_action_just_pressed("RIGHT_P2"):
		dir_timers_player2[1] = 10
		DIR_BUTTONS_PLAYER2[1].frame = 1
	elif Input.is_action_pressed("RIGHT_P2"):
		dir_timers_player2[1] = 10
		DIR_BUTTONS_PLAYER2[1].frame = 3
	elif Input.is_action_just_released("RIGHT_P2"):
		dir_timers_player2[1] = 10
		DIR_BUTTONS_PLAYER2[1].frame = 2

	if Input.is_action_just_pressed("LEFT_P2"):
		dir_timers_player2[0] = 10
		DIR_BUTTONS_PLAYER2[0].frame = 1
	elif Input.is_action_pressed("LEFT_P2"):
		dir_timers_player2[0] = 10
		DIR_BUTTONS_PLAYER2[0].frame = 3
	elif Input.is_action_just_released("LEFT_P2"):
		dir_timers_player2[0] = 10
		DIR_BUTTONS_PLAYER2[0].frame = 2
	
	if Input.is_action_just_pressed("UP_P2"):
		dir_timers_player2[2] = 10
		DIR_BUTTONS_PLAYER2[2].frame = 1
	elif Input.is_action_pressed("UP_P2"):
		dir_timers_player2[2] = 10
		DIR_BUTTONS_PLAYER2[2].frame = 3
	elif Input.is_action_just_released("UP_P2"):
		dir_timers_player2[2] = 10
		DIR_BUTTONS_PLAYER2[2].frame = 2

	if Input.is_action_just_pressed("DOWN_P2"):
		dir_timers_player2[3] = 10
		DIR_BUTTONS_PLAYER2[3].frame = 1
	elif Input.is_action_pressed("DOWN_P2"):
		dir_timers_player2[3] = 10
		DIR_BUTTONS_PLAYER2[3].frame = 3
	elif Input.is_action_just_released("DOWN_P2"):
		dir_timers_player2[3] = 10
		DIR_BUTTONS_PLAYER2[3].frame = 2

	# Action inputs
	if Input.is_action_just_pressed("GRAB_P2"):
		act_timers_player2[0] = 10
		ACT_BUTTONS_PLAYER2[0].frame = 1
	elif Input.is_action_pressed("GRAB_P2"):
		act_timers_player2[0] = 10
		ACT_BUTTONS_PLAYER2[0].frame = 3
	elif Input.is_action_just_released("GRAB_P2"):
		act_timers_player2[0] = 10
		ACT_BUTTONS_PLAYER2[0].frame = 2

	if Input.is_action_just_pressed("KUZUSHI_P2"):
		act_timers_player2[1] = 10
		ACT_BUTTONS_PLAYER2[1].frame = 1
	elif Input.is_action_pressed("KUZUSHI_P2"):
		act_timers_player2[1] = 10
		ACT_BUTTONS_PLAYER2[1].frame = 3
	elif Input.is_action_just_released("KUZUSHI_P2"):
		act_timers_player2[1] = 10
		ACT_BUTTONS_PLAYER2[1].frame = 2

	if Input.is_action_just_pressed("THROW_P2"):
		act_timers_player2[2] = 10
		ACT_BUTTONS_PLAYER2[2].frame = 1
	elif Input.is_action_pressed("THROW_P2"):
		act_timers_player2[2] = 10
		ACT_BUTTONS_PLAYER2[2].frame = 3
	elif Input.is_action_just_released("THROW_P2"):
		act_timers_player2[2] = 10
		ACT_BUTTONS_PLAYER2[2].frame = 2

	if Input.is_action_just_pressed("COUNTER_GRAB_P2"):
		act_timers_player2[3] = 10
		ACT_BUTTONS_PLAYER2[3].frame = 1
	elif Input.is_action_pressed("COUNTER_GRAB_P2"):
		act_timers_player2[3] = 10
		ACT_BUTTONS_PLAYER2[3].frame = 3
	elif Input.is_action_just_released("COUNTER_GRAB_P2"):
		act_timers_player2[3] = 10
		ACT_BUTTONS_PLAYER2[3].frame = 2
	
	if Input.is_action_just_pressed("COUNTER_KUZUSHI_P2"):
		act_timers_player2[4] = 10
		ACT_BUTTONS_PLAYER2[4].frame = 1
	elif Input.is_action_pressed("COUNTER_KUZUSHI_P2"):
		act_timers_player2[4] = 10
		ACT_BUTTONS_PLAYER2[4].frame = 3
	elif Input.is_action_just_released("COUNTER_KUZUSHI_P2"):
		act_timers_player2[4] = 10
		ACT_BUTTONS_PLAYER2[4].frame = 2
	
	if Input.is_action_just_pressed("COUNTER_THROW_P2"):
		act_timers_player2[5] = 10
		ACT_BUTTONS_PLAYER2[5].frame = 1
	elif Input.is_action_pressed("COUNTER_THROW_P2"):
		act_timers_player2[5] = 10
		ACT_BUTTONS_PLAYER2[5].frame = 3
	elif Input.is_action_just_released("COUNTER_THROW_P2"):
		act_timers_player2[5] = 10
		ACT_BUTTONS_PLAYER2[5].frame = 2
	
	# Reset frames back to neutral (0) when timer expires
	for i in range(4):
		if dir_timers_player2[i] == 0:
			DIR_BUTTONS_PLAYER2[i].frame = 0

	for i in range(6):
		if act_timers_player2[i] == 0:
			ACT_BUTTONS_PLAYER2[i].frame = 0
