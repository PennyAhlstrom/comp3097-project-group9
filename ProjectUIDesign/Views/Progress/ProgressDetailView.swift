//
//  ProgressDetailView.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-03.
//

import SwiftUI
import Charts

struct ProgressDetailView: View {
    @EnvironmentObject var store: AppStore
    let courseID: Int

    @State private var selectedProgressID: Int?

    var body: some View {
        let snapshots = store.progresses
            .filter { $0.courseID == courseID }
            .sorted { $0.weekOf < $1.weekOf }

        let selected = snapshots.first(where: { $0.id == selectedProgressID }) ?? snapshots.last

        DetailScreen(background: .progressBackground) {
            Form {
                Section("Progress") {
                    Picker("Week of:", selection: $selectedProgressID) {
                        ForEach(snapshots) { progress in
                            Text(progress.weekOf.formatted(.dateTime.year().month().day()))
                                .tag(Optional(progress.id))
                        }
                    }
                    .pickerStyle(.menu)
                }

                Section("History") {
                    ProgressChartView(
                        snapshots: snapshots,
                        selectedProgressID: selectedProgressID
                    )
                }

                if let progress = selected {
                    List {
                        Section("Status") {
                            DetailRow(label: "Current Grade", value: progress.currentGradePercent.percent)
                            DetailRow(label: "Max Possible", value: progress.maxPossiblePercent.percent)
                            DetailRow(label: "Can Meet Goal", value: progress.canMeetGoal ? "Yes" : "No")
                        }

                        Section("Percent Points") {
                            DetailRow(label: "Accumulated", value: progress.accumulatedPercentPoints.whole)
                            DetailRow(label: "Lost", value: progress.lostPercentPoints.whole)
                            DetailRow(label: "Used", value: progress.usedPercentPoints.whole)
                        }
                    }
                    .navigationTitle("Progress")
                    .navigationBarTitleDisplayMode(.inline)
                } else {
                    Text("Progress not found.")
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle("Progress")
        .onAppear {
            selectedProgressID = snapshots.last?.id
        }
    }
}

#Preview {
    let store = AppStore()
    NavigationStack {
        if let firstCourseID = store.courses.first?.id {
            ProgressDetailView(courseID: firstCourseID)
        } else {
            Text("No progress preview data")
        }
    }
    .environmentObject(store)
}
