extends State
class_name EnemyDown

@export var Player: CharacterBody2D
@export var AnimPlayer: AnimationPlayer

func Enter(): 
	pass

func Update(delta: float):
	#Player.velocity = Vector2.DOWN
	#Player.move_and_slide() 
	if Input.is_action_pressed("DOWN"):
		Transition("PlayerIdle")

func Transition(newstate : String):
		state_transition.emit(self, newstate)
