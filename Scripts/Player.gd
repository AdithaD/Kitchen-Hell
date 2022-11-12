extends Node2D

@export var move_speed = 10
@export var default_scale : Vector2 = Vector2(0.6, 0.6)

@export var tilemap : TileMap

var direction : Vector2 = Vector2.ZERO
var last_velocity = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if direction.length() > 0:
		var new_position = position + direction * move_speed * delta
		
		var map_pos = tilemap.local_to_map(new_position)
		var cell_data = tilemap.get_cell_source_id(1, map_pos)

		if cell_data == -1:
			position = new_position

	pass
func update_animation():
		if last_velocity.length() > 0:
			if last_velocity.y >= 0:
				if direction.length() > 0:
					$PlayerSprite.set_animation("dr")
				else:
					$PlayerSprite.set_animation("idle_dr")
				if last_velocity.x < 0:
					$PlayerSprite.flip_h = true
				else:
					$PlayerSprite.flip_h = false
			else:
				if direction.length() > 0:
					$PlayerSprite.set_animation("ul")
				else:
					$PlayerSprite.set_animation("idle_ul")
				if last_velocity.x > 0:
					$PlayerSprite.flip_h = true
				else:
					$PlayerSprite.flip_h = false
				pass


func _input(event):
	var velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
		
	if Input.is_action_pressed("left"):
		velocity.x -= 1
		
	if Input.is_action_pressed("down"):
		velocity.y += 1
		
	if Input.is_action_pressed("up"):
		velocity.y -= 1
		
	if velocity.x != 0 and velocity.y != 0:
		var angle = 0 if velocity.x > 0 else 180
		
		# x y
		# -1 -1 150
		# -1  1 210
		# 1  -1 30
		# 1   1 -30
		
		angle += 30 * -sign(velocity.y) * -sign(velocity.x)
		print(angle)
			
		direction = Vector2.RIGHT.rotated(deg_to_rad(angle))
	else:
		direction = velocity.normalized()
		
	if velocity.length() > 0:
		if velocity.x != 0:
			last_velocity.x = velocity.x
		if velocity.y != 0:
			last_velocity.y = velocity.y
			
	# direction = velocity.normalized()
	update_animation()
	
