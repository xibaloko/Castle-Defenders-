extends Control

func _ready():
	var bgMusic = $VictoryBgSound
	bgMusic.play()

func _on_Continue_pressed():
	if Global.stage1:
		Global.stage1 = false
		get_tree().change_scene("res://Stages/Stage2.tscn")
	elif Global.stage2:
		Global.stage2 = false
		get_tree().change_scene("res://Stages/Stage3.tscn")
	elif Global.stage3:
		Global.stage3 = false
		get_tree().change_scene("res://Interface/Victory.tscn")
