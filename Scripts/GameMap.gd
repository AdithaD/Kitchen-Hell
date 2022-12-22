extends TileMap

var ingredient_consumer_scene = preload("res://PackedScenes/ingredient_consumer.tscn")

var tile_entity_map = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	var cells = get_used_cells(1)
	
	for cell in cells:
		var cell_data = get_cell_tile_data(1, cell)
		
		var ingredient_consumer = cell_data.get_custom_data_by_layer_id(1)
		if ingredient_consumer:
			print("consumer at " + str(cell))
			var new_consumer_node = ingredient_consumer_scene.instantiate()
			
			new_consumer_node.grid_position = cell
			new_consumer_node.consumer = ingredient_consumer
			
			new_consumer_node.position = map_to_local(cell)
			
			tile_entity_map[cell] = new_consumer_node
			
			$TileEntities.add_child(new_consumer_node)
	pass # Replace with function body.

func try_consume(grid_position, ingredient) -> bool:
	if tile_entity_map.has(grid_position):
		return tile_entity_map[grid_position].consume_ingredient(ingredient)
	else:
		return false
		
func try_retrieve(grid_position):
	if tile_entity_map.has(grid_position):
		return tile_entity_map[grid_position].retrieve_ingredient()
	else:
		return false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
