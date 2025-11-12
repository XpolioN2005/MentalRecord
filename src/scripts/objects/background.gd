extends Node2D
# Manager parallax 2d background

## --- export variables ---

@export var pan_strength := 0.05

## --- onready variables ---

@onready var camera = get_viewport().get_camera_2d()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var viewport_size = get_viewport_rect().size
	var mouse_pos = get_viewport().get_mouse_position()

	# Normalize mouse position to range [-1, 1]
	var offset = (mouse_pos / viewport_size - Vector2(0.5, 0.5)) * 2.0

	# Apply parallax panning to children
	for child in get_children():
		if child is Sprite2D or child is Door:
			var depth = float(child.get_meta("depth", 1.0))
			child.position = offset * -pan_strength * depth * viewport_size
