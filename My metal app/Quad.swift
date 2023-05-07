//
//  Quad.swift
//  My metal app
//
//  Created by Куделин Виктор on 05.05.2023.
//

import MetalKit

struct Quad {

    // MARK: Private properties

    let vertexBuffer: MTLBuffer
    let indexBuffer: MTLBuffer
    let colorBuffer: MTLBuffer

    let vertices: [Float] = [-1, 1, 0, 1, 1, 0, -1, -1, 0, 1, -1, 0]
    let indices: [UInt16] = [0, 3, 2, 0, 1, 3]
    let colors: [simd_float3] = [
        [1, 0, 0],
        [0, 1, 0],
        [0, 0, 1],
        [1, 1, 0]
    ]

    init?(device: MTLDevice, scale: Float = 1) {

        guard let vertexBuffer = device.makeBuffer(
            bytes: &vertices,
            length: MemoryLayout<Float>.stride * vertices.count
        ) else {
            return nil
        }

        guard let indexBuffer = device.makeBuffer(
            bytes: &indices,
            length: MemoryLayout<UInt16>.stride * indices.count
        ) else {
            return nil
        }

        guard let colorBuffer = device.makeBuffer(
            bytes: &colors,
            length: MemoryLayout<simd_float3>.stride * indices.count
        ) else {
            return nil
        }

        self.vertexBuffer = vertexBuffer
        self.indexBuffer = indexBuffer
        self.colorBuffer = colorBuffer
    }
}
