extends Node2D

var food_positions = []
var grid_size : Vector2i
var cell_size : int

func spawn_food_matrix(snake_positions : Array):
	food_positions.clear()
	var rows = 4
	var cols = 8
	var start_x = 2
	var start_y = 2
	var spacing_x = 4
	var spacing_y = 4
	
	for i in range(rows):
		for j in range(cols):
			var pos = Vector2(start_x + j * spacing_x, start_y + i * spacing_y)
			if pos not in snake_positions and pos.x < grid_size.x and pos.y < grid_size.y:
				food_positions.append(pos)

func _draw():
	for food_pos in food_positions:
		var center = food_pos * cell_size + Vector2(cell_size / 2, cell_size / 2)
		var radius = cell_size / 1.75
		draw_circle(center, radius, Color.RED)
