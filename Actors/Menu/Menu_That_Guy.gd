extends CharacterBody2D


const MOVEMENT_SPEED = 400.0
const JUMP_VELOCITY = -650.0
const GRAVITY_MODIFYER =  4.0
const finalLightScale = 0.2
const lightTextureMultiplier = 30
const shootAnimTime = 1.3


var timeTillStop = 0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var timeToShoot = 0.0
var shotReleased = true


#A variable that is set to true when you are in the lanterns safe area
var safe = false


@export var Flame : PackedScene

#@onready var light2d = get_node("PointLight2D")
@onready var fireEffect = $Fire.process_material
@onready var anim = $AnimationPlayer
@onready var animSprite = $AnimatedSprite2D
@onready var hitBox = $CollisionShape2D

var tanAccel = 50.0
var sliding = false

#This value will be every shot after
const DEFAULTSPITTIME = 20
#THis value will be the first shot, 
var spitTimer = DEFAULTSPITTIME

#@onready var main = 

#var Cherry = preload("res://Collectibles/cherry.tscn")

func _ready():
	anim.play("Idle")

func _physics_process(delta):
	spitTimer -= delta
	
	
	if timeToShoot > 0:
		timeToShoot -= delta
	else:
		timeToShoot = 0 
		
	
	if spitTimer >= 0.0:
		spitTimer -= delta
	else:
		anim.play("Shoot")
		anim.queue("Idle")
		timeToShoot = shootAnimTime
		shotReleased = false

		spitTimer = DEFAULTSPITTIME

	if timeToShoot > 0.4 and timeToShoot <= 0.5 and shotReleased == false:
		shoot()	
		shotReleased = true	
		
func shoot():
	
	var b = Flame.instantiate()
	owner.add_child(b)
	b.position = position + get_node("ShootingPoint").position
	
	
	

