extends Button





func _on_pressed():
	Game.currentScene = "res://level_1.tscn"
	get_tree().change_scene_to_file(Game.currentScene)
