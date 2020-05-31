extends StaticBody2D

var life = 5000
var receivingDamage = false
var damageTaken

func updateLife():
	var lifeBar = get_tree().get_root().get_node("Main").get_node("CanvasLayer").get_node("Interface").get_node("HBoxContainer").get_node("CastleStats").get_node("CastlesLifeBar")
	lifeBar.set_value(life)

func damage():
	life -= damageTaken

func _process(delta):
	updateLife()
	
	if receivingDamage == true:
		damage()
		
	if life >= 3750:
		$AnimatedSprite.play("Intact")
	elif life >= 2500:
		$AnimatedSprite.play("Deteriored")
	else:
		$AnimatedSprite.play("Destroyed")

func _on_CastleDamageArea_area_entered(area):
	var collider = area.get_parent()
	
	if collider.name == "OrkEnemy1":
		damageTaken = 10
		receivingDamage = true

func _on_CastleDamageArea_area_exited(area):
	receivingDamage = false
