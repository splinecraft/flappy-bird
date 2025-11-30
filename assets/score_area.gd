extends Area2D

signal point_scored


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(score)
	
func score(body) -> void:
	#print("+1 point") # Replace with function body.
	point_scored.emit()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
