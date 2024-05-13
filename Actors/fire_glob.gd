extends CharacterBody2D


var speed = 150
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


#Currently updates the position to move along the x axis relative to the glob itself
func _physics_process(delta):
	position += transform.x * speed * delta
	position+= global_transform.y 
