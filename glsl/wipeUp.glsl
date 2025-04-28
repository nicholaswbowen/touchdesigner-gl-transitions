// Author: Jake Nelson
// License: MIT

uniform float progress;

out vec4 fragColor;

vec4 transition () {
    vec2 p = vUV.xy/vec2(1.0).xy;
    vec4 a = texture(sTD2DInputs[0], p);
    vec4 b = texture(sTD2DInputs[1], p);
    
    return mix(a, b, step(0.0+p.y,progress));
}

void main()
{
	// vec4 color = texture(sTD2DInputs[0], vUV.st);
	vec4 color = transition();
	fragColor = TDOutputSwizzle(color);
}
