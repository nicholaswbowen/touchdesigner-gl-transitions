// Author: gre
// License: MIT

uniform float count; // = 10.0
uniform float smoothness; // = 0.5
uniform float progress;

out vec4 fragColor;

vec4 transition () {
  float pr = smoothstep(-smoothness, 0.0, vUV.x - progress * (1.0 + smoothness));
  float s = step(pr, fract(count * vUV.x));
  return mix(texture(sTD2DInputs[0], vUV.st), texture(sTD2DInputs[1], vUV.st), s);
}

void main()
{
	vec4 color = transition();
	fragColor = TDOutputSwizzle(color);
}