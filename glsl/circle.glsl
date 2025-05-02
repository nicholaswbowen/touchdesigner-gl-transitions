// Author: Fernando Kuteken
// License: MIT

uniform vec2 center; // = vec2(0.5, 0.5);
uniform vec3 backColor; // = vec3(0.1, 0.1, 0.1);

uniform float progress;

out vec4 fragColor;

vec4 transition () {
    float distance = length(vUV.st - center);
    float radius = sqrt(8.0) * abs(progress - 0.5);

    if (distance > radius) {
        return vec4(backColor, 1.0);
    }
    else {
        if (progress < 0.5) return texture(sTD2DInputs[0] , vUV.st);
        else return texture(sTD2DInputs[1] , vUV.st);
    }
}

void main() {
    vec4 color = transition();
    fragColor = TDOutputSwizzle(color);
}