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
    let courseID: UUID

    @State private var selectedProgressID: UUID?

    var body: some View {
//            let snapshots = store.progresses
//                .filter { $0.courseID == courseID }
//                .sorted { $0.weekOf < $1.weekOf } // Chronological order - oldest to newest
//
//            let selected = snapshots.first(where: { $0.id == selectedProgressID }) ?? snapshots.first
        
        let snapshots = store.progresses
            .filter { $0.courseID == courseID }
            .sorted { $0.weekOf < $1.weekOf }

        let selected = snapshots.first(where: { $0.id == selectedProgressID }) ?? snapshots.last

        let selectedIndex = snapshots.firstIndex { $0.id == selectedProgressID } ?? max(snapshots.count - 1, 0)

        let visibleSnapshots = snapshots.isEmpty ? [] : Array(snapshots.prefix(selectedIndex + 1))

        let historyData: [(week: String, current: Double?, possible: Double?)] = (1...16).map { week in
            if week <= visibleSnapshots.count {
                let progress = visibleSnapshots[week - 1]
                return (
                    week: "Wk\(week)",
                    current: progress.currentGradePercent,
                    possible: progress.maxPossiblePercent
                )
            } else {
                return (
                    week: "Wk\(week)",
                    current: nil,
                    possible: nil
                )
            }
        }
        
        DetailScreen(background: .progressBackground) {
            Form {
                Section("Snapshot") {
                    Picker("Week of:", selection: $selectedProgressID) {
                        ForEach(snapshots) { p in
                            Text(p.weekOf.formatted(.dateTime.year().month().day()))
                                .tag(Optional(p.id))
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Section("History") {
                    Chart(historyData, id: \.week) { item in
                        if let current = item.current {
                            BarMark(
                                x: .value("Week", item.week),
                                y: .value("Percent", current)
                            )
                            .position(by: .value("Type", "Current"))
                            .foregroundStyle(Color.progressCurrentBar)
                        }
                        
                        if let possible = item.possible {
                            BarMark(
                                x: .value("Week", item.week),
                                y: .value("Percent", possible)
                            )
                            .position(by: .value("Type", "Possible"))
                            .foregroundStyle(Color.progressPossibleBar)
                        }
                    }
                    .frame(height: 220)
                    .chartYScale(domain: 0...100)
                    
                    .chartXAxisLabel(position: .bottom, alignment: .center) {
                        Text("Week")
                    }
                    
                    .chartXAxis {
                        AxisMarks(values: historyData.map { $0.week }) { value in
                            AxisValueLabel {
                                if let week = value.as(String.self) {
                                    Text(week.replacingOccurrences(of: "Wk", with: ""))
                                }
                            }
                        }
                    }
                    
                    .chartYAxis {
                        AxisMarks(position: .leading, values: [0, 20, 40, 60, 80, 100]) { value in
                            AxisGridLine()
                            AxisTick()
                            AxisValueLabel()
                        }
                    }
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
