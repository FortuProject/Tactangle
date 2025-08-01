extends Node

var is_busy := false
var current_move := ""
var cancelable_moves := ["jab", "qcf", "dash_button_grab"]

enum CombatState {  
	## Neutral & Movement  
	BOW, 
	NONE,               ## Default state (pre-match, post-round)  
	IDLE,               ## Standing neutral, no inputs  
	ADVANCING,          ## Walking forward  
	RETREATING,         ## Walking backward  
	DASHING,            ## Quick forward dash  
	BACKSTEP,           ## Quick backward evade  
	FOOTWORK_FEINT,     ## Fake forward step (baiting a reaction) 
	
	## Motion inputs
	QUATER_CIRCLE_FORWARD, ## QCF
	QUATER_CIRCLE_BACKWARD, ##QCB
	CHARGE_FORWARD, ## Charge a special move 
	CHARGE_DOWN, ## Charge down 
	CHARGE_BACKWARD, ## Charge a special move backward
	CHARGE_UP, ## Charge a special move up 
	DOUBLE_TAP_FORWARD, ## Dashing? 
	DOUBLE_TAP_BACK, ## Backstep? 
	DOUBLE_QUATER_CIRCLE_FORWARD, ## DQCF
	DOUBLE_QUATER_CIRCLE_BACKWARD, ## DQCB
	
	## Grip Phase  
	GRIP_ATTEMPT,       ## A button pressed, but not yet connected  
	GRIP_SUCCESS,       ## Successfully gripped opponent (lapel/sleeve/etc.)  
	GRIP_STRUGGLE,      ## Both players gripping each other (clash)  
	GRIP_STRIP,         ## Successfully stripped opponent’s grip (D+A)  
	COUNTER_GRIP,       ## Opponent tried to grip but was countered (D on startup)  
	GRIP_FEINT,         ## Fakes a grip for reaction 

	## Kuzushi Phase  
	KUZUSHI_ATTEMPT,    ## B button pressed, but not yet applied  
	KUZUSHI_SUCCESS,    ## Opponent is off-balance (direction-based)  
	KUZUSHI_RESIST,     ## Opponent is resisting kuzushi (tug-of-war)  
	COUNTER_KUZUSHI,    ## Opponent reversed kuzushi (D+B)  
	PUSHED,             ## Staggered from raw kuzushi (no grip)  

	## Throw Phase  
	THROW_ATTEMPT,      ## C button pressed, startup frames  
	THROW_EXECUTING,    ## Throw in progress (needs kuzushi)  
	THROW_TECH,         ## Opponent is teching the throw (late counter)  
	COUNTER_THROW,      ## Throw was countered (D+C)  
	BEING_THROWN,       ## In throw animation (before ippon)  
	THROW_FEINT,        ## Fake a throw animation 

	## Specials & Autocombos  
	GRIP_AUTOCOMBO,     ## A→A→A (tightening control)  
	KUZUSHI_AUTOCOMBO,  ## B→B→B (chain off-balances)  
	SUPER_THROW,        ## C→C→C (cinematic throw)  
	ULTRA_INSTINCT,     ## D→D→D (3-second counter mode)  
	CHARGE,             ## Charges meter 

	## Resolution States  
	IPPON,              ## Successful throw (round end)  
	LOSS,               ## Was thrown (round end)  
	STUNNED,            ## Temporary freeze (failed counter)  
	GROUNDED,           ## Post-throw recovery (if game allows resets)  
	RECOVERY,           ## Recovery
}  



func _on_special_move(move_name: String) -> void:
	if is_busy and current_move not in cancelable_moves:
		print("Can't cancel current move:", current_move)
		return

	start_move(move_name)

func start_move(move_name: String):
	is_busy = true
	current_move = move_name
	print("Executing move:", move_name)

func apply_state(): 
	pass

func apply_damage():
	print("Hit landed! Applying damage.")
	# Implement your damage system here

func end_move():
	is_busy = false
	current_move = ""
	print("Move finished.")
