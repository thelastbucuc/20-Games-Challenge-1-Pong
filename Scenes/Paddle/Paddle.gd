extends CharacterBody2D


class_name Paddle


@export var is_ai: bool
@export var is_p2: bool


const PLAYER_SPEED: float = 200.0


var _ai_max_speed: float = 300.0
var _ball_reference: Ball


func _process(delta: float) -> void:
	_ball_reference = get_tree().get_first_node_in_group(Ball.GROUP_NAME)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	#update_movement(delta)
	if is_ai and _ball_reference:
		global_position.y = lerp(global_position.y,_ball_reference.global_position.y , 0.1)
	else:
		velocity.y = PLAYER_SPEED * get_input()
	move_and_slide()


# Controls Movement
func update_movement(delta: float) -> void:
	if is_ai and _ball_reference:
		velocity.y = move_toward(velocity.y, _ai_max_speed, delta) * ai_movement_dir()
	else:
		velocity.y = PLAYER_SPEED * get_input()
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
	if is_p2 == false:
		return Input.get_axis("up", "down")
	else:
		return Input.get_axis("ui_up", "ui_down")
