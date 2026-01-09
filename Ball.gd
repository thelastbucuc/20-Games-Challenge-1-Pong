extends CharacterBody2D


class_name Ball


const SPEED_MULT: float = 1.022


@onready var debug_label: Label = $DebugLabel
@onready var sound: AudioStreamPlayer2D = $Sound


var _speed = 400
var _start_velocity = Vector2(1, 1).normalized() * _speed


func _ready() -> void:
	velocity = _start_velocity


func _physics_process(delta) -> void:
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
		velocity *= SPEED_MULT
		sound.play()
	debug_label.text = "%s" % velocity


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	call_deferred("queue_free")
