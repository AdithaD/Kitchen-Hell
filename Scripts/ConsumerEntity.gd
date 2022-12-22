extends Node2D
@export var max_ingredients = 4

@onready var texture_rects = $Control/HBoxContainer.get_children()

var grid_position = Vector2.ZERO
var consumer = null

var power_level = 1

var current_recipe = null

signal power_level_updated(new_power_level: int)

# Called when the node enters the scene tree for the first time.
func _ready():
	$Control/PowerControl/PowerDecrementButton.pressed.connect(decrement_power)
	$Control/PowerControl/PowerIncrementButton.pressed.connect(increment_power)
	
	$CookTimer.wait_time = consumer.get_creation_time(0)
	pass # Replace with function body.

func increment_power():
	if consumer != null:
		if power_level + 1 <= consumer.max_power_level:
			power_level += 1
			
			$Control/PowerControl/PowerLabel.text = str(power_level)
			emit_signal("power_level_updated", power_level)
	pass

func decrement_power():
	if consumer != null:
		if power_level - 1 > 0:
			power_level -= 1
			$Control/PowerControl/PowerLabel.text = str(power_level)
			emit_signal("power_level_updated", power_level)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not $CookTimer.is_stopped():
		$Control/ProgressBar.value =  (1 - $CookTimer.get_time_left() /  consumer.get_creation_time(0)) * 100
	pass

func consume_ingredient(ingredient_entity) -> bool:
	var amnt_of_entities = $IngredientEntities.get_child_count()
	if amnt_of_entities < max_ingredients:
		$IngredientEntities.add_child(ingredient_entity)
		
		texture_rects[amnt_of_entities - 1].texture = ingredient_entity.get_texture()
		
		match_recipes()
		return true
	else:
		return false

func rerender_textures():
	var counter = 0
	for entity in $IngredientEntities.get_children():
		texture_rects[counter].texture = entity.get_texture()
		counter += 1
			
	while counter < max_ingredients:
		texture_rects[counter].texture = null
		counter += 1

func retrieve_ingredient():
	var amnt_of_entities = $IngredientEntities.get_child_count()
	if amnt_of_entities > 0:
		var entity = $IngredientEntities.get_child(amnt_of_entities - 1)
		$IngredientEntities.remove_child(entity)

		rerender_textures()
		return entity
	else:
		return null

func match_recipes():
	for recipe in consumer.recipes:
		if recipe.match_ingredients($IngredientEntities.get_children().map(func (x): return x.base)):
			current_recipe = recipe
			$CookTimer.start()

func _on_timer_timeout():
	for child in $IngredientEntities.get_children():
		$IngredientEntities.remove_child(child)
		child.queue_free()
		
	$IngredientEntities.add_child(current_recipe.generate_output_entity())
	rerender_textures()
	pass # Replace with function body.
