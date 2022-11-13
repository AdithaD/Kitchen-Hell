extends Node2D
@export var max_ingredients = 4

@onready var texture_rects = $Control/HBoxContainer.get_children()

var grid_position = Vector2.ZERO
var amount_of_ingredients = 0
var ingredients_dict = {}
var consumer = null

var current_recipe = null
# Called when the node enters the scene tree for the first time.
func _ready():
	$CookTimer.wait_time = consumer.get_creation_time(0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not $CookTimer.is_stopped():
		$Control/ProgressBar.value =  (1 - $CookTimer.get_time_left() /  consumer.get_creation_time(0)) * 100
	pass

func consume_ingredient(ingredient) -> bool:
	if amount_of_ingredients < max_ingredients:
		amount_of_ingredients += 1
		if ingredients_dict.has(ingredient):
			ingredients_dict[ingredient] += 1
		else:
			ingredients_dict[ingredient] = 1
		
		texture_rects[amount_of_ingredients - 1].texture = ingredient.texture
		
		match_recipes()
		return true
	else: 
		return false

func rerender_textures():
	var counter = 0
	for i in ingredients_dict:
		for j in ingredients_dict[i]:
			texture_rects[counter].texture = i.texture
			counter += 1
			
	while counter < max_ingredients:
		texture_rects[counter].texture = null
		counter += 1

func retrieve_ingredient():
	if amount_of_ingredients > 0:
		amount_of_ingredients -= 1
		
		var ing = ingredients_dict.keys().back()
		ingredients_dict[ing] -= 1
		
		if ingredients_dict[ing] == 0:
			ingredients_dict.erase(ing)
		
		rerender_textures()
		return ing
	else:
		return null

func match_recipes():
	for recipe in consumer.recipes:
		if recipe.match_ingredients(ingredients_dict.keys()):
			current_recipe = recipe
			$CookTimer.start()

func _on_timer_timeout():
	ingredients_dict.clear()
	ingredients_dict[current_recipe.output] = 1
	amount_of_ingredients = 1
	rerender_textures()
	pass # Replace with function body.
