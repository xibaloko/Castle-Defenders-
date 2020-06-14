extends Control

func _ready():
	var bgMusic = $VictoryBgSound
	bgMusic.play()

func _on_Continue_pressed():
	if Global.stage1:
		get_tree().change_scene("res://Stages/Stage2.tscn")
