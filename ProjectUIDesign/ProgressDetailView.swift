//
//  ProgressDetailView.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-03.
//

import SwiftUI

struct ProgressDetailView: View {
    @EnvironmentObject var store: AppStore
    let progressID: UUID

    @State private var showEdit = false
    @State private var showDeleteConfirm = false

    private var progress: Progress? { store.progresses.first { $0.id == progressID } }

    var body: some View {
        Group {
            if let progress {
                List {
                    Section("Week") {
                        DetailRow(
                            label: "Week Of",
                            value: progress.weekOf.yyyyMMdd // from DateFormat
                        )
                    }

                    Section("Percent Points") {
                        // used DoubleFormadt for number formatting
                        DetailRow(label: "Accumulated",  value: progress.accumulatedPercentPoints.whole)
                        DetailRow(label: "Used", value: progress.usedPercentPoints.whole)
                        DetailRow(label: "Lost", value: progress.lostPercentPoints.whole)
                        DetailRow(label: "Max Possible", value: progress.maxPossiblePercent.percent)
                    }

                    Section("Status") {
                        DetailRow(label: "Current Grade", value: progress.currentGradePercent.percent)
                        DetailRow(label: "Can Meet Goal", value: progress.canMeetGoal ? "Yes" : "No")
                    }
                }
                .navigationTitle("Progress")
                
            } else {
                Text("Progress not found.")
                    .foregroundColor(.secondary)
                    .navigationTitle("Progress")
            }
        }
    }
}

//#Preview {
//    NavigationStack { ProgressDetailView(progress: Progress.sampleProgresses[0]) }
//}

#Preview {
    let store = AppStore()
    return NavigationStack {
        ProgressDetailView(progressID: store.progresses.first!.id)
    }
    .environmentObject(store)
}
