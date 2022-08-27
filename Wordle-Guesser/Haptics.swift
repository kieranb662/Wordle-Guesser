// Swift toolchain version 5.0
// Running macOS version 12.5
// Created on 8/27/22.
//
// Author: Kieran Brown
//

import UIKit


// MARK: - Haptic Generator

/// Interface for all haptic generators.
///
/// ## Pattern
///
/// Add new haptics as global constants with the first letter capitalized and ending with the suffix Haptic.
///
/// ```
///  let LightImpactHaptic = HapticGenerator(generator: {
///      let generator = UIImpactFeedbackGenerator(style: .light)
///      generator.impactOccurred()
///  })
///
///  // Then use like this.
///  LightImpactHaptic()  // We are making use of the callAsFunction feature introduced in swift 5.2
/// ```
///
/// - important: This API uses the callAsFunction swift feature. So the `HapticGenerator` instances all can be played by
/// calling the instance as a function.
///
struct HapticGenerator {
    typealias Generator = () -> Void
    private let generator: Generator
    
    init(generator: @escaping Generator) {
        self.generator = generator
    }
}

// MARK: - Call As Function

extension HapticGenerator {
    func callAsFunction() {
        self.generator()
    }
}

// MARK: - Builtin Frameworks


let LightImpactHaptic = HapticGenerator(generator: {
    let generator = UIImpactFeedbackGenerator(style: .light)
    generator.impactOccurred()
})

let MediumImpactHaptic = HapticGenerator(generator: {
    let generator = UIImpactFeedbackGenerator(style: .medium)
    generator.impactOccurred()
})

let RigidImpactHaptic = HapticGenerator(generator: {
    let generator = UIImpactFeedbackGenerator(style: .rigid)
    generator.impactOccurred()
})

let SuccessHaptic = HapticGenerator(generator: {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.success)
})

let WarningHaptic = HapticGenerator(generator: {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.warning)
})

let ErrorHaptic = HapticGenerator(generator: {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.error)
})

let SelectionHaptic = HapticGenerator(generator: {
    let generator = UISelectionFeedbackGenerator()
    generator.selectionChanged()
})

