extends Control


@onready var game_over: Control = %GameOver
@onready var high_score_display: RichTextLabel = %HighScoreDisplay
@onready var score_label: RichTextLabel = %ScoreLabel
@onready var start_banner: Sprite2D = %StartBanner
@onready var dead: Sprite2D = %Dead



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	high_score_display.text = str(GlobalScore.high_score)
	
func _on_game_start():
	game_over.hide()
	

func _on_game_ready():
	dead.hide()
	start_banner.show()

func _score_update(score) -> void:
	score_label.text = str(score)
	
func _on_game_over() -> void:
	game_over.show()
	start_banner.hide()
	dead.show()
	high_score_display.text = str(GlobalScore.high_score)
