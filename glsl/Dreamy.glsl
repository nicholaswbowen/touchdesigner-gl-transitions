// Author: mikolalysenko
// License: MIT

uniform float progress;

out vec4 fragColor;

vec2 offset(float progress, float x, float theta) {
    float phase = progress * progress + progress + theta;
    float shifty = 0.03 * progress * cos(10.0 * (progress + x));
    return vec2(0, shifty);
}
vec4 transition() {
    vec2 p = vUV.xy / vec2(1.0).xy;
    return mix(texture(sTD2DInputs[0], p + offset(progress, p.x, 0.0)), texture(sTD2DInputs[1], p + offset(1.0 - progress, p.x, 3.14)), progress);
}

void main() {
    vec4 color = transition();
    fragColor = TDOutputSwizzle(color);
}