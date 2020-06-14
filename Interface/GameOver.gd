extends Control

func _ready():
	var bgMusic = $GameOverMusic
	bgMusic.play()

func _on_Return_pressed():
	Global.resetStages()
	get_tree().change_scene("res://Interface/Menu.tscn")
