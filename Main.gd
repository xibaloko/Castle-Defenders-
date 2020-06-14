extends Node2D

func _ready():
	var BattleSound = $MedievalBattleSound
	BattleSound.play()

func _on_SpawnOrksPosition_AllOrksDied():
	Global.stage1 = true
	get_tree().change_scene("res://Interface/CompletedStage.tscn")

func _on_Castle_destroyedCastle():
	get_tree().change_scene("res://Interface/GameOver.tscn")

func _on_Player_KingsDeath():
	get_node("CanvasLayer").get_node("Message").visible = true
