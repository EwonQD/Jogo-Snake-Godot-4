extends Node2D

var snake = []
var direction = Vector2.ZERO
var grid_size : Vector2i
var cell_size : int

signal game_over_signal

func init_snake(start_pos : Vector2):
	snake = [start_pos]
	direction = Vector2.ZERO

func set_direction(new_dir: Vector2):
	if new_dir + direction != Vector2.ZERO:
		direction = new_dir

func move_snake(food_positions : Array) -> bool:
	var new_head = snake[0] + direction
	
	if new_head.x < 0:
		new_head.x = grid_size.x - 1
	elif new_head.x >= grid_size.x:
		new_head.x = 0

	if new_head.y < 0:
		new_head.y = grid_size.y - 1
	elif new_head.y >= grid_size.y:
		new_head.y = 0

	if new_head in snake:
		emit_signal("game_over_signal")
		return false

	snake.insert(0, new_head)

	if new_head in food_positions:
		return true  # Comeu comida
	else:
		snake.pop_back()
		return false

func _draw():
	for segment in snake:
		draw_rect(Rect2(segment * cell_size, Vector2(cell_size, cell_size)), Color.GREEN)
