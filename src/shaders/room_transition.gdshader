shader_type canvas_item;

uniform vec2 center = vec2(0.5, 0.5); // normalized [0,1] screen coords
uniform float progress : hint_range(0.0, 1.0) = 0.0;
uniform float strength = 5; // controls bulge intensity

uniform sampler2D top_tex;
uniform bool use_top = false;

uniform sampler2D bottom_tex;
uniform bool use_bottom = false;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
    vec2 uv = UV;
    vec2 dir = uv - center;
    float dist = length(dir);
	
	// Top texture bulges outward
	float bulge = smoothstep(0.0, 1.0, progress);
    float top_factor = 1.0 - strength * bulge * exp(-dist * 6.0);
    vec2 top_uv = center + dir * top_factor;
	
	// Bottom texture pinches inward
	float pinch = smoothstep(1.0, 0.0, progress);
    float bottom_factor = 1.0 + strength * pinch * exp(-dist * 6.0) / 2.0;
    vec2 bottom_uv = center + dir * bottom_factor;
	
	// === Texture selection ===
    vec4 top_color = use_top ? texture(top_tex, top_uv)
                             : texture(SCREEN_TEXTURE, top_uv);

    vec4 bottom_color = use_bottom ? texture(bottom_tex, bottom_uv)
                                   : texture(SCREEN_TEXTURE, bottom_uv);
    
    // As progress increases, reveal transparency in center
    float hole = 0.0;
	// Outside is transparent
	hole = smoothstep(1.0, 0.0, dist + 1.0 - 2.0 * progress);
	
	// Blend between top and bottom based on the hole mask
    vec4 color = mix(top_color, bottom_color, hole);
    COLOR = color;
}
