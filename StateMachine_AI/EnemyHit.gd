extends State
class_name EnemyHit

@export var Player: CharacterBody2D
@export var AnimPlayer: AnimationPlayer
@export var Hurtbox_1: CollisionShape2D
@export var Hurtbox_2: CollisionShape2D
@export var Hurtbox_3: CollisionShape2D
@export var Hitbox_1: CollisionShape2D


func check_self_state(): 
	return true
	pass 

func idle_animation(): 
	AnimPlayer.play("hit_animation")

func Enter(): 
	if check_self_state() == true:
		idle_animation()

	pass

func Update(delta: float): 
	#if Input.is_action_just_pressed("RIGHT"):
		#Transition("PlayerWalkForward")
	#elif Input.is_action_just_pressed("LEFT"):
		#Transition("PlayerWalkBack")
	
	if Input.is_action_just_pressed("DOWN_P2"):
		Transition("EnemyDown")
	elif Input.is_action_just_pressed("GRAB_P2"):
		Transition("EnemyGrab")
	elif Input.is_action_just_pressed("COUNTER_P2"):
		Transition("EnemyCounter")
	else: ## nothing pressed
		state_transition.emit(self, "idle")
	
func Transition(newstate : String):
		state_transition.emit(self, newstate)


func _on_hurtbox_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	Transition("EnemyHit")
	pass # Replace with function body.
