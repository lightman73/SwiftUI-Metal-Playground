//
//  Shaders.metal
//  SwiftUIMetalPlayground
//
//  Created by Francesco Marini on 05/10/23.
//

#include <metal_stdlib>
using namespace metal;


[[ stitchable ]] half4 mandelbrot(float2 position, half4 color, float2 size, float time) {
    int maxIterations = 256;

    float2 uv = position / size;
    float aspectRatio = size.x/size.y;
    float span = 3.0;
    float2 c = float2(uv.x * span * aspectRatio - span * aspectRatio / 2.0 - 0.5,
                      uv.y * span - span / 2.0);
    float2 z = float2(0, 0);

//    float2 c = float2(-0.5 + cos(time/2.0) / 20.0, 0.5 + sin(time/2.0) / 20);

    float it = 0.0;
    for (int i = 0; i < maxIterations; ++i) {
        z = float2(z.x * z.x - z.y * z.y, 2.0 * z.x * z.y) + c;

        if (dot(z,z) > 4.0) break;

        it += 1.0;
    }

    if (it < float(maxIterations)) {
        // Static coloring
//        return half4(sin(it / 3.0), cos(it / 6.0), cos(it / 12.0 + 3.14 / 4.0), 1.0);

        // Time-dependent smooth-ish coloring
        float sl = it - log2(log2(dot(z,z))) + 4.0;
        float3 col = 0.7 + 0.3 * cos( 3.0 + sl * time / 4.0 + float3(0.3, 0.6, 1.0));
        return half4(col.x, col.y, col.z, 1.0);
    }

    return half4(0.0, 0.0, 0.0, 1.0);
}
