extends CharacterBase
class_name PlayerMain

@onready var Callout = $Callout
@onready var fsm = $StateMachine as FiniteStateMachine
#const DEATH_SCREEN = preload("res://Scenes/Misc/DeathScreen.tscn")

#All of our logic is either in the CharacterBase class
#or spread out over our states in the finite-state-manager, this class is almost empty 

func _die():
	super() #calls _die() on base-class CharacterBase
	fsm.force_change_state("Die")
	Callout.shot() 
	Callout.text = "Punkt!!"
	#var death_scene = DEATH_SCREEN.instantiate()
	#add_child(death_scene)
	

func _ready(): 
	super()
	fsm.force_change_state("PlayerBow")
