extends Node2D

var food_positions = []
var grid_size : Vector2i
var cell_size : int

var bolinhas_textures: Array[Texture2D] = []

func _ready():
	load_bolinhas()
	# Exemplo de chamada com uma lista de posições da cobra
	spawn_food_matrix([])

func load_bolinhas():
	var dir = DirAccess.open("res://visual/alphabet_circles/")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir() and file_name.ends_with(".png"):
				var texture = load("res://visual/alphabet_circles/" + file_name)
				bolinhas_textures.append(texture)
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		print("Erro ao abrir pasta de bolinhas")

func spawn_food_matrix(snake_positions : Array):
	# Limpa posições e bolinhas antigas
	food_positions.clear()
	for c in get_children():
		if c.name.begins_with("Bola"):
			remove_child(c)
			c.queue_free()

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
				spawn_food_sprite(pos)

# Variável global para armazenar a matriz de letras (declare fora da função)
var matriz_letras := []

func spawn_food_sprite(grid_pos: Vector2):
	if bolinhas_textures.is_empty():
		return

	# Inicializa a matriz se ainda não tiver sido criada
	var x = int(grid_pos.x)
	var y = int(grid_pos.y)

	# Garante que haja linhas suficientes na matriz
	while matriz_letras.size() <= y:
		matriz_letras.append([])
	# Garante que haja colunas suficientes na linha atual
	while matriz_letras[y].size() <= x:
		matriz_letras[y].append("")

	# Cria o sprite
	var sprite = Sprite2D.new()
	sprite.scale = Vector2(0.2, 0.2)

	var tex = bolinhas_textures.pick_random()
	sprite.texture = tex
	sprite.position = grid_pos * cell_size + Vector2(cell_size / 2, cell_size / 2)
	sprite.name = "Bola_%s_%s" % [grid_pos.x, grid_pos.y]
	add_child(sprite)

	# Extrai a primeira letra do nome do arquivo
	var path = tex.resource_path
	var filename = path.get_file()
	var letra = filename.substr(0, 1).to_upper()

	# Armazena a letra na matriz
	matriz_letras[y][x] = letra

	# (Opcional) Printa a matriz no console
	print("Matriz de letras:")
	for linha in matriz_letras:
		print(linha)
