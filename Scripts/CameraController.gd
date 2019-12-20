extends Camera2D

export var speed = 10.0  #scroll speed

#camera variables
var zoom_step = 1.1

func _ready():
	pass 


func _process(delta):
	#smooth movement
	var xinput = (int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")))
	var yinput = (int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up")))
	
	position.x =  lerp(position.x, position.x + (xinput*speed*zoom.x), speed*delta)
	position.y =  lerp(position.y, position.y + (yinput*speed*zoom.y), speed*delta)
	

	
	pass
	
	
func _input(event):
	if event is InputEventMouse:
		if event.is_pressed() and not event.is_echo():
			var mouse_position = event.position
			if event.button_index == BUTTON_WHEEL_DOWN:
				zoom_at_point(zoom_step, mouse_position)
			else : if event.button_index == BUTTON_WHEEL_UP:
				zoom_at_point(1/zoom_step, mouse_position)
				
func zoom_at_point(zoom_change, point):
	var c0 = global_position #camera position
	var v0 = get_viewport().size #viewport size
	var c1 #next camera position
	var z0 = zoom #current zoom value
	var z1 = z0 * zoom_change #next zoom value
	
	c1 = c0 + (-0.5*v0 + point)*(z0-z1)
	zoom = z1
	global_position = c1