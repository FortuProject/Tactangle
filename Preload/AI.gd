extends Node
# Big turn runner script, runs the whole turn. Supersceedes newturn
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func BestMove(CurrentMove): 
	if CurrentMove == "idle": 
		return "grab" 
	elif CurrentMove == "grab": 
		return "kuzushi"
	elif CurrentMove == "EnemyKuzushi":
		return "throw"
	elif CurrentMove == "EnemyThrow":
		return "bow"
	elif CurrentMove == "EnemyBow":
		return "idle"
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
