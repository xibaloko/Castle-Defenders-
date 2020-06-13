extends Node2D


func _on_SpawnOrksPosition_AllOrksDied():
	print("Contratulation you destroyed all orks")

func _on_Castle_destroyedCastle():
	print("Game Over")

func _on_Player_KingsDeath():
	print("Game Over")
