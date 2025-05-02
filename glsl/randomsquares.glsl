// Author: gre
// License: MIT

uniform vec2 size; // = ivec2(10, 10)
uniform float smoothness; // = 0.5

uniform float progress;

out vec4 fragColor;

float rand (vec2 co) {
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

vec4 transition() {
    vec2 p = vUV.xy/vec2(1.0).xy;
    float r = rand(floor(vec2(size) * p));
    float m = smoothstep(0.0, -smoothness, r - (progress * (1.0 + smoothness)));
    return mix(texture(sTD2DInputs[0], p), texture(sTD2DInputs[1], p), m);
}

void main() {
    vec4 color = transition();
    fragColor = TDOutputSwizzle(color);
}