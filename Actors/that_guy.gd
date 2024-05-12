extends CharacterBody2D


const MOVEMENT_SPEED = 400.0
const JUMP_VELOCITY = -650.0
const GRAVITY_MODIFYER =  4.0
const finalLightScale = 0.2
const lightTextureMultiplier = 30
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var JUMP_RELEASED = false

@onready var light2d = get_node("PointLight2D")


func _physics_process(delta):
	
	#Calls the lighting around the character
	baseLight(delta)
	
	
	#Checks to see if the jump button is released
	if Input.is_action_just_released("ui_accept"):
		JUMP_RELEASED = true
	else: 
		JUMP_RELEASED = false
	# Add the gravity.
	
	#Applies gravity to character whilst in the air
	if not is_on_floor():
		velocity.y += (gravity * delta) * 2.3
		#print(gravity)

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and not JUMP_RELEASED:
		velocity.y = JUMP_VELOCITY
		
	#Handle jump phyics when player lets go of jump button mid jump
	elif JUMP_RELEASED and velocity.y < 0:
		velocity.y += (gravity * delta) * 15
		print("jump released")
		print(velocity.y," ", (gravity * delta), " ", gravity, " ", delta)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * MOVEMENT_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, MOVEMENT_SPEED)

	move_and_slide()
	
#This function is what deals with the light around the character
func baseLight(delta):
	#This determeines what the light shrinks to
	
	var newScale = Game.lightTime/Game.DEFAULTLIGHTTIME
			
	if newScale >= finalLightScale:
		Game.lightTime -= delta
	else:
		pass
	print(Game.lightTime)
	light2d.texture_scale = newScale * lightTextureMultiplier
	
		
	
