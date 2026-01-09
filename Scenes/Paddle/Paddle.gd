extends CharacterBody2D


class_name Paddle


@export var is_ai: bool
@export var is_p2: bool


const SPEED: float = 180.0


var _ai_max_speed: float = 180.0
var _ball_reference: Ball


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_ball_reference = get_tree().get_first_node_in_group(Ball.GROUP_NAME)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	update_movement()


# Controls Movement
func update_movement() -> void:
	velocity.y = SPEED * get_input()
	move_and_slide()


func ai_movement_dir() -> float:
	if _ball_reference.global_position.y > global_position.y:
		return 1
	if _ball_reference.global_position.y < global_position.y:
		return -1
	else:
		return 0


# Gets input for movement up or down
func get_input() -> float:
	if is_ai == false and is_p2 == false:
		return Input.get_axis("up", "down")
	elif is_p2 == true:
		return Input.get_axis("ui_up", "ui_down")
	elif _ball_reference:
		return ai_movement_dir()
	else:
		return 0
