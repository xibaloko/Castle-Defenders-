extends StaticBody2D

var life = 1000

func updateLife():
	var lifeBar = get_tree().get_root().get_node("Main").get_node("CanvasLayer").get_node("Interface").get_node("HBoxContainer").get_node("CastleStats").get_node("CastlesLifeBar")
	lifeBar.set_value(life)

func damage():
	life -= 100

func _process(delta):
	updateLife()
