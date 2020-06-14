extends Control

func _ready():
	var bgMusic = $VictoryMusicBg
	bgMusic.play()

func _on_Return_pressed():
	get_tree().change_scene("res://Interface/Menu.tscn")

func _on_Quit_pressed():
	get_tree().quit()
