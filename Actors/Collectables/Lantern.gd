extends Sprite2D


@onready var anim = get_node("AnimatedSprite2D")
const lightSize = 10
@onready var light = get_node("PointLight2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("On")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	light.texture_scale = lightSize


func _on_player_detection_body_entered(body):
	if body.get_parent().name == "Player":
		
		#Resets Light if player touches lantern
		#But if for whatever reason the player has more light than default
		#it wont reset it
		if Game.lightTime < Game.DEFAULTLIGHTTIME:
			Game.lightTime = Game.DEFAULTLIGHTTIME
			
		self.queue_free()
