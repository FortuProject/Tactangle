extends State
class_name PlayerWalking_Dash

@export var move_speed := 350
@export var dash_max := 500
@export var AnimPlayer: AnimationPlayer
@export var AudioManager: AudioStreamPlayer
@export var player: CharacterBody2D
@export var state_machine: FiniteStateMachine2

var dash_speed := 0.0
var can_dash := true
var dash_direction := Vector2.ZERO

func animation_breaker(): 
	#print("Breaking idle animation")
	AnimPlayer.stop()

func walk_animation(input): 
	if input == Vector2(1,0):
		AnimPlayer.play("walk_backward")
	elif input == Vector2(-1,0):
		AnimPlayer.play("walk_forward")
	pass 

func Enter():
	animation_breaker()
	var input_dir = Input.get_vector("LEFT", "RIGHT", "DOWN", "UP").normalized()
	input_dir.y = 0  # zero out Y component
	if str(InputParser.exported_move) == ("DASH") and can_dash:
		start_dash(input_dir)
	if input_dir == Vector2(0,0):
		Transition("Idle")
	walk_animation(input_dir)

func Update(delta: float):
	# Checks to see if this is already the current state. 
	if self != state_machine.current_state:
		return
	var input_dir = Input.get_vector("LEFT", "RIGHT", "DOWN", "UP").normalized()
	input_dir.y = 0  # zero out Y component
	Move(input_dir)
	handle_dash_decay(delta)

	if str(InputParser.exported_move) == ("DASH") and can_dash:
		start_dash(input_dir)

func Move(input_dir: Vector2):
	# Cancel dash if direction changes mid-dash
	if dash_direction != Vector2.ZERO and dash_direction != input_dir:
		dash_direction = Vector2.ZERO
		
		dash_speed = 0

	player.velocity = input_dir * move_speed + dash_direction * dash_speed
	player.move_and_slide()

	if player.velocity == Vector2(0,0):
		Transition("PlayerIdle")

func start_dash(input_dir: Vector2):
	if input_dir == Vector2.ZERO:
		return
	#AudioManager.play_sound(AudioManager.PLAYER_ATTACK_SWING, 0.3, -1)
	dash_direction = input_dir.normalized()
	dash_speed = dash_max
	AnimPlayer.play("run_forward")
	can_dash = false

func handle_dash_decay(delta: float):
	var friction := 4.0
	var time_drag := 4.1

	dash_speed -= (dash_speed * friction * delta) + (delta * time_drag)
	dash_speed = clamp(dash_speed, 0.0, dash_max)

	if dash_speed <= 0:
		can_dash = true
		dash_direction = Vector2.ZERO

	if AnimPlayer.current_animation == "run_forward":
		await AnimPlayer.animation_finished
		AnimPlayer.play("walk_forward")

func Transition(new_state: String):
	# Prevent state transitions mid-dash
	if dash_speed <= 0:
		state_transition.emit(self, new_state)

func Exit(): 
	animation_breaker()
