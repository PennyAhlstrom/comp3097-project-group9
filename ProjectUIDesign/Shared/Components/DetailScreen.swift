//
//  DetailScreen.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-08.
//

import SwiftUI

struct DetailScreen<Content: View>: View {
    let background: Color
    @ViewBuilder let content: () -> Content

    var body: some View {
        ZStack {
            background
                .ignoresSafeArea()

            Group {
                content()
            }
            .scrollContentBackground(.hidden)
        }
    }
}
