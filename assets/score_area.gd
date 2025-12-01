extends Area2D

signal point_scored

func _ready() -> void:
	body_entered.connect(score)
	
func score(body) -> void:
	emit_signal("point_scored")
	
	
