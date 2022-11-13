extends Resource
class_name Recipe

@export var inputs : Array[Ingredient] = [] 
@export var output : Ingredient

func _init(p_inputs = [], p_output = null):
	inputs = p_inputs
	output = p_output


func match_ingredients(ingredients: ):
	for i in inputs:
		if not ingredients.has(i):
			return false
			
	return true

