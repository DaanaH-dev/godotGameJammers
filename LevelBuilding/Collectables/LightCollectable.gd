extends Sprite2D

@onready var anim = $AnimatedSprite2D 
@onready var light2d = $PointLight2D
@onready var fire = $Fire
#The amount of time the collectable will add to the total light
var lightIncrease = 5.0

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("Torch")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_player_detection_body_entered(body):
	if body.get_parent().name == "Player":
		
		Game.lightTime += lightIncrease
			
		anim.play("NoTorch")
		light2d.queue_free()
		fire .queue_free()
	else:
		anim.play("Torch")
