extends Position2D

onready var troopReference = load ("res://Skills/Call Troops/Troop.tscn")

func _on_Player_CallTroops():
	var troopInstance1 = troopReference.instance()
	get_parent().add_child(troopInstance1)
	troopInstance1.set_global_position(get_global_position())
