//
//  ListScreen.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-08.
//

import SwiftUI

struct ListScreen<Content: View>: View {
    let title: String
    @ViewBuilder let content: () -> Content

    var body: some View {
        List {
            content()
        }
        .safeAreaInset(edge: .top) {
            Text(title)
                .font(.title2.weight(.semibold))
                .frame(maxWidth: .infinity)
                .padding(.top, 4)
                .padding(.bottom, 8)
                .background(.background)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                EmptyView()
            }
        }
    }
}
