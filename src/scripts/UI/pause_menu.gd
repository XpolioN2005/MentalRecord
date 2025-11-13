extends Control
# handles pause menu operations

## --- export variables ---
@export var game: GameManager

## --- public variables ---
var title_scene = "res://scenes/global/main.tscn"

## --- listener methods ---

func _on_resume_pressed() -> void:
	game.toggle_pause()

func _on_settings_pressed() -> void:
	pass # Replace with function body.

func _on_quit_pressed() -> void:
	# Return to main menu
	game.toggle_pause()
	SceneManager.clear_rooms()
	get_tree().change_scene_to_file(title_scene)
