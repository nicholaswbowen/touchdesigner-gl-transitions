// License: MIT
// Author: P-Seebauer
// ported by gre from https://gist.github.com/P-Seebauer/2a5fa2f77c883dd661f9

uniform float power; // = 5.0

uniform float progress;

out vec4 fragColor;

vec4 transition() {

  vec2 p = vUV.xy/vec2(1.0).xy;
  vec4 fTex = texture(sTD2DInputs[0], p);
  vec4 tTex = texture(sTD2DInputs[1], p);
  float m = step(distance(fTex, tTex), progress);
  return mix(
    mix(fTex, tTex, m),
    tTex,
    pow(progress, power)
  );
}

void main()
{
	// vec4 color = texture(sTD2DInputs[0], vUV.st);
	vec4 color = transition();
	fragColor = TDOutputSwizzle(color);
}