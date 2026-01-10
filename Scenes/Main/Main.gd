extends Node2D


const BALL = preload("uid://c30pamb5hlfmh")
const MAIN = preload("uid://b3wbggngf6n3r")


@onready var score_label: Label = $HUD/GameUi/MC/ScoreLabel
@onready var sound: AudioStreamPlayer2D = $Sound
@onready var pause_menu: ColorRect = $HUD/GameUi/PauseMenu
@onready var paddle_2: Paddle = $Paddle2


var _score_right: int = 0
var _score_left: int = 0
var _ball_alive: bool = false
var _died_side: float = 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pause_menu.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score_label.text = "%s    %s" % [_score_left, _score_right]
	
	if _ball_alive == false:
		spawn_ball()


func spawn_ball() -> void:
	var ball: Ball = BALL.instantiate()
	ball.position = Vector2(320, 180)
	ball._start_side = _died_side
	_ball_alive = true
	add_child(ball)


func score(side: String) -> void:
	match side:
		"right":
			_score_right += 1
			_died_side = 1
		"left":
			_score_left += 1
			_died_side = -1
	_ball_alive = false
	sound.play()


func _on_score_detect_left_body_entered(body: Node2D) -> void:
	if body is Ball:
		score("right")


func _on_score_detect_right_body_entered(body: Node2D) -> void:
	if body is Ball:
		score("left")


func _on_pause_button_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		pause_menu.show()
		get_tree().paused = true
	if toggled_on == false:
		pause_menu.hide()
		get_tree().paused = false


func _on_restart_button_pressed() -> void:
	pause_menu.hide()
	get_tree().paused = false
	var _ball_reference: Ball = get_tree().get_first_node_in_group(Ball.GROUP_NAME)
	_ball_reference.call_deferred("queue_free")
	_ball_alive = false
	_score_right = 0
	_score_left = 0


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_ai_button_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		paddle_2.is_ai = true
		paddle_2.is_p2 = false
	if toggled_on == false:
		paddle_2.is_ai = false
		paddle_2.is_p2 = true
