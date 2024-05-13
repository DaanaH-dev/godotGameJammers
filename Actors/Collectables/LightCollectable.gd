extends Sprite2D


#The amount of time the collectable will add to the total light
var lightIncrease = 5.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_player_detection_body_entered(body):
	if body.get_parent().name == "Player":
		
		Game.lightTime += lightIncrease
			
		self.queue_free()
