extends ProgressBar

@export_node_path(Node) var power_system_path
@onready var power_system = get_node(power_system_path)

# Called when the node enters the scene tree for the first time.
func _ready():
	max_value = power_system.maximum_power
	power_system.power_changed.connect(func (np): value = np)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
