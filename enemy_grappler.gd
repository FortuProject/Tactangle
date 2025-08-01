extends CharacterBase
class_name EnemyMain

@onready var fsm = $StateMachine2 as FiniteStateMachine
#const DEATH_SCREEN = preload("res://Scenes/Misc/DeathScreen.tscn")

#All of our logic is either in the CharacterBase class
#or spread out over our states in the finite-state-manager, this class is almost empty 

func _die():
	super() #calls _die() on base-class CharacterBase
	fsm.force_change_state("Die")
	#var death_scene = DEATH_SCREEN.instantiate()
	#add_child(death_scene)

func _ready(): 
	if Global.Player_Two["User"] == "Player": 
		print("I'm a player")
		pass
	elif Global.Player_Two["User"] == "AI": 
		print("I'm AI")
		pass
