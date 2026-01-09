extends Node2D


const BALL = preload("uid://c30pamb5hlfmh")


@onready var score_label: Label = $UI/MC/ScoreLabel
@onready var sound: AudioStreamPlayer2D = $Sound


var _score_right: int = 0
var _score_left: int = 0
var _ball_alive: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_ball()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score_label.text = "%s    %s" % [_score_left, _score_right]
	
	if _ball_alive == false:
		spawn_ball()


func spawn_ball() -> void:
	var ball: Ball = BALL.instantiate()
	ball.position = Vector2(320, 180)
	_ball_alive = true
	add_child(ball)


func score(side: String) -> void:
	match side:
		"right":
			_score_right += 1
		"left":
			_score_left += 1
	_ball_alive = false
	sound.play()


func _on_score_detect_left_body_entered(body: Node2D) -> void:
	if body is Ball:
		score("right")


func _on_score_detect_right_body_entered(body: Node2D) -> void:
	if body is Ball:
		score("left")
