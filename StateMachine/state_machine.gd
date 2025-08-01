extends Node
class_name FiniteStateMachine

var states : Dictionary = {}

@export var initial_state : State
var current_state : State

#func init() -> void: change_state(starting_state)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is State: 
			states[child.name.to_lower()] = child
			child.state_transition.connect(change_state)
	if initial_state:
		initial_state.Enter()
		current_state = initial_state

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current_state: 
		current_state.Update(delta)

func change_state(source_state: State, new_state_name: String) -> void:
	if source_state != current_state:
		#print("Invalid change_state trying from: " + source_state.name + " but currently in: " + current_state.name)
		return

	var new_state = states.get(new_state_name.to_lower())
	if new_state == null:
		#print("Tried to change to invalid or non-existent state: " + new_state_name)
		return

	# Avoid redundant transitions to the same state
	if new_state == current_state:
		#print("Already in state:", new_state_name)
		return

	# Perform the transition
	current_state.Exit()
	new_state.Enter()
	current_state = new_state


func force_change_state(new_state : String):
	var newState = states.get(new_state.to_lower())
	
	if !newState:
		#print(new_state + " does not exist in the dictionary of states")
		return
	
	if current_state == newState:
		#print("State is same, aborting")
		return
		
	#NOTE Calling exit like so: (current_state.Exit()) may cause warnings when flushing queries, like when the enemy is being removed after death. 
	#call_deferred is safe and prevents this from occuring. We get the Exit function from the state as a callable and then call it in a thread-safe manner
	if current_state:
		var exit_callable = Callable(current_state, "Exit")
		exit_callable.call_deferred()
	
	newState.Enter()
	
	current_state = newState
