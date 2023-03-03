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
};

vertex float4 vertex_main(const VertexIn vertexIn [[stage_in]]) {
    float4 position = vertexIn.position;
    position.y -= 1.0;
    return vertexIn.position;
}

fragment float4 fragment_main() {
  return float4(1, 0, 0, 1);
}
