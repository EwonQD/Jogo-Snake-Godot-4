extends Control

func _ready():
	visible = false

func show_game_over():
	# Para a música de fundo — só aqui na finalização do jogo
	$AudioPlayer.stop()
	# Toca o som de game over só agora, na hora do game over
	$GameOverSound.play()
	# Aguarda 4 segundos para que o som toque e o jogador veja o game over
	await get_tree().create_timer(4.0).timeout
	# Volta para o menu inicial
	get_tree().change_scene_to_file("res://MainMenu.tscn")
