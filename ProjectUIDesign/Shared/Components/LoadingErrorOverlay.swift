//
//  LoadingErrorOverlay.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-04-14.
//

import SwiftUI

struct LoadingErrorOverlay: View {
    let isLoading: Bool
    let errorMessage: String?
    let onRetry: (() -> Void)?

    var body: some View {
        ZStack {
            if isLoading {
                Color.black.opacity(0.2)
                    .ignoresSafeArea()

                ProgressView("Loading...")
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }

            if let errorMessage, !errorMessage.isEmpty {
                VStack(spacing: 12) {
                    Spacer()

                    Text(errorMessage)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)

                    if let onRetry {
                        Button("Retry") {
                            onRetry()
                        }
                        .buttonStyle(.borderedProminent)
                    }

                    Spacer()
                }
                .padding()
                .background(Color.red.opacity(0.9))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding()
            }
        }
        .animation(.easeInOut(duration: 0.2), value: isLoading)
        .animation(.easeInOut(duration: 0.2), value: errorMessage)
    }
}
