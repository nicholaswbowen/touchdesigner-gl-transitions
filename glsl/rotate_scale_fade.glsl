// Author: Fernando Kuteken
// License: MIT

#define PI 3.14159265359

uniform vec2 center; // = vec2(0.5, 0.5);
uniform float rotations; // = 1;
uniform float scale; // = 8;
uniform vec4 backColor; // = vec4(0.15, 0.15, 0.15, 1.0);

uniform float progress;

out vec4 fragColor;

vec4 transition () {
    vec2 difference = vUV.st - center;
    vec2 dir = normalize(difference);
    float dist = length(difference);

    float angle = 2.0 * PI * rotations * progress;

    float c = cos(angle);
    float s = sin(angle);

    float currentScale = mix(scale, 1.0, 2.0 * abs(progress - 0.5));

    vec2 rotatedDir = vec2(dir.x  * c - dir.y * s, dir.x * s + dir.y * c);
    vec2 rotatedUv = center + rotatedDir * dist / currentScale;

    if (rotatedUv.x < 0.0 || rotatedUv.x > 1.0 ||
        rotatedUv.y < 0.0 || rotatedUv.y > 1.0)
    return backColor;

    return mix(texture(sTD2DInputs[0], rotatedUv), texture(sTD2DInputs[1], rotatedUv), progress);
}

void main() {
    vec4 color = transition();
    fragColor = TDOutputSwizzle(color);
}