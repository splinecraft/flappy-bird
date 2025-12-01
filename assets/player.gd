extends CharacterBody2D

@export var gravity: float = 1100.0
@export var jump_strength: float = -400.0
@export var rot_up_max: float = -20.0
@export var rot_up_tuning: float = 4.5
@export var rot_down_max: float = 60.0
@export var rot_down_tuning: float = 1.0

var rot_tuning
var target_angle
var input_enabled := true
var game_in_progress := false

@onready var start_timer: Timer = %StartTimer
@onready var player: CharacterBody2D = $"."
@onready var animation = player.get_node("AnimatedSprite2D")
@onready var game_manager = get_tree().current_scene


func _ready() -> void:
	game_in_progress = false
	
func _on_game_over() -> void:
	input_enabled = false
	animation.stop()
	game_in_progress = false

func _physics_process(delta: float) -> void:
	if not input_enabled:
		return
	
	if game_in_progress:	
		velocity.y += gravity * delta
		
		if Input.is_action_just_pressed("flap"):
			velocity.y = jump_strength
		# rotation	
		if velocity.y < 0:
			target_angle = deg_to_rad(rot_up_max)
			rot_tuning = rot_up_tuning
		else:
			target_angle = deg_to_rad(rot_down_max)
			rot_tuning = rot_down_tuning
			
		rotation = lerp_angle(rotation, target_angle, rot_tuning * delta)
		move_and_slide()
	else:
		velocity.y = 0
 
func _initial_tap() -> void:
	if not start_timer.is_stopped():
		start_timer.stop()
		game_in_progress = true
		game_manager._on_game_start()

#listen for game start from input
func _input(event: InputEvent) -> void:
	if (event is InputEventMouseButton and event.pressed) \
	or Input.is_action_just_pressed("flap"):
		_initial_tap()
		
