extends State
class_name EnemyCounter
@export var Player: CharacterBody2D
@export var AnimPlayer: AnimationPlayer

func throw_attempt_animation(): 
	AnimPlayer.play("counter_slap")

func Enter(): 
	#print("Grip attempt started.")
	throw_attempt_animation()

func Update(delta: float):
	#if Input.is_action_just_pressed("GRAB"):
		#Transition("PlayerGrab")
	#elif Input.is_action_just_pressed("RIGHT"):
		#Transition("PlayerWalkForward")
	#elif Input.is_action_just_pressed("LEFT"):
		#Transition("PlayerWalkBack")
	if Input.is_action_just_pressed("DOWN"):
		Transition("PlayerDown")
	elif Input.is_action_just_pressed("GRAB"):
		Transition("PlayerGrab")
	elif Input.is_action_just_pressed("KUZUSHI"):
		Transition("PlayerKuzushi")
	elif Input.is_action_just_pressed("THROW"):
		Transition("PlayerThrow")
	elif Input.is_action_just_pressed("COUNTER"):
		Transition("PlayerCounter")
	
	

func Transition(newstate : String):
		state_transition.emit(self, newstate)
