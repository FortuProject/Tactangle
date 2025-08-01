extends State
class_name EnemyGrab
@export var Player: CharacterBody2D
@export var AnimPlayer: AnimationPlayer
@onready var Best_Move = AI.BestMove("EnemyGrab")

func grab_attempt_animation(): 
	AnimPlayer.play("grab")

func Enter(): 
	#print("Grip attempt started.")
	grab_attempt_animation()

func Update(delta: float):
	if Best_Move == "EnemyThrow":
		Transition("EnemyThrow")
	#if Input.is_action_just_pressed("KUZUSHI"):
		#Transition("PlayerKuzushi")
	#elif Input.is_action_just_pressed("RIGHT"):
		#Transition("PlayerWalkForward")
	#elif Input.is_action_just_pressed("LEFT"):
		#Transition("PlayerWalkBack")
	#elif Input.is_action_just_pressed("DOWN"):
		#Transition("PlayerDown")
	

func Transition(newstate : String):
		state_transition.emit(self, newstate)
