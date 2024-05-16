extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Game.currentScene = "res://level_1.tscn"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_backround_music_1_finished():
	$BackroundMusic1.play(0.0)
