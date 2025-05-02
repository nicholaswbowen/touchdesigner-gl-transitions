// Author: Fernando Kuteken
// License: MIT

#define PI 3.14159265359

uniform int segments; // = 5;

uniform float progress;

out vec4 fragColor;

vec4 transition () {
    float angle = atan(vUV.y - 0.5, vUV.x - 0.5) - 0.5 * PI;
    float normalized = (angle + 1.5 * PI) * (2.0 * PI);

    float radius = (cos(float(segments) * angle) + 4.0) / 4.0;
    float difference = length(vUV.st - vec2(0.5, 0.5));

    if (difference > radius * progress)
    return texture(sTD2DInputs[0] , vUV.st);
    else
    return texture(sTD2DInputs[1] , vUV.st);
}

void main() {
    vec4 color = transition();
    fragColor = TDOutputSwizzle(color);
}