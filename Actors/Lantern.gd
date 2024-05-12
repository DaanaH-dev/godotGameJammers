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
