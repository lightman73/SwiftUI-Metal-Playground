//
//  ContentView.swift
//  SwiftUIMetalPlayground
//
//  Created by Francesco Marini on 05/10/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.screenSize) private var screenSize

    let startDate = Date()

    var body: some View {
        TimelineView(.animation) { context in
            ZStack {
                Rectangle()
                    .fill(Color.blue)
                    .ignoresSafeArea()
                    .frame(width: screenSize.width, height: screenSize.height)
                    .colorEffect(ShaderLibrary.mandelbrot(.float2(screenSize.width, screenSize.height), .float(startDate.timeIntervalSinceNow)))
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}


extension EnvironmentValues {
    var screenSize: CGRect {
        self[ScreenSizeKey.self]
    }
}


private struct ScreenSizeKey: EnvironmentKey {
    static var defaultValue: CGRect {
        UIScreen.main.bounds
    }
}
