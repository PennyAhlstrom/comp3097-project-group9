//
//  ProgressDetailView.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-03.
//

import SwiftUI

struct ProgressDetailView: View {
    @EnvironmentObject var store: AppStore
    let courseID: UUID

    @State private var selectedProgressID: UUID?

    var body: some View {
            let snapshots = store.progresses
                .filter { $0.courseID == courseID }
                .sorted { $0.weekOf > $1.weekOf }

            let selected = snapshots.first(where: { $0.id == selectedProgressID }) ?? snapshots.first

        Form {
                    Section("Snapshot") {
                        Picker("Week Of", selection: $selectedProgressID) {
                            ForEach(snapshots) { p in
                                Text(p.weekOf.formatted(.dateTime.year().month().day()))
                                    .tag(Optional(p.id))
                            }
                        }
                        .pickerStyle(.menu)
                    }
            
            if let progress = selected {
                List {
                    Section("Percent Points") {
                        // used DoubleFormat for number formatting
                        DetailRow(label: "Accumulated",  value: progress.accumulatedPercentPoints.whole)
                        DetailRow(label: "Lost", value: progress.lostPercentPoints.whole)
                        DetailRow(label: "Used", value: progress.usedPercentPoints.whole)

                    }

                    Section("Status") {
                        DetailRow(label: "Current Grade", value: progress.currentGradePercent.percent)
                        DetailRow(label: "Max Possible", value: progress.maxPossiblePercent.percent)
                        DetailRow(label: "Can Meet Goal", value: progress.canMeetGoal ? "Yes" : "No")
                    }
                }
                .navigationTitle("Progress")
                
            } else {
                Text("Progress not found.")
                    .foregroundColor(.secondary)
            }
        }
        .navigationTitle("Progress")
                .onAppear {
                    selectedProgressID = snapshots.first?.id // default to latest
                }
    }
}

//#Preview {
//    NavigationStack { ProgressDetailView(progress: Progress.sampleProgresses[0]) }
//}

#Preview {
    let store = AppStore()
    NavigationStack {
        ProgressDetailView(courseID: Course.SampleIDs.course1)
    }
    .environmentObject(store)
}
