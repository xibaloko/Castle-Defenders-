extends StaticBody2D

signal destroyedCastle

var life = 5000
var destroyed = false
var receivingDamage = false
var damageTaken

func updateLife():
	var lifeBar = get_tree().get_root().get_node("Main/CanvasLayer/Interface/HBoxContainer/CastleStats/LifeStats/CastlesLifeBar")
	lifeBar.set_value(life)

func damage():
	if life > 0:
		life -= damageTaken
	else:
		emit_signal("destroyedCastle")
		destroyed = true

func _process(_delta):
	updateLife()
	
	if receivingDamage == true and not destroyed:
		damage()
		
	if life >= 3750:
		$AnimatedSprite.play("Intact")
	elif life >= 2500:
		$AnimatedSprite.play("Deteriored")
	else:
		$AnimatedSprite.play("Destroyed")

func _on_CastleDamageArea_area_entered(area):
	if area.is_in_group("OrkEnemy1"):
		damageTaken = 5
		receivingDamage = true
	elif area.is_in_group("OrkEnemy2"):
		damageTaken = 8
		receivingDamage = true
	elif area.is_in_group("OrkEnemy3"):
		damageTaken = 12
		receivingDamage = true

func _on_CastleDamageArea_area_exited(_area):
	receivingDamage = false
