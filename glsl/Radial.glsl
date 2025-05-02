// License: MIT
// Author: Xaychru
// ported by gre from https://gist.github.com/Xaychru/ce1d48f0ce00bb379750

uniform float smoothness; // = 1.0

const float PI = 3.141592653589;
uniform float progress;

out vec4 fragColor;

vec4 transition() {

vec2 p = vUV.xy/vec2(1.0).xy;
  vec2 rp = p*2.-1.;
  return mix(
    texture(sTD2DInputs[1], p),
    texture(sTD2DInputs[0], p),
    smoothstep(0., smoothness, atan(rp.y,rp.x) - (progress-.5) * PI * 2.5)
  );
}

void main()
{
	vec4 color = transition();
	fragColor = TDOutputSwizzle(color);
}