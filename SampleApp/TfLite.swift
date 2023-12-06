//
//  ViewController.swift
//  SampleApp
//
//  Created by 池守和槻 on 2023/12/06.
//

import AVFoundation
import Foundation
import SwiftUI
import Vision

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    private let inferenceQueue = DispatchQueue(label: "inferenceQueue")

    override func viewDidLoad() {
        super.viewDidLoad()
        inferenceQueue.async { [unowned self] in
            self.tryMeayOp()
        }
    }

    public func tryMeayOp() {
        guard let modelPath = Bundle.main.path(forResource: "mean_only", ofType: ".tflite") else {
            print("faied to load the model file with name")
            return
        }
        let delegate = CoreMLDelegate()
        let interpreter: Interpreter
        do {
            interpreter = try Interpreter(modelPath: modelPath, delegates: [delegate!])
        } catch {
            print("Failed to allocate the Tensor of intputs/outputs with error: \(error.localizedDescription)")
            return
        }
        var input = Array(repeating: Float32(1.0), count: 1 * 10 * 10 * 3)
        for i in 0..<10 {
            for j in 0..<10 {
                if i < 5 {
                    input[3 * (10 * i + j) + 0] = 4
                } else {
                    input[3 * (10 * i + j) + 0] = 10
                }
                input[3 * (10 * i + j) + 1] = 1
                input[3 * (10 * i + j) + 2] = 2
            }
        }

        for i in 0..<1 * 10 * 10 * 3 {
            print(input[i])
        }
        let data = Data(copyingBufferOf: input)
        let tensor: Tensor
        do {
            try interpreter.copy(data, toInputAt: 0)
            try interpreter.invoke()
            tensor = try interpreter.output(at: 0)
        } catch {
            print("Failed to invoke interpreter: \(error)")
            return
        }
        print(tensor.data.count)
        let output = FlatArray<Float32>(tensor: tensor)
        print(output.dimensions)
        for i in 0..<10 {
            for j in 0..<10 {
                print("\(i), \(j), \(output[0, i, j, 0])")
            }
        }
    }
}

struct HostedViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return ViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
