extends ColorRect
# Handles the visual transition between rooms

## --- export variables ---
@export var duration := 1.0

## --- onready variables ---
@onready var mat: ShaderMaterial = material

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

## --- public variables ---

## Plays the room transition
## @param center: The center position of the effect on screen
## @param top_tex: The texture to appear on top
## @param top_tex: The texture to appear on bottom
## @param reverse: Whether to play the transition in reverse
## @param callback: Callback function
func play_transition(center: Vector2, top_tex: Texture2D, bottom_tex: Texture2D, reverse: bool, callback: Callable) -> void:
	visible = true
	mat.set_shader_parameter("center", center / Vector2(get_viewport().size))
	if (top_tex):
		mat.set_shader_parameter("top_tex", top_tex)
		mat.set_shader_parameter("use_top", true)
	else:
		mat.set_shader_parameter("use_top", false)
	if (bottom_tex):
		mat.set_shader_parameter("bottom_tex", bottom_tex)
		mat.set_shader_parameter("use_bottom", true)
	else:
		mat.set_shader_parameter("use_bottom", false)
	
	var start_progress = 0.0
	var end_progress = 1.0
	if (reverse):
		start_progress = 1.0
		end_progress = 0.0
	mat.set_shader_parameter("progress", start_progress)
	
	var tween := create_tween()
	tween.tween_method(func(p):
		mat.set_shader_parameter("progress", p)
	, start_progress, end_progress, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_callback(func():
		visible = false
		callback.call()
	)
