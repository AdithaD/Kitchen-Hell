extends Node

# per second
@export var power_depreciation_rate = 1

@export var maximum_power = 500
@export var starting_power = 50
@onready var power = starting_power

signal power_changed
signal power_allocation_changed

var appliances = []

# Called when the node enters the scene tree for the first time.
func _ready():
	appliances.append_array(get_tree().get_first_node_in_group("map").get_appliances())
	pass # Replace with function body.

func register_appliance(appliance):
	appliances.append(appliance)
	
func calculate_power_drain() -> float:
	var power_drain = 0
	for app in appliances:
		power_drain += app.power_level
	
	return power_drain
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	reduce_power(power_depreciation_rate * calculate_power_drain() *delta)
	pass
	
func gain_power(amount) -> void:
	power += amount
	emit_signal("power_changed", power)
	pass

func reduce_power(amount) -> void:
	power -= amount
	emit_signal("power_changed", power)
	
func _on_power_depreciation_timeout():
	pass # Replace with function body.
