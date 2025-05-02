// Author: nwoeanhinnogaehr
// License: MIT

uniform float speed; // = 1.0;
uniform float angle; // = 1.0;
uniform float power; // = 1.5;

uniform float progress;

out vec4 fragColor;

vec4 transition() {
    vec2 p = vUV.xy / vec2(1.0).xy;
    vec2 q = p;
    float t = pow(progress, power)*speed;
    p = p -0.5;
    for (int i = 0; i < 7; i++) {
        p = vec2(sin(t)*p.x + cos(t)*p.y, sin(t)*p.y - cos(t)*p.x);
        t += angle;
        p = abs(mod(p, 2.0) - 1.0);
    }
    abs(mod(p, 1.0));
    return mix(
        mix(texture(sTD2DInputs[0], q), texture(sTD2DInputs[1], q), progress),
        mix(texture(sTD2DInputs[0], p), texture(sTD2DInputs[1], p), progress), 1.0 - 2.0*abs(progress - 0.5));
}

void main() {
    vec4 color = transition();
    fragColor = TDOutputSwizzle(color);
}