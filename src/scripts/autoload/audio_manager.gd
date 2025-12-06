extends Node

# --- onready variables ---
@onready var sfx_player: AudioStreamPlayer = $SFXPlayer
@onready var main_music: FmodEventEmitter2D = $FmodEventEmitter2D

# --- built-in functions ---
func _ready():
	pass

# --- public methods ---

## Updates the parameter for main music and plays
## @param param: The name of the parameter
## @param value: The value of the parameter
func set_main_music_parameter(param: String, value: float):
	main_music.play(false)
	
	var start: float = FmodServer.get_global_parameter_by_name(param)
	var tween := create_tween()
	tween.tween_method(func(i):
		FmodServer.set_global_parameter_by_name(param, i)
	, start, value, 1.0)
	
## Stops the main music
func stop_main_music():
	main_music.stop()
	
## Plays the given sound effect
## @param stream: The audiostream to play
## @param volume: The volume to play at
func play_sfx(stream: AudioStream, volume := 1.0):
	var p = AudioStreamPlayer.new()
	p.bus = "SFX"
	p.stream = stream
	p.volume_db = linear_to_db(volume)
	add_child(p)
	p.play()

	p.finished.connect(func(): p.queue_free())
	
## Sets the music volume
## @param value: The new volume value
func set_music_volume(value: float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)
	main_music.volume = db_to_linear(value)
	
## Returns the music volume
## @return: The volume
func get_music_volume() -> float:
	return AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))

## Sets the sound volume
## @param value: The new volume value
func set_sfx_volume(value: float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)
	
## Returns the sound volume
## @return: The volume
func get_sound_volume() -> float:
	return AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX"))
	
# --- private methods ---

## Swaps the audio players when fiished transitioning
func _swap_players():
	#var temp = active_player
	#active_player = inactive_player
	#inactive_player = temp
	#inactive_player.stop()
	pass
