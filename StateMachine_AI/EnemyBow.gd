extends State
class_name EnemyBow

@export var Player: CharacterBody2D
@export var AnimPlayer: AnimationPlayer
@onready var Best_Move = AI.BestMove("EnemyBow")

func walkback_animation(): 
	AnimPlayer.play("bow")
	pass 


func Enter(): 
	walkback_animation()

func Update(delta: float): 
	if Best_Move == "EnemyIdle":
		Transition("EnemyIdle")
	else:
		Transition("idle")
	

func Transition(newstate : String):
		state_transition.emit(self, newstate)
