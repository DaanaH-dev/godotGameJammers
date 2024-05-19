extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Game.currentScene = "res://level_3.tscn"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_backround_music_1_finished():
	$BackroundMusic1.play(0.0)


	


func _on_end_of_level_body_entered(body):
	#Game.currentScene = "res://level_2.tscn"
	if body.get_parent().name == "Player":
		Game.currentScene = "res://level_4.tscn"
		print("End of lvl: ", " ", Game.currentScene)
		get_tree().change_scene_to_file( "res://level_4.tscn")
