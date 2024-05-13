shader_type sky;

uniform vec3 skyColour : source_color;

void sky() {
	// Called for every visible pixel in the sky background, as well as all pixels
	// in the radiance cubemap.
	COLOR = skyColour;
}
