//
//  ViewController.swift
//  My metal app
//
//  Created by Куделин Виктор on 29.01.2023.
//

import UIKit
import MetalKit

final class ViewController: UIViewController {

    // MARK: Private properties

    private var renderer: Renderer?
    private let metalView = MTKView()
}

// MARK: - UIViewController life cycle

extension ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        setup()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupMetalView()
    }
}

// MARK: - Private methods

private extension ViewController {

    func layout() {
        view.addSubview(metalView)
        metalView.translatesAutoresizingMaskIntoConstraints = false

        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            metalView.heightAnchor.constraint(equalToConstant: 300),
            metalView.widthAnchor.constraint(equalToConstant: 300),
            metalView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            metalView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    func setup() {
        view.backgroundColor = .systemIndigo

        metalView.clipsToBounds = true
        metalView.layer.cornerRadius = 12
        metalView.layer.borderWidth = 4
        metalView.layer.borderColor = UIColor.black.cgColor
    }

    func setupMetalView() {
        let metalHandler = MTLHandler()

        do {

            let device = try metalHandler.makeDevice()
            let commandQueue = try metalHandler.makeCommandQueue(device: device)
            let pipelineState = try metalHandler.makePipelineState(
                device: device,
                metalView: metalView
            )

            renderer = Renderer(
                device: device,
                commandQueue: commandQueue,
                pipelineState: pipelineState
            )

            metalView.device = device
            metalView.delegate = renderer
        } catch {
            showError(descriptoin: error.localizedDescription)
        }
    }

    func showError(descriptoin: String) {
        let alert = UIAlertController(title: "Error", message: descriptoin, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}
