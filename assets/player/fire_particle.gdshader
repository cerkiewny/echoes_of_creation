shader_type particles;

float random (vec2 uv) {
    return fract(sin(dot(uv.xy,
        vec2(12.9898,78.233))) * 43758.5453123);
}
void process() {
	
	float rand = random(vec2( float(NUMBER), 0.0f));
	VELOCITY.x = rand*30.0;
}
