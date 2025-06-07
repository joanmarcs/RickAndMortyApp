//
//  File.swift
//  Presentation
//
//  Created by Joan Marc Sanahuja on 7/6/25.
//

import Foundation
import SwiftUI
import UIKit

public struct ActivityView: UIViewControllerRepresentable {
    public var activityItems: [Any]
    public var applicationActivities: [UIActivity]? = nil

    public func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
    }

    public func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
