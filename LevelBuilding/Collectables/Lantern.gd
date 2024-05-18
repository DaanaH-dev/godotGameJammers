extends Sprite2D


@onready var anim = get_node("AnimatedSprite2D")
const lightSize = 5
@onready var light = get_node("PointLight2D")
var captured = false

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("Off")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not captured:
		light.texture_scale = lightSize


func _on_player_detection_body_entered(body):
	if body.get_parent().name == "Player" and not captured:
		captured = true
		#Resets Light if player touches lantern
		#But if for whatever reason the player has more light than default
		#it wont reset it
		if Game.lightTime < Game.DEFAULTLIGHTTIME:
			Game.lightTime = Game.DEFAULTLIGHTTIME
			Game.timeToDie = Game.DEFAULTTIMETODIE
			
		$Fire.queue_free()
		light.queue_free()
		$SafeZone.queue_free()
