extends Node


@export var starting_money = 50
@onready var money = starting_money

signal money_updated(new_money : int)

# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("money_updated", money)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spend_money(amount) -> void:
	if amount <= money:
		money -= amount
		emit_signal("money_updated", money)
	pass
	
func gain_money(amount) -> void:
	money += amount
	emit_signal("money_updated", money)
	pass
