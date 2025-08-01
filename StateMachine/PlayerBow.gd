extends State
class_name PlayerBow

@export var Player: CharacterBody2D
@export var AnimPlayer: AnimationPlayer
@export var SFX: AudioStreamPlayer 
@export var CALLOUT: Label

var i = 0
func bow_animation(): 
	AnimPlayer.play("bow")
	pass 


func Enter(): 
	#SFX.stream = load("res://assets/audio/SFX/BigHit2.mp3")
	#SFX.play()
	bow_animation()

func Update(delta: float): 
	while i < 50: 
		i = i+1 
		return
	Transition("PlayerIdle")

	
func Transition(newstate : String):
		state_transition.emit(self, newstate)

func Exit():
	CALLOUT.hide()
