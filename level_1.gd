extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Game.currentScene = "res://level_1.tscn"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_backround_music_1_finished():
	$BackroundMusic1.play(0.0)


	


func _on_end_of_level_body_entered(body):
	if body.get_parent().name == "Player":
		get_tree().change_scene_to_file( "res://level_2.tscn")
