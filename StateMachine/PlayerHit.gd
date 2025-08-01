extends State
class_name PlayerHit

@export var Player: CharacterBody2D
@export var AnimPlayer: AnimationPlayer
@export var Hurtbox_1: CollisionShape2D
@export var Hitbox_1: CollisionShape2D
@export var SFX: AudioStreamPlayer 

func check_self_state(): 
	return true
	pass 

func idle_animation(): 
	AnimPlayer.play("hit_animation")

func Enter(): 
	SFX.stream = load("res://assets/audio/SFX/Move1.wav")
	SFX.play()
	if check_self_state() == true:
		idle_animation()

	pass

func Update(delta: float): 
	#if Input.is_action_just_pressed("RIGHT"):
		#Transition("PlayerWalkForward")
	#elif Input.is_action_just_pressed("LEFT"):
		#Transition("PlayerWalkBack")
	if InputParser.current_move_sequence.has("DOWN"):
			Transition("PlayerDown")


	state_transition.emit(self, "idle")
	
func Transition(newstate : String):
		state_transition.emit(self, newstate)

func _on_hurtbox_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	Transition("PlayerHit")
	pass # Replace with function body.
