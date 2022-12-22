extends Resource
class_name Recipe

@export var inputs : Array[Ingredient] = [] 
@export var output : Ingredient
@export var modifier : IngredientEntity.Modifier

func _init(p_inputs = [], p_output = null, modifier = 0):
	inputs = p_inputs
	output = p_output


func match_ingredients(ingredients: ):
	for i in inputs:
		if not ingredients.has(i):
			return false
			
	return true

# Returns an orphaned node for the output of this recipe. This node should immediately be added to the scene tree for memory safety.
func generate_output_entity() -> Node:
	var new_ingredient_entity  = IngredientEntity.new()
	new_ingredient_entity.base = output
	new_ingredient_entity.modifier = modifier
	
	return new_ingredient_entity
