extends Resource
class_name Ingredient

@export var ingredient_id : int
@export var ingredient_name : String
@export var texture : Texture2D

@export var servable : bool

func _init(p_ingredient_id = 0, p_ingredient_name = "Ingredient", p_texture = null, p_servable = false):
	ingredient_id = p_ingredient_id
	ingredient_name = p_ingredient_name
	texture = p_texture
	servable = p_servable
