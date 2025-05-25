extends Node2D

var background_texture : Texture2D = preload("res://visual/sala.png")
var grid_size : Vector2i
var cell_size : int

func _draw():
	if background_texture:
		draw_texture_rect(background_texture, Rect2(Vector2.ZERO, Vector2(grid_size) * cell_size), false)
