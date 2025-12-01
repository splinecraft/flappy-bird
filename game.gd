extends Node2D

@onready var pipe_reset_area: Area2D = %PipeResetArea
@onready var pipe_spawn_timer: Timer = $PipeSpawnTimer
@onready var restart_timer: Timer = $RestartTimer
@onready var music_player: AudioStreamPlayer = $MusicPlayer
@onready var goal_audio: AudioStreamPlayer2D = $GoalAudio
@onready var score: int = 0

@export var player: Node
@export var ui: Node
@export var killzone: Node

var pipe_scene = preload("res://assets/pipe.tscn")

const FLAPPY_BIRD_MUSIC = preload("uid://dto0cd8goppg0")
const FLAPPY_BIRD_GAME_OVER = preload("uid://d4cos2s73meq1")


func _ready() -> void:
	pipe_reset_area.area_entered.connect(_remove_pipe)
	pipe_spawn_timer.timeout.connect(_spawn_pipe)
	killzone.connect("game_over", _on_game_over, 0)
	ui._on_game_ready()
			
func _score() -> void:
	goal_audio.play()
	score += 1
	if ui.has_method("_score_update"):
		ui._score_update(score)

func _on_game_start() -> void:
	pipe_spawn_timer.start()
	ui._on_game_start()		

func _on_game_over() -> void:
	if player and player.has_method("_on_game_over"):
		player._on_game_over()
	var obstacle_nodes = get_tree().get_nodes_in_group("obstacles")
	for node in obstacle_nodes:
		if node.has_method("_on_game_over"):
			node._on_game_over()
	pipe_spawn_timer.stop()
	restart_timer.start()
	music_player.stream = FLAPPY_BIRD_GAME_OVER
	music_player.volume_db = -8.0
	music_player.play()
	
	if ui and ui.has_method("_on_game_over"):
		if GlobalScore.high_score < score:
			GlobalScore.high_score = score
		ui._on_game_over()
	
func _process(delta: float) -> void:
	pass

func _spawn_pipe() -> void:
	var random_height = randf_range(-150.0, 150.0)
	var pipe_instance = pipe_scene.instantiate()
	add_child(pipe_instance)
	pipe_instance.global_position = Vector2(600, random_height)
	var score_area = pipe_instance.get_node("ScoreArea2D")
	score_area.connect("point_scored", _score)
	pipe_instance.connect("game_over", _on_game_over)

func _remove_pipe(pipe) -> void:
	pipe.queue_free()

func _on_restart_timer_timeout() -> void:
	get_tree().reload_current_scene() # Replace with function body.
