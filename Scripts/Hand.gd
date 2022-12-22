extends Node2D

func _process(delta):
	pass

# Holds the ingredient entity supplied if the hand isn't full already.
func hold_ingredient(new_ingredient: Node) -> void:
	if is_empty():
		$Holding.add_child(new_ingredient)
		$Sprite2D.texture = new_ingredient.get_texture()
		
# Returns whether the player is holding an ingredient entity or not
func is_empty():
	return $Holding.get_child_count() == 0

# Clears the player's hand so that they hold nothing.
# Does NOT delete the ingredient entity, returns the orphaned node if hand was not empty.
func clear() -> Node:
	if !is_empty():
		var current_ingredient = $Holding.get_child(0)
		$Holding.remove_child(current_ingredient)
		var temp = current_ingredient
		
		current_ingredient = null
		$Sprite2D.texture = null
	
		if temp != null:
			return temp

	return null

