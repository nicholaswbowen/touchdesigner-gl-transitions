// Author: 0gust1
// License: MIT
uniform float progress;

out vec4 fragColor;

uniform float zoom_quickness; // = 0.8
float nQuick = clamp(zoom_quickness,0.2,1.0);

vec2 zoom(vec2 uv, float amount) {
    return 0.5 + ((uv - 0.5) * (1.0-amount));
}

vec4 transition () {
    return mix(
        texture(sTD2DInputs[0], zoom(vUV.xy, smoothstep(0.0, nQuick, progress))),
        texture(sTD2DInputs[1] , vUV.st),
        smoothstep(nQuick-0.2, 1.0, progress));
}

void main() {
    vec4 color = transition();
    fragColor = TDOutputSwizzle(color);
}