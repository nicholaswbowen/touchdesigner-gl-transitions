// Author: Eke Péter <peterekepeter@gmail.com>
// License: MIT


uniform float progress;

out vec4 fragColor;

vec4 transition () {
    vec2 p = vUV.xy/vec2(1.0).xy;
    vec4 a = texture(sTD2DInputs[0], p);
    vec4 b = texture(sTD2DInputs[1], p);

    float x = progress;
    x=smoothstep(.0,1.0,(x*2.0+p.x-1.0));
    return mix(texture(sTD2DInputs[0],(p-.5)*(1.-x)+.5), texture(sTD2DInputs[1],(p-.5)*x+.5), x);
  
}

void main()
{
	// vec4 color = texture(sTD2DInputs[0], vUV.st);
	vec4 color = transition();
	fragColor = TDOutputSwizzle(color);
}
