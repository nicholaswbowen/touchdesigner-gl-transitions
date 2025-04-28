// Author: Mr Speaker
// License: MIT

uniform float speed; // = 2.0;

uniform float progress;

out vec4 fragColor;

vec4 transition() {
  
  vec2 p = vUV.xy / vec2(1.0).xy;
  
  float circPos = atan(p.y - 0.5, p.x - 0.5) + progress * speed;
  float modPos = mod(circPos, 3.1415 / 4.);
  float signed = sign(progress - modPos);
  
  return mix(texture(sTD2DInputs[0], vUV.st), texture(sTD2DInputs[1], vUV.st), step(signed, 0.5));
  
}

void main()
{
	vec4 color = transition();
	fragColor = TDOutputSwizzle(color);
}




