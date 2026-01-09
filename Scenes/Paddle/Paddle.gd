extends CharacterBody2D


class_name Paddle


const SPEED: float = 180.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	update_movement()


# Controls Movement
func update_movement() -> void:
	velocity.y = SPEED * get_input()
	move_and_slide()


# Gets input for movement up or down
func get_input() -> float:
	return Input.get_axis("up", "down")
