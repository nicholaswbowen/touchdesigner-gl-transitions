// Author: mandubian
// License: MIT

uniform float a; // = 4
uniform float b; // = 1
uniform float amplitude; // = 120
uniform float smoothness; // = 0.1

uniform float progress;

out vec4 fragColor;

vec4 transition() {
    vec2 p = vUV.xy / vec2(1.0).xy;
    vec2 dir = p - vec2(.5);
    float dist = length(dir);
    float x = (a - b) * cos(progress) + b * cos(progress * ((a / b) - 1.));
    float y = (a - b) * sin(progress) - b * sin(progress * ((a / b) - 1.));
    vec2 offset = dir * vec2(sin(progress  * dist * amplitude * x), sin(progress * dist * amplitude * y)) / smoothness;
    return mix(texture(sTD2DInputs[0], p + offset), texture(sTD2DInputs[1], p), smoothstep(0.2, 1.0, progress));
}

void main() {
    vec4 color = transition();
    fragColor = TDOutputSwizzle(color);
}