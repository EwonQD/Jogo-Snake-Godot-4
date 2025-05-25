extends CanvasLayer

signal direction_changed(new_direction)

func _ready():
	_create_touch_controls()

func _create_touch_controls():
	$DPad/UpButton.pressed.connect(_on_up_pressed)
	$DPad/DownButton.pressed.connect(_on_down_pressed)
	$DPad/LeftButton.pressed.connect(_on_left_pressed)
	$DPad/RightButton.pressed.connect(_on_right_pressed)

func _on_up_pressed():
	emit_signal("direction_changed", Vector2.UP)

func _on_down_pressed():
	emit_signal("direction_changed", Vector2.DOWN)

func _on_left_pressed():
	emit_signal("direction_changed", Vector2.LEFT)

func _on_right_pressed():
	emit_signal("direction_changed", Vector2.RIGHT)
