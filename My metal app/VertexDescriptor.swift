//
//  VertexDescriptor.swift
//  My metal app
//
//  Created by Куделин Виктор on 06.05.2023.
//

import MetalKit

private enum Index: Int {
    case position = 0
    case color = 1
}

extension MTLVertexDescriptor {
    static var defaultLayout: MTLVertexDescriptor {
        let vertexDescriptor = MTLVertexDescriptor()

        let positionIndex = Index.position.rawValue
        let colorIndex = Index.color.rawValue

        vertexDescriptor.attributes[positionIndex].format = .float3
        vertexDescriptor.attributes[positionIndex].offset = 0
        vertexDescriptor.attributes[positionIndex].bufferIndex = 0

        vertexDescriptor.attributes[colorIndex].format = .float3
        vertexDescriptor.attributes[colorIndex].offset = 0
        vertexDescriptor.attributes[colorIndex].bufferIndex = 1

        let positionStride = MemoryLayout<Float>.stride * 3
        vertexDescriptor.layouts[positionIndex].stride = positionStride

        let colorStride = MemoryLayout<simd_float3>.stride
        vertexDescriptor.layouts[colorIndex].stride = colorStride

        return vertexDescriptor
    }
}
