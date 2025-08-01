extends State
class_name EnemyThrow
@export var Player: CharacterBody2D
@export var AnimPlayer: AnimationPlayer
@onready var Best_Move = AI.BestMove("EnemyThrow")

func throw_attempt_animation(): 
	AnimPlayer.play("throw")

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
	elif Input.is_action_just_pressed("KUZUSHI"):
		Transition("PlayerKuzushi")
	elif Best_Move == "EnemyBow":
		Transition("EnemyBow")
	

func Transition(newstate : String):
		state_transition.emit(self, newstate)
