extends State
class_name EnemyKuzushi
@export var Player: CharacterBody2D
@export var AnimPlayer: AnimationPlayer

func kuzushi_attempt_animation(): 
	AnimPlayer.play("kuzushi")

func Enter(): 
	#print("Grip attempt started.")
	kuzushi_attempt_animation()

func Update(delta: float):
	#if Input.is_action_just_pressed("GRAB"):
		#Transition("PlayerGrab")
	if Input.is_action_just_pressed("RIGHT"):
		Transition("PlayerWalkForward")
	elif Input.is_action_just_pressed("LEFT"):
		Transition("PlayerWalkBack")
	elif Input.is_action_just_pressed("DOWN"):
		Transition("PlayerDown")
	elif Input.is_action_just_pressed("KUZUSHI"):
		Transition("PlayerKuzushi")
	elif Input.is_action_just_pressed("THROW"):
		Transition("PlayerThrow")
	

func Transition(newstate : String):
		state_transition.emit(self, newstate)
