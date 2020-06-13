extends Node2D


func _on_SpawnOrksPosition_AllOrksDied():
	print("Contratulation you destroyed all orks")

func _on_Castle_destroyedCastle():
	get_tree().change_scene("res://Interface/GameOver.tscn")

func _on_Player_KingsDeath():
	get_node("CanvasLayer").get_node("Message").visible = true
