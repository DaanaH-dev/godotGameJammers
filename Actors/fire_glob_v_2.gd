extends RigidBody2D

var speed = 700
var gravityScale = 1
@onready var player = get_node("../Player/That Guy")
# Called when the node enters the scene tree for the first time.
func _ready():
	
	set_gravity_scale(gravityScale)
	var force = Vector2.ZERO 
	var direction = (get_global_mouse_position() - player.global_position).normalized()
	force = speed * direction
	apply_central_impulse(force)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#position += transform.x
	pass
	
	
	
	
