extends Resource
class_name Consumer

@export var consumer_id = 0
@export var consumer_name = "Consumer"
@export var recipes : Array[Recipe] = []
@export var max_power_level : int
@export var base_creation_time = 4.0
@export var is_appliance : bool = true

func _init(p_consumer_id = 0, p_consumer_name = "Consumer", p_recipes = [], p_base_creation_time = 10, p_max_power_level = 3, p_is_appliance = true):
	consumer_id = p_consumer_id
	consumer_name = p_consumer_name
	recipes = p_recipes
	base_creation_time = p_base_creation_time
	max_power_level = p_max_power_level
	is_appliance = p_is_appliance

func get_creation_time(power):
	return base_creation_time
