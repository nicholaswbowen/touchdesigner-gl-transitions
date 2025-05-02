// Author: gre
// License: MIT

uniform vec2 direction; // = vec2(1.0, -1.0)
uniform float smoothness; // = 0.5

const vec2 center = vec2(0.5, 0.5);

uniform float progress;

out vec4 fragColor;

vec4 transition () {
    vec2 v = normalize(direction);
    v /= abs(v.x)+abs(v.y);
    float d = v.x * center.x + v.y * center.y;
    float m =
    (1.0-step(progress, 0.0)) * // there is something wrong with our formula that makes m not equals 0.0 with progress is 0.0
    (1.0 - smoothstep(-smoothness, 0.0, v.x * vUV.x + v.y * vUV.y - (d-0.5+progress*(1.+smoothness))));
    return mix(texture(sTD2DInputs[0] , vUV.st), texture(sTD2DInputs[1] , vUV.st), m);
}

void main() {
    vec4 color = transition();
    fragColor = TDOutputSwizzle(color);
}