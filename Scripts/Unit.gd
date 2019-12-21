extends KinematicBody2D

export var selected = false setget set_selected
onready var box = $Box
onready var nameLabel = $nameLabel
onready var bar = $HPBar

signal was_selected
signal was_deselected

var speed : = 100.0
var path = PoolVector2Array() setget set_path


func set_selected(value):
	if selected != value:
		selected = value
		box.visible = value
		nameLabel.visible = value
		bar.visible = value
		if selected:
			emit_signal("was_selected", self)
		else:
			emit_signal("was_deselected", self)

func _ready():
	
	connect("was_selected", get_parent(), "select_unit")
	connect("was_deselected", get_parent(), "deselect_unit")
	box.visible = false
	nameLabel.visible = false
	bar.visible = false
	nameLabel.text = name
	randomize()
	bar.value = randi() % 90 + 10
	set_process(false) #for navigation

func _process(delta: float):
	var move_distance : = speed*delta
	move_along_path(move_distance)

func set_path(value : PoolVector2Array) -> void:
	path = value
	if value.size() == 0:
		return
	set_process(true)
	
func move_along_path(distance: float):
	var start_point : = position
	for i in range(path.size()):
		var distance_to_next : = start_point.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0.0:
			position = start_point.linear_interpolate(path[0], distance / distance_to_next)
			break
		elif distance < 0.0:
			position = path[0]
			set_process(false)
			break
		distance -= distance_to_next
		start_point = path[0]
		path.remove(0)
	
func _on_Unit_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_LEFT:
				set_selected(true)
			elif event.button_index == BUTTON_RIGHT:
				set_selected(false)	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	