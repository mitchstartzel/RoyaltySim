extends Node2D


var Unit = load("res://Scenes/Unit.tscn")
var selected_unit = Unit
var Unit1 = Unit.instance()

onready var nav_2d = $Navigation2D

func select_unit(unit):
	if not selected_unit == unit:
		selected_unit = unit
	print("selected %s" % unit.name)
func deselect_unit(unit):
	if selected_unit == unit:
		selected_unit = null
	print("deselected %s" % unit.name)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	Unit1.set_name("Unit1")
	Unit1.position.x = $Castle.position.x - 100
	Unit1.position.y = $Castle.position.y + 50
	add_child(Unit1)
	var beginning : Vector2 = Unit1.global_position
	var end : Vector2 = Unit1.global_position
	end.x += 250.0
	
	var new_path : PoolVector2Array = nav_2d.get_simple_path(beginning, end)
	Unit1.path = new_path
	
func _process(delta: float):
	if Unit1.path.size() == 0:
		var beginning : Vector2 = Unit1.global_position
		var end : Vector2 = Unit1.global_position
		end.x -= 250.0
		var new_path : PoolVector2Array = nav_2d.get_simple_path(end, beginning)
		Unit1.path = new_path


