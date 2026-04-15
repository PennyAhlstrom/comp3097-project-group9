//
//  ToastView.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-04-14.
//

import SwiftUI

struct ToastView: View {
    let message: String

    var body: some View {
        VStack {
            Spacer()

            Text(message)
                .font(.subheadline.weight(.semibold))
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(.black.opacity(0.85))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.bottom, 24)
        }
        .padding(.horizontal)
        .transition(.move(edge: .bottom).combined(with: .opacity))
    }
}
