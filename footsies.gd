extends Node2D

## Tactangle, a 2d judo fighting game simulator 
@onready var Ground_Player = $Floor_Markers/Ground_Player
@onready var Ground_Enemy = $Floor_Markers/Ground_Enemy

#@onready var current_state = CombatInterperter.CombatState.IDLE

#@onready var player_state = CombatInterperter.CombatState.NONE
#@onready var enemy_state= CombatInterperter.CombatState.NONE

@onready var current_animation = ""
@onready var waiting_for_animation = false
#@onready var previous_state = CombatInterperter.CombatState.NONE

## Functions 

func _process(delta: float) -> void:
	# Every frame, try to interpret what the current input is. 
	# Probably should track previous input too, to see if the previous 
	# can become the current at all. 
	#var previous_state = CombatInterperter.previous_state()
	#var interpreted_state = CombatInterperter.interpret_input()
	
	# Check if state changed and is valid
	#if interpreted_state != player_state and InputParser.can_transition(player_state, interpreted_state):
	#	CombatInterperter.update_state_history(player_state)
	#	player_state = interpreted_state
	#	process_player_state(delta)
	#process_enemy_state(delta)
	pass


func _ready() -> void:
	Global.Buttons_Disabled = true
	bow_animation()
	Global.Buttons_Disabled = false
## MOVEMENT AND GAME LOGIC 

#func process_enemy_state(delta):
	#match enemy_state:
		#CombatState.IDLE:
			## AI decision logic
			#enemy_state = choose_enemy_action()
		#CombatState.GRABBING:
			#play_animation("enemy_grab")
			#if player_state == CombatState.GRIP_STRIP:
				#enemy_state = CombatState.COUNTER_GRIP


#func play_animations(): 
	##play_sfx("Bell")
	#Buttons_Disabled = true
	#print("Playing animation")
	## Get what Confirmlock1 and ConfirmLock2 are so I can
	## Determine what moves are first - last. 
	## Determine who is offense and who is defense. 
	## Change 
	#var i = 0
	#while i < 10: 
		#Player_Grappler.frame += 1 
		#Enemy_Grappler.frame += 1 
		## Wait half a second. 
		#await get_tree().create_timer(0.1).timeout  # Wait half a second
#
		#i += 1
	#
	#_start_new_turn_UI()
	#Buttons_Disabled = false
	

func bow_animation(): 
	Global.Buttons_Disabled = true
	#print("Playing bow animation")
	# Get what Confirmlock1 and ConfirmLock2 are so I can
	# Determine what moves are first - last. 
	# Determine who is offense and who is defense. 
	# Change 
	
	# bow down
	var i = 39
	while i < 45: 
		#Enemy_Grappler.frame = i
		# Wait half a second. 
		await get_tree().create_timer(0.1).timeout  # Wait half a second

		i += 1
	
	# bow up 
	i = 45
	while i > 39: 
		#Enemy_Grappler.frame = i
		# Wait half a second. 
		await get_tree().create_timer(0.1).timeout  # Wait half a second

		i -= 1
	
	#_start_new_turn_UI()
	Global.Buttons_Disabled = false
	#Enemy_Grappler.frame = 0



## If then statements, interactions 

# Fix idle, probably map a proper flow chart and gates to prevent animation clipping. measure frames.  
# If grip hits, establish a grip on the UI, and don't return to idle, 
# If a grip is established, you can change the location of the grip by pushing up and down. 
# If a grip is established, movement options for the opponent are limited. 
# Grip button (1, A) is a set-up move. Offensive. 

# Kuzushi is a push, 
#func process_player_state(delta):
	#match player_state:
		#CombatInterperter.CombatState.NONE: 
			##print("None entered")
			#handle_idle_input()
		#CombatInterperter.CombatState.IDLE:
			##print("idle entered")
			#play_animation("idle")
			#handle_idle_input()
		#CombatInterperter.CombatState.ADVANCING:
			#print("Forward entered")
			#move_player("Forward")
			#play_animation("move")
		#CombatInterperter.CombatState.RETREATING:
			#move_player("Backwards")
			#play_animation("move_back")
		#CombatInterperter.CombatState.GRIP_ATTEMPT:
			#check_grip_success()
			#play_animation("grab")
		#CombatInterperter.CombatState.KUZUSHI_ATTEMPT:
			#check_balance_shift()
			#play_animation("kuzushi")
		#CombatInterperter.CombatState.THROW_ATTEMPT:
			#apply_throw_effect()
			#play_animation("throw")
		#CombatInterperter.CombatState.IPPON:
			#end_game(true)
			#play_animation("ippon")
		#CombatInterperter.CombatState.COUNTER_GRIP:
			#counter_effect()
			#play_animation("counter")
		#CombatInterperter.CombatState.RECOVERY:
			#recovery_effect()
#
#func process_enemy_state(delta):
	#match enemy_state:
		#CombatInterperter.CombatState.IDLE:
			## AI decision logic
			#enemy_state = choose_enemy_action()
		#CombatInterperter.CombatState.GRIP_ATTEMPT:
			#play_animation("enemy_grab")
			#if player_state == CombatInterperter.CombatState.GRIP_STRIP:
				#enemy_state = CombatInterperter.CombatState.COUNTER_GRIP
#
#func handle_idle_input():
	#if Global.Buttons_Disabled == true:
		##print("Buttons disabled")
		#pass
	#else:
		#if Input.is_action_just_pressed("move_right"):
			#player_state = CombatInterperter.CombatState.ADVANCING
		#elif Input.is_action_just_pressed("move_left"):
			#player_state = CombatInterperter.CombatState.RETREATING
		#elif Input.is_action_just_pressed("grab"):
			#player_state = CombatInterperter.CombatState.GRIP_ATTEMPT
		#elif Input.is_action_just_pressed("kuzushi"):
			#player_state = CombatInterperter.CombatState.KUZUSHI_ATTEMPT
		#elif Input.is_action_just_pressed("throw"):
			#player_state = CombatInterperter.CombatState.THROW_ATTEMPT
		#elif Input.is_action_just_pressed("counter"):
			#player_state = CombatInterperter.CombatState.COUNTER_GRIP
		#elif Input.is_action_pressed("move_right"):
			#player_state = CombatInterperter.CombatState.ADVANCING
		#elif Input.is_action_pressed("move_left"):
			#player_state = CombatInterperter.CombatState.RETREATING

func play_animation(AnimationName):
	if current_animation == AnimationName:
		return

	current_animation = AnimationName
	
	if AnimationName == "move": 
		walk_animation(0)
	elif AnimationName == "move_back":
		walk_back_animation(0)
	elif AnimationName == "grab":
		grab_animation(0)
	elif AnimationName == "kuzushi":
		kuzushi_animation(0)
	elif AnimationName == "throw":
		throw_animation(0)
	elif AnimationName == "counter":
		counter_animation(0)
	elif AnimationName == "idle": 
		idle_animation(0) 
	

func move_player(Type):
	#if Player_Grappler.position.x < 92: 
	#	Player_Grappler.position.x = 92
	#elif Player_Grappler.position.x > 797:
	#	Player_Grappler.position.x = 797
	#else: 
		#if Type == "Forward":  
			#Player_Grappler.position.x = Player_Grappler.position.x + 50
		#elif Type == "Backwards": 
			#Player_Grappler.position.x = Player_Grappler.position.x - 50
		#pass 
		#player_state = CombatInterperter.CombatState.IDLE
	pass
#
#func check_grip_success(): 
	#player_state = CombatInterperter.CombatState.IDLE
#
#
#func check_balance_shift():
	#player_state = CombatInterperter.CombatState.IDLE
#
#func apply_throw_effect(): 
	#player_state = CombatInterperter.CombatState.IDLE
#
#func counter_effect(): 
	#player_state = CombatInterperter.CombatState.IDLE

func end_game(TF):
	#player_state = CombatState.IDLE
	pass
#
#func recovery_effect():
	#await get_tree().create_timer(0.5).timeout
	#set_to_idle()
	#
	#
#func set_to_idle(): 
	#player_state = CombatInterperter.CombatState.IDLE

func choose_enemy_action(): 
	#player_state = CombatState.IDLE
	return


func walk_animation(WhichPlayer):
	Global.Buttons_Disabled = true
	print("Playing walk animation")
	# Get what Confirmlock1 and ConfirmLock2 are so I can
	# Determine what moves are first - last. 
	# Determine who is offense and who is defense. 
	# Change 
	if WhichPlayer == 0: 
		var i = 1
		while i < 16: 
			#Player_Grappler.frame = i 
			# Wait half a second. 
			await get_tree().create_timer(0.01).timeout  # Wait half a second

			i += 1
	else: 
		var i = 1
		while i < 16: 
			#Enemy_Grappler.frame = i
			# Wait half a second. 
			await get_tree().create_timer(0.01).timeout  # Wait half a second
			i += 1
	Global.Buttons_Disabled = false

func walk_back_animation(WhichPlayer): 
	Global.Buttons_Disabled = true
	print("Playing walk back animation")
	# Get what Confirmlock1 and ConfirmLock2 are so I can
	# Determine what moves are first - last. 
	# Determine who is offense and who is defense. 
	# Change 
	if WhichPlayer == 0: 
		var i = 17
		while i < 32: 
			#Player_Grappler.frame = i 
			# Wait half a second. 
			await get_tree().create_timer(0.01).timeout  # Wait half a second

			i += 1
	else: 
		var i = 17
		while i < 32: 
			#Enemy_Grappler.frame = i
			# Wait half a second. 
			await get_tree().create_timer(0.01).timeout  # Wait half a second
			i += 1
	Global.Buttons_Disabled = false
	
func grab_animation(WhichPlayer): 
	Global.Buttons_Disabled = true
	print("Playing grab animation")
	#if Player_Grappler == null:
		#print("no player grappler assigned yet")
		#return
	#elif Enemy_Grappler == null:
		#print("no enemy grappler assigned yet")
		#return
	#
	if WhichPlayer == 0: 
		var i = 97
		while i < 104: 
			#Player_Grappler.frame = i
			await get_tree().create_timer(0.05).timeout
			i += 1
	else: 
		var i = 97
		while i < 104: 
			#Enemy_Grappler.frame = i
			await get_tree().create_timer(0.05).timeout
			i += 1

	Global.Buttons_Disabled = false
	
func kuzushi_animation(WhichPlayer):
	Global.Buttons_Disabled = true
	print("Playing kuzushi animation")

	if WhichPlayer == 0: 
		var i = 115
		while i < 122: 
			#Player_Grappler.frame = i 
			await get_tree().create_timer(0.05).timeout
			i += 1
	else: 
		var i = 115
		while i < 122: 
			#Enemy_Grappler.frame = i
			await get_tree().create_timer(0.05).timeout
			i += 1

	Global.Buttons_Disabled = false

func throw_animation(WhichPlayer): 
	Global.Buttons_Disabled = true
	print("Playing throw animation")

	if WhichPlayer == 0: 
		var i = 84
		while i < 96: 
			#Player_Grappler.frame = i 
			await get_tree().create_timer(0.05).timeout
			i += 1
	else: 
		var i = 84
		while i < 96: 
			#Enemy_Grappler.frame = i
			await get_tree().create_timer(0.05).timeout
			i += 1

	Global.Buttons_Disabled = false 

func counter_animation(WhichPlayer):
	Global.Buttons_Disabled = true
	print("Playing throw animation")

	if WhichPlayer == 0: 
		var i = 76
		while i < 80: 
			#Player_Grappler.frame = i 
			await get_tree().create_timer(0.05).timeout
			i += 1
	else: 
		var i = 76
		while i < 80: 
			#Enemy_Grappler.frame = i
			await get_tree().create_timer(0.05).timeout
			i += 1

	Global.Buttons_Disabled = false 

func idle_animation(WhichPlayer):
	print("Playing idle animation")
	# Get what Confirmlock1 and ConfirmLock2 are so I can
	# Determine what moves are first - last. 
	# Determine who is offense and who is defense. 
	# Change 
	if WhichPlayer == 0:
		var i = 1
		while i < 16: 
			#Player_Grappler.frame = 0
			await get_tree().create_timer(0.05).timeout
			i += 1
	else: 
		var i = 1
		while i < 16: 
			#Enemy_Grappler.frame = 0
			await get_tree().create_timer(0.05).timeout
			i += 1
	#Reset state 
	#player_state = CombatInterperter.CombatState.NONE
