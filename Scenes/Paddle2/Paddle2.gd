extends Paddle


func get_input() -> float:
	return Input.get_axis("ui_up", "ui_down")
