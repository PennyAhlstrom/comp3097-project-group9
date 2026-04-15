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
    let onDemoMode: (() -> Void)?

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
                VStack(spacing: 16) {
                    Spacer()

                    VStack(spacing: 12) {
                        Text(errorMessage)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)

                        HStack(spacing: 12) {
                            if let onRetry {
                                Button("Retry") {
                                    onRetry()
                                }
                                .buttonStyle(.borderedProminent)
                            }

                            if let onDemoMode {
                                Button("Demo Mode") {
                                    onDemoMode()
                                }
                                .buttonStyle(.bordered)
                                .tint(.white)
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red.opacity(0.92))
                    .clipShape(RoundedRectangle(cornerRadius: 14))

                    Spacer()
                }
                .padding()
            }
        }
        .animation(.easeInOut(duration: 0.2), value: isLoading)
        .animation(.easeInOut(duration: 0.2), value: errorMessage)
    }
}
