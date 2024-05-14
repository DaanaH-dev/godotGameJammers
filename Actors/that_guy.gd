extends CharacterBody2D


const MOVEMENT_SPEED = 400.0
const JUMP_VELOCITY = -650.0
const GRAVITY_MODIFYER =  4.0
const finalLightScale = 0.2
const lightTextureMultiplier = 30
const shootAnimTime = 1.3

const SLIDING_SPEED = 600.0
const slideFriction = 1
const slideScaleY = 1
const slideScaleX = 4
var slideLength = 2.0
var timeTillStop = 0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var JUMP_RELEASED = false
var dead = false
var timeToShoot = 0.0
var shotReleased = true


#A variable that is set to true when you are in the lanterns safe area
var safe = false


@export var Flame : PackedScene

@onready var light2d = get_node("PointLight2D")
@onready var fireEffect = $Fire.process_material
@onready var anim = $AnimationPlayer
@onready var animSprite = $AnimatedSprite2D
@onready var hitBox = $CollisionShape2D
@onready var waxTrail = $WaxTrail
var tanAccel = 50.0
var sliding = false
#@onready var main = 

#var Cherry = preload("res://Collectibles/cherry.tscn")

func _ready():
	anim.play("Idle")

func _physics_process(delta):
	
	health(delta)
	#Calls the lighting around the character
	baseLight(delta)
	
	if is_on_floor():
		if timeTillStop > 0:
			timeTillStop -= delta
			
		if timeTillStop <= 0:
			timeTillStop = 0
			sliding = false
	
	#Controls the wax trail
	if not dead:
		if is_on_floor() and sliding:
			pass
			waxTrail.set_emitting(true)
		else:
			waxTrail.set_emitting(false)
		
	
	if sliding:
		
		animSprite.scale.y = slideScaleY
		animSprite.scale.x = slideScaleX
		hitBox.scale.y = slideScaleY
		hitBox.scale.x = slideScaleX
		set_floor_stop_on_slope_enabled(false)
	else:
		animSprite.scale.y = 2
		animSprite.scale.x = 2
		hitBox.scale.y = 2
		hitBox.scale.x = 2
		set_floor_stop_on_slope_enabled(true)
		
	#Makse sure the user doesnt move when shooting
	if timeToShoot > 0:
		timeToShoot -= delta
	else:
		timeToShoot = 0 
	
	if timeToShoot > 0.4 and timeToShoot <= 0.5 and not dead and shotReleased == false:
		shoot()	
		shotReleased = true
	
	
	# Add the gravity.
	
	#Applies gravity to character whilst in the air
	if not is_on_floor():
		velocity.y += (gravity * delta) * 2.3
		#print(gravity)
	if not dead:
		if Input.is_action_just_pressed("Shoot"):
			timeToShoot = shootAnimTime
			shotReleased = false
		#Checks to see if the jump button is released
		if Input.is_action_just_released("ui_accept"):
			JUMP_RELEASED = true
		else: 
			JUMP_RELEASED = false
			
		# Handle jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor() and not JUMP_RELEASED:
			velocity.y = JUMP_VELOCITY
			sliding = false
			
		#Handle jump phyics when player lets go of jump button mid jump
		elif JUMP_RELEASED and velocity.y < 0:
			velocity.y += (gravity * delta) * 15
			

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		
		
		var direction = Input.get_axis("ui_left", "ui_right")
		
		if velocity.x == 0 and sliding and not direction:
			sliding = false
		
		if direction:
			if direction >= 1:
				animSprite.flip_h = false
				movingRight()
			elif direction <= -1:
				animSprite.flip_h = true
				movingLeft()
			
			
			
			
			if Input.is_action_just_pressed("Slide"):
				timeTillStop = slideLength 
				sliding = true
			
				
			
			
			
			
			if sliding:
				velocity.x = direction * (SLIDING_SPEED * (timeTillStop/slideLength * slideFriction))
			else:
				velocity.x = direction * MOVEMENT_SPEED
				
			
			
				
		else:
			velocity.x = move_toward(velocity.x, 0, MOVEMENT_SPEED)
			noMovement()
	
		#Determines which animatin to play
		if timeToShoot <= 0:
			if velocity.y == 0:
				if velocity.x != 0:
					anim.play("Run")
				else:
					anim.play("Idle")
			else:
				if velocity.y > 0: 
					anim.play("Jump")
				elif velocity.y < 0:
					anim.play("Fall")
		else:
			anim.play("Shoot")
			
		
	move_and_slide()
	
#This function is what deals with the light around the character
func baseLight(delta):
	#This determeines what the light shrinks to
	
	var newScale = Game.lightTime/Game.DEFAULTLIGHTTIME
	if not safe:		
		if newScale >= finalLightScale:
			Game.lightTime -= delta
		else:
			pass
	light2d.texture_scale = newScale * lightTextureMultiplier
	
func shoot():
	
	var b = Flame.instantiate()
	owner.add_child(b)
	b.position = position + get_node("ShootingPoint").position
	
	
	
	#b.transform = $Candle_Wick.global_transform
	

func health(delta):
	var newScale = Game.lightTime/Game.DEFAULTLIGHTTIME
	
	if newScale <= finalLightScale and not safe:
		if Game.timeToDie > 0:
			Game.timeToDie -= delta
		else:
			Game.timeToDie = 0
	
	
	#THis indicates when you die
	if Game.timeToDie <= 0.0 and not dead:
		dead = true
		velocity.x = 0
		anim.play("Death")
		anim.queue("deadSad")
		$Fire.set_emitting(false)
		#THEN SOME SORT OF DEATH SEQUENCE
		

func movingRight():
	fireEffect.tangential_accel_max = tanAccel
	fireEffect.tangential_accel_min = tanAccel

func movingLeft():
	fireEffect.tangential_accel_max = -tanAccel
	fireEffect.tangential_accel_min = -tanAccel

func noMovement():
	fireEffect.tangential_accel_max = 0
	fireEffect.tangential_accel_min = 0 
	


func _on_safe_detection_area_entered(area):
	if area.name == "SafeZone":
		safe = true
		


func _on_safe_detection_area_exited(area):
	if area.name == "SafeZone":
		safe = false
