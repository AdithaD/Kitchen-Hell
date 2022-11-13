extends Node2D

var current_ingredient : Ingredient = null
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func set_ingredient(new_ingredient):
	current_ingredient = new_ingredient
	$Sprite2D.texture = current_ingredient.texture
