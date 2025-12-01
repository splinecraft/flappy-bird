extends Area2D

signal game_over

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		emit_signal("game_over")
		print("killzone")
