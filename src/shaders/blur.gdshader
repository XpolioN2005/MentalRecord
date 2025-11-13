shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform float amount: hint_range(0.0, 5.0);
uniform vec4 tint_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);

void fragment() {
	COLOR = textureLod(SCREEN_TEXTURE, SCREEN_UV, amount) * tint_color;
}