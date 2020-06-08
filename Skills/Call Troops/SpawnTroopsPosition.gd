extends Position2D

signal CallingAvailable(new_value)

onready var troopReference = load ("res://Skills/Call Troops/Troop.tscn")
var troopInstance

var ableCalling = true

func _process(_delta):
	if not is_instance_valid(troopInstance):
		ableCalling = true
		emit_signal("CallingAvailable", ableCalling)

func _on_Player_CallTroops():
	if ableCalling:
		troopInstance = troopReference.instance()
		get_parent().add_child(troopInstance)
		troopInstance.set_global_position(get_global_position())
		ableCalling = false
		emit_signal("CallingAvailable", ableCalling)
