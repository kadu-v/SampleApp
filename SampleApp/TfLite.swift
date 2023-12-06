//
//  ViewController.swift
//  SampleApp
//
//  Created by 池守和槻 on 2023/12/06.
//

import Foundation
import SwiftUI

public func tryMeayOp() {
    guard let modelPath = Bundle.main.path(forResource: "mean_only", ofType: ".tflite") else {
        print("faied to load the model file with name")
        return
    }
    let delegate = CoreMLDelegate()
    do {
        let interp = try Interpreter(modelPath: modelPath, delegates: [delegate!])
    } catch {
        print("Failed to allocate the Tensor of intputs/outputs with error: \(error.localizedDescription)")
        return
    }
}

@ViewBuilder public func dummyView() -> some View {
    Text("dummy").onAppear { tryMeayOp() }
}
