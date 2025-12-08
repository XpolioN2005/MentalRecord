extends Control
# handles pause menu operations

## --- export variables ---
@export var game: GameManager

## --- public variables ---
var title_scene = "res://scenes/global/main.tscn"

## --- listener methods ---

func _on_resume_pressed() -> void:
	AudioManager.play_click()
	game.toggle_pause()

func _on_settings_pressed() -> void:
	AudioManager.play_click()
	game.open_settings()

func _on_quit_pressed() -> void:
	AudioManager.play_click()
	InventoryManager.save_to_file()
	# Return to main menu
	game.toggle_pause()
	SceneManager.clear_rooms()
	AudioManager.stop_main_music()
	get_tree().change_scene_to_file(title_scene)
