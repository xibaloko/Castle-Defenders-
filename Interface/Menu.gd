extends Control

func _ready():
	var bgMusic = $MenuSound
	bgMusic.play()

func _on_Start_pressed():
	get_tree().change_scene("res://Main.tscn")

func _on_Quit_pressed():
	get_tree().quit()
