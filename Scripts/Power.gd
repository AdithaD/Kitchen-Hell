extends Node

@export var starting_power = 50
@onready var power = starting_power

signal power_changed
signal power_allocation_changed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func gain_power(amount) -> void:
	power += amount
	emit_signal("power_changed", power)
	pass


func _on_power_depreciation_timeout():
	pass # Replace with function body.
