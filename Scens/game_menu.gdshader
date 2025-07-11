shader_type canvas_item;

uniform float time_speed = 0.5;
uniform float glitch_intensity = 0.015;
uniform float line_thickness = 3.5;

uniform vec4 base_color1 : source_color = vec4(0.2, 0.3, 0.4, 1.0); // мягкий синий
uniform vec4 base_color2 : source_color = vec4(0.1, 0.15, 0.2, 1.0); // глубокий фиолет
uniform vec4 scanline_color : source_color = vec4(0.8, 0.8, 0.8, 0.08); // почти прозрачный белый

float rand(vec2 co) {
	return fract(sin(dot(co.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment() {
	vec2 uv = UV;

	// мягкое движение фона
	float wave = sin(uv.y * 10.0 + TIME * time_speed) * 0.02;
	uv.x += wave;

	// случайные глитчи (резкие сдвиги)
	float glitch = step(0.98, rand(vec2(TIME * 3.0, uv.y))) * glitch_intensity;
	uv.x += glitch;

	// основной градиентный фон
	vec4 col = mix(base_color1, base_color2, uv.y + 0.1 * sin(TIME + uv.x * 10.0));

	// VHS горизонтальные сканлайны
	float scanline = sin(uv.y * 1000.0) * 0.5 + 0.5;
	scanline = pow(scanline, 15.0); // усиление контраста
	col.rgb -= scanline * scanline_color.rgb;

	// лёгкий шум
	float noise = rand(uv * 50.0 + TIME * 0.5);
	col.rgb += noise * 0.01;

	COLOR = col;
}
