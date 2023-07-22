// SPDX-FileCopyrightText: turtle

// SPDX-License-Identifier: CC0-1.0

// https://godotshaders.com/shader/rainbow/
shader_type spatial;
render_mode unshaded;

uniform float density: hint_range(0.0, 10.0) = 0.25;
uniform float speed: hint_range(0.0, 10.0) = .4;

varying vec3 _vertex;

vec3 hsv2rgb(vec3 c) {
	vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
	vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
	return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void vertex(){
	_vertex = VERTEX;
}

void fragment() {
	ALBEDO = hsv2rgb(vec3(_vertex.z * density - TIME * speed, 1.0, 1.0));
}