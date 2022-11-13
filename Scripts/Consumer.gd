extends Resource
class_name Consumer

@export var consumer_id = 0
@export var consumer_name = "Consumer"
@export var recipes : Array[Recipe] = []

@export var base_creation_time = 4.0

func _init(p_consumer_id = 0, p_consumer_name = "Consumer", p_recipes = [], p_base_creation_time = 10):
	consumer_id = p_consumer_id
	consumer_name = p_consumer_name
	recipes = p_recipes
	base_creation_time = p_base_creation_time

func get_creation_time(power):
	return base_creation_time
