extends Button
class_name Statement
# Represents a draggable statement button that can be dropped on a Door to unlock it.

# --- exported variables ---
@export var id: String
@export var speaker: String

# --- local variables ---
var statement_meta: Dictionary = {
	"id": "",
	"text": "",
	"speaker": "",
	"collected": false,
	"used": false,
	"new": true
}

# --- private variables ---
var _animating = false
const STATEMENT_SOUNDS = [
	preload("uid://ctivhp442fnug"),
	preload("uid://c32k1afe1fut1"),
	preload("uid://bianvkugah3p")
]

# --- built-in methods ---

func _ready() -> void:
	statement_meta["id"] = id
	statement_meta["text"] = text
	statement_meta["speaker"] = speaker
	
	if InventoryManager.has_dialogue(statement_meta["id"]):
		queue_free()

# --- signal handlers ---

## Registers this statement as a collected dialogue
func _on_pressed() -> void:
	if (_animating):
		return
	
	AudioManager.play_sfx(STATEMENT_SOUNDS[randi() % (STATEMENT_SOUNDS.size())])
		
	statement_meta["collected"] = true

	InventoryManager.add_dialogue(id, statement_meta.duplicate())
	
	# Do animation
	_animating = true
	
	material = material.duplicate()
	var tween := create_tween()
	tween.tween_method(func(p):
		material.set_shader_parameter("dissolve_value", p)
	, 0.0, 1.0, 1.0)
	
	tween.tween_callback(func():
		queue_free()
	)

	SignalBus.paused_state_changed.emit(true)
	SignalBus.dialogue_requested.emit(speaker, text) 
