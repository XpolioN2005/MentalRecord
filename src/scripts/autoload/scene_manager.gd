extends Node
# Handles switching between scenes while keeping persistent objects in root node

## --- private variables ===
var _current_level: Node = null
var _default_level: String = "res://scenes/rooms/interrogation_room.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Load level
	change_room(_default_level)

## --- public methods ---
func change_room(scene_path: String):
	# Remove current room
	if _current_level and is_instance_valid(_current_level):
		_current_level.queue_free()
		
	# Load new room
	var scene = load(scene_path)
	_current_level = scene.instantiate()
	
	# Add to scene
	add_child(_current_level)
