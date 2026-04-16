//
//  ListScreen.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-08.
//

import SwiftUI

struct ListScreen<Content: View>: View {
    let title: String
    let background: Color
    @ViewBuilder let content: () -> Content
    
    init(
            title: String = "ClassMate", // Default title
            background: Color,
            @ViewBuilder content: @escaping () -> Content
        ) {
            self.title = title
            self.background = background
            self.content = content
        }

    var body: some View {
        ZStack {
            background
                .ignoresSafeArea()

            List {
                content()
            }
            .scrollContentBackground(.hidden)
        }
        .safeAreaInset(edge: .top) {
            Text(title)
                .font(.title.weight(.semibold))
                .frame(maxWidth: .infinity)
                .padding(.top, 2)
                .padding(.bottom, 4)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
