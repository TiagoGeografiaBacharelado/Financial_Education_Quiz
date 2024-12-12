extends Control  # Substitua por Container, Control, etc., dependendo do nó raiz

# Chamado quando o botão "Play" é pressionado
func on_play_button_pressed():
	# Mude para a cena do jogo
	get_tree().change_scene_to_file("res://scenes/main.tscn")

# Chamado quando o botão "Créditos" é pressionado
func _on_creditos_pressed():
	# Mude para a cena de créditos ou exiba os créditos
	get_tree().change_scene_to_file("res://scenes/creditos.tscn")
# Chamado quando o botão "Sair" é pressionado
func _on_sair_pressed():
	get_tree().quit()
