// author: gre
// License: MIT
uniform float smoothness; // = 0.3
uniform bool opening; // = true

const vec2 center = vec2(0.5, 0.5);
const float SQRT_2 = 1.414213562373;

uniform float progress;

out vec4 fragColor;

vec4 transition () {
    float x = opening ? progress : 1.-progress;
    float m = smoothstep(-smoothness, 0.0, SQRT_2*distance(center, vUV.st) - x*(1.+smoothness));
    return mix(texture(sTD2DInputs[0] , vUV.st), texture(sTD2DInputs[1] , vUV.st), opening ? 1.-m : m);
}

void main() {
    vec4 color = transition();
    fragColor = TDOutputSwizzle(color);
}