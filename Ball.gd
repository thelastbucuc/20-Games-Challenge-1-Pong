extends CharacterBody2D


class_name Ball


const SPEED_MULT: float = 1.022


@onready var debug_label: Label = $DebugLabel
@onready var sound: AudioStreamPlayer2D = $Sound


var _speed = 400
var _start_side: float


func _ready() -> void:
	var rand_y: float = randf_range(-1, 1)
	velocity = Vector2(_start_side, rand_y).normalized() * _speed


func _physics_process(delta) -> void:
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		var collider = collision_info.get_collider()
		if "Paddle" in collider.name:
			var bounce_angle = (global_position.y - collider.global_position.y) / (collider.get_node("CollisionShape2D").shape.get_rect().size.y / 2)
			bounce_angle *= 0.8
			var new_direction = Vector2(-velocity.normalized().x, bounce_angle).normalized()
			velocity = new_direction * _speed
		else:
			velocity = velocity.bounce(collision_info.get_normal())
		velocity *= SPEED_MULT
		sound.play()
	debug_label.text = "%s" % velocity


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	call_deferred("queue_free")
