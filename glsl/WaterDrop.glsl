// author: Paweł Płóciennik
// license: MIT

uniform float progress;

out vec4 fragColor;

uniform float amplitude; // = 30
uniform float speed; // = 30

vec4 transition() {
    vec2 p = vUV.xy/vec2(1.0).xy;
    vec2 dir = p - vec2(.5);
    float dist = length(dir);

    if (dist > progress) {
        return mix(texture(sTD2DInputs[0], p), texture(sTD2DInputs[1], p), progress);
    } else {
        vec2 offset = dir * sin(dist * amplitude - progress * speed);
        return mix(texture(sTD2DInputs[0], p + offset), texture(sTD2DInputs[1], p), progress);
    }
}

void main() {
    vec4 color = transition();
    fragColor = TDOutputSwizzle(color);
}
