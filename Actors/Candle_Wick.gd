extends Marker2D

#makes the launch point of the fire globs to look at the mouse, so it can go in the right direction
func _physics_process(delta):
	look_at(get_global_mouse_position())
	
