extends Control
# Handles opening the pause menu

## --- onready variables ---
@onready var game: Node2D = $"../.."
@onready var button: Button = $Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

## --- private methods ---

## Open pause menu
func _on_pressed() -> void:
	if (!SceneManager.transitioning):
		AudioManager.play_click()
		game.toggle_pause()

## Increases size when hovered
func _on_mouse_entered() -> void:
	if (button.disabled):
		return
	scale = Vector2(1.1, 1.1)
	rotation_degrees = 15

## Resets the size when unhovered
func _on_mouse_exited() -> void:
	scale = Vector2(1, 1)
	rotation_degrees = 0
