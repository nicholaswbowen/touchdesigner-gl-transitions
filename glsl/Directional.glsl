// Author: Gaëtan Renaudeau
// License: MIT

uniform vec2 direction; // = vec2(0.0, 1.0)
uniform float progress;

out vec4 fragColor;

vec4 transition () {
  vec2 p = vUV.st + progress * sign(direction);
  vec2 f = fract(p);
  return mix(
    texture(sTD2DInputs[0], vUV.st),
    texture(sTD2DInputs[1], vUV.st),
    step(0.0, p.y) * step(p.y, 1.0) * step(0.0, p.x) * step(p.x, 1.0)
  );
}

void main()
{
	vec4 color = transition();
	fragColor = TDOutputSwizzle(color);
}