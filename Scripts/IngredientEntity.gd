extends Node
class_name IngredientEntity

enum Modifier {
	NONE, SWEET, SPICY, SOUR, CURSED, RADIANT
}

var base : Ingredient
var modifier = Modifier.NONE

# Returns the texture for the ingredient incorporating the modifiers effects
func get_texture() -> Texture2D:
	return base.texture
