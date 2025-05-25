extends Node2D

const MOVE_TIME = 0.15

var grid_size = Vector2i(20, 20)
var cell_size = 20
var move_timer = 0.0
var game_over = false

@onready var background = $Background
@onready var snake = $Snake
@onready var food_manager = $FoodManager
@onready var ui = $UI
@onready var music_player = $AudioPlayer

func _ready():
	randomize()
	var screen_size = get_viewport_rect().size
	cell_size = floor(min(screen_size.x / grid_size.x, screen_size.y / grid_size.y))
	grid_size = Vector2i(screen_size / cell_size)

	background.grid_size = grid_size
	background.cell_size = cell_size
	background.queue_redraw()

	var start_pos = Vector2(floor(grid_size.x / 2), grid_size.y - 2)
	snake.grid_size = grid_size
	snake.cell_size = cell_size
	snake.init_snake(start_pos)
	snake.connect("game_over_signal", Callable(self, "_game_over"))

	food_manager.grid_size = grid_size
	food_manager.cell_size = cell_size
	food_manager.spawn_food_matrix(snake.snake)

	ui.connect("direction_changed", Callable(self, "_set_direction"))
	ui.connect("restart_requested", Callable(self, "_restart_game"))
	ui._create_touch_controls()

	music_player.stream = preload("res://audio/loopgame.ogg")
	music_player.play()

	set_process(true)

func _process(delta):
	if game_over:
		return
	move_timer += delta
	if move_timer >= MOVE_TIME:
		move_timer = 0
		var ate_food = snake.move_snake(food_manager.food_positions)
		if ate_food:
			food_manager.food_positions.erase(snake.snake[0])
			food_manager.queue_redraw()  # redesenha a cena

func _set_direction(new_dir: Vector2):
	snake.set_direction(new_dir)

func _game_over():
	# Para a música de fundo — só aqui na finalização do jogo
	$AudioPlayer.stop()
	# Toca o som de game over só agora, na hora do game over
	$GameOverSound.play()
	# Aguarda 4 segundos para que o som toque e o jogador veja o game over
	await get_tree().create_timer(4.0).timeout
	# Volta para o menu inicial
	get_tree().change_scene_to_file("res://MainMenu.tscn")

func _restart_game():
	game_over = false
	move_timer = 0
	var start_pos = Vector2(floor(grid_size.x / 2), grid_size.y - 2)
	snake.init_snake(start_pos)
	food_manager.spawn_food_matrix(snake.snake)
	set_process(true)
	queue_redraw()
