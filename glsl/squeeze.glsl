// Author: gre
// License: MIT

uniform float colorSeparation; // = 0.04

uniform float progress;

out vec4 fragColor;

vec4 transition () {
    float y = 0.5 + (vUV.y-0.5) / (1.0-progress);
    if (y < 0.0 || y > 1.0) {
        return texture(sTD2DInputs[1] , vUV.st);
    }
    else {
        vec2 fp = vec2(vUV.x, y);
        vec2 off = progress * vec2(0.0, colorSeparation);
        vec4 c = texture(sTD2DInputs[0],fp);
        vec4 cn = texture(sTD2DInputs[0],fp - off);
        vec4 cp = texture(sTD2DInputs[0],fp + off);
        return vec4(cn.r, c.g, cp.b, c.a);
    }
}

void main() {
    vec4 color = transition();
    fragColor = TDOutputSwizzle(color);
}