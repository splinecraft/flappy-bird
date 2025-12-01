extends Area2D

signal game_over

var speed := 250.0


func _process(delta: float) -> void:
		position.x -= speed * delta
	
func _on_game_over() -> void:
	speed = 0
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		emit_signal("game_over")

func _on_score_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("+1 point")
