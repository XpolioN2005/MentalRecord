extends Button
class_name Statement

@export var is_in_ui: bool = false
@export var id: String = ""
@export var statement_text: String = "Statement"

var is_dragging: bool = false
var drag_offset: Vector2 = Vector2.ZERO

func _ready() -> void:
	text = statement_text

func _process(_delta: float) -> void:
	if is_dragging:
		global_position = get_global_mouse_position() - drag_offset

# your original pressed handler: move into UI if not already
func _on_pressed() -> void:
	if is_in_ui:
		return
	_set_to_ui()

# called when the button reports a "down" event (left mouse press)
func _on_button_down() -> void:
	# only start drag if item already in UI
	if not is_in_ui:
		return
	is_dragging = true
	# keep cursor offset so it doesn't jump to control origin
	drag_offset = get_global_mouse_position() - global_position

# called when button reports an "up" event (release)
func _on_button_up() -> void:
	if not is_in_ui:
		return
	if is_dragging:
		is_dragging = false
		_on_drop()

# drop logic: check Door nodes (group "doors")
func _on_drop() -> void:
	for door in get_tree().get_nodes_in_group("doors"):
		if door is Door:
			if door.contains_point(global_position):
				if door.statement_to_unloak == statement_text:
					print("works")
					door.unlock()
					queue_free()
					return
				else:
					_reject(door)
					return
	_reject(null)

func _reject(zone) -> void:
	print("Drop rejected by ", zone)
	

func _set_to_ui() -> void:
	is_in_ui = true
