// Author: gre
// License: MIT

uniform sampler2D luma;
uniform float progress;

out vec4 fragColor;

vec4 transition () {
  return mix(
    texture(sTD2DInputs[0], vUV.st),
    texture(sTD2DInputs[1], vUV.st),
    step(progress, texture(sTD2DInputs[2], vUV.st).r)
  );
}

void main()
{
	// vec4 color = texture(sTD2DInputs[0], vUV.st);
	vec4 color = transition();
	fragColor = TDOutputSwizzle(color);
}
