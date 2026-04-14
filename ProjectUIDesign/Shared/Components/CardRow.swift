//
//  CardRow.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-08.
//

import SwiftUI

struct CardRow<Content: View>: View {
    let backgroundColor: Color
    @ViewBuilder let content: () -> Content
    
    init(
            backgroundColor: Color = Color(.systemBackground), // Default
            @ViewBuilder content: @escaping () -> Content
        ) {
            self.backgroundColor = backgroundColor
            self.content = content
        }
    
    var body: some View {
        content()
            .frame(maxWidth: .infinity, alignment: .leading) // Make sure the card takes the full width even if it does not have content for it
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    //.fill(Color.white)
//                    .fill(Color(.systemBackground)) // used to adapt to dark/light mode
                    .fill(backgroundColor)
                    .shadow(color: .black.opacity(0.08), radius: 6, y: 3)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.black.opacity(0.04), lineWidth: 1)
            )
            .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
    }
}
