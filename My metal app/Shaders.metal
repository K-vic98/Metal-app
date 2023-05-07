//
//  Shaders.metal
//  My metal app
//
//  Created by Куделин Виктор on 05.02.2023.
//

#include <metal_stdlib>
using namespace metal;

struct VertexIn {
    float4 position [[attribute(0)]];
    float4 color [[attribute(1)]];
};

struct VertexOut {
    float4 position [[position]];
    float4 color;
};

vertex VertexOut vertex_main(VertexIn in [[stage_in]]) {
    VertexOut out {
        .position = in.position,
        .color = in.color
    };
    return out;
}

fragment float4 fragment_main(VertexOut in [[stage_in]]) {
    return in.color;
}
