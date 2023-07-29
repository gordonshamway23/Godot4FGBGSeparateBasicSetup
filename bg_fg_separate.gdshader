shader_type canvas_item;

uniform sampler2D game_viewport_texture: filter_nearest, repeat_disable;

const float alpha_threshold = 0.5;

void fragment() 
{
	vec4 game_color = texture(game_viewport_texture, UV);
	float game_alpha = game_color.a;
	float is_fg = step(alpha_threshold, game_alpha); //1.0 if foreground, 0.0 if background
	COLOR = vec4(is_fg, is_fg, is_fg, 1.0);
}