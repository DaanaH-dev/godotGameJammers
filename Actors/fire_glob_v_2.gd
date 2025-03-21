extends RigidBody2D

var speed = 700
var gravityScale = 1
var stopMoving = false
@onready var player = get_node("../Player/That Guy")
@onready var groundCollision = $GroundDetection
@onready var contactEffect = $Explosion
@onready var animation = $AnimatedSprite2D

const LIGHTMULTIPLIER = 5

const TIMETOSHRINK = 1.5

var timeBeforeDespawn = 2.0

var newScale
# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play("Flying")
	set_lock_rotation_enabled(true)
	set_gravity_scale(gravityScale)
	var force = Vector2.ZERO 
	var direction = (get_global_mouse_position() - player.global_position).normalized()
	
	force = speed * direction
	apply_central_impulse(force)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#position += transform.x
	
	newScale = LIGHTMULTIPLIER
	if stopMoving == true:
		set_freeze_enabled(true)
		timeBeforeDespawn -= delta
		
		if timeBeforeDespawn <= TIMETOSHRINK:
			newScale = (timeBeforeDespawn/TIMETOSHRINK) * LIGHTMULTIPLIER
			
	
	$PointLight2D.texture_scale = newScale
	
	if timeBeforeDespawn <= 0 :
		self.queue_free()
	
		
		

func _on_ground_detection_body_entered(body):
	if body.get_parent().name != "Player":
		if not stopMoving: 
			contactEffect.set_emitting(true)
		
		stopMoving = true
			
		
		if(animation != null):
			animation.queue_free()
		if($FireCollision != null):
			$FireCollision.queue_free()
		

