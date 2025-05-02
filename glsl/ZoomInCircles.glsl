// License: MIT
// Author: dycm8009
// WebGL version was ported by gre from https://gist.github.com/dycm8009/948e99b1800e81ad909a

// The ported Webgl version wasn't playing nicely with TD, so I went back to the original GLSL version linked above and that seemed to port easier. - Nicholas Bowen

uniform float progress;
out vec4 fragColor;

vec2 res = uTD2DInfos[0].res.zw;

vec2 zoom(vec2 uv, float amount) {
    return 0.5 + ((uv - 0.5) * amount);
}

void main() {
    vec2 uv = gl_FragCoord.xy / res.xy;
    vec2 r =  2.0*vec2(gl_FragCoord.xy - 0.5*res.xy)/res.y;
    float pro = progress / 0.8;
    float z = (pro) * 0.2;
    float t = 0.0;
    if (pro > 1.0) {
        z = 0.2 + (pro - 1.0) * 5.;
        t = clamp((progress - 0.8) / 0.07,0.0,1.0);
    }
    if (length(r) < 0.5+z) {
        //uv = zoom(uv, 0.9 - 0.1 * pro);
    }
    else if (length(r) < 0.8+z*1.5) {
        uv = zoom(uv, 1.0 - 0.15 * pro);
        t = t * 0.5;
    }
    else if (length(r) < 1.2+z*2.5) {
        uv = zoom(uv, 1.0 - 0.2 * pro);
        t = t * 0.2;
    }
    else
    uv = zoom(uv, 1.0 - 0.25 * pro);
    fragColor = mix(texture(sTD2DInputs[0], vUV.st), texture(sTD2DInputs[1], vUV.st), t);
}