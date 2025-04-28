// author: gre
// license: MIT

uniform float progress;

out vec4 fragColor;

vec4 transition () {
  return mix(
    texture(sTD2DInputs[0], vUV.st),
    texture(sTD2DInputs[1], vUV.st),
    progress
  );
}

void main()
{
	// vec4 color = texture(sTD2DInputs[0], vUV.st);
	vec4 color = transition();
	fragColor = TDOutputSwizzle(color);
}
