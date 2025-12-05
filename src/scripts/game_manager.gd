extends Node2D
# Handles game-wide logic such as pausing
class_name GameManager

## --- onready variables ---
@onready var pause_menu: Control = $CanvasLayer/PauseMenu
@onready var settings: Control = $CanvasLayer/Settings

## --- public variables ---
var paused = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

## --- public methods ---

## Pauses or unpauses the game
func toggle_pause() -> void:
	if paused:
		pause_menu.hide()
		SignalBus.paused_state_changed.emit(false)
	else:
		pause_menu.show()
		SignalBus.paused_state_changed.emit(true)
		
	paused = !paused
	
## Pauses or unpauses the game
func open_settings() -> void:
	settings.show()


# test

func _input(_event):
	if Input.is_action_just_pressed("test"):
		for i in get_tree().get_nodes_in_group("doors"):
			print(i)