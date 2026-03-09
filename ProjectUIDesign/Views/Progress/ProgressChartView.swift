//
//  ProgressChartView.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-08.
//

import SwiftUI
import Charts

struct ProgressChartView: View {
    let snapshots: [Progress]
    let selectedProgressID: UUID?
    
    private var selectedIndex: Int {
        snapshots.firstIndex { $0.id == selectedProgressID } ?? max(snapshots.count - 1, 0)
    }
    
    private var visibleSnapshots: [Progress] {
        snapshots.isEmpty ? [] : Array(snapshots.prefix(selectedIndex + 1))
    }
    
    private var historyData: [(week: String, current: Double?, possible: Double?)] {
        (1...16).map { week in
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
    }
    
    //    var body: some View {
    //        Chart(historyData, id: \.week) { item in
    //            if let current = item.current {
    //                BarMark(
    //                    x: .value("Week", item.week),
    //                    y: .value("Percent", current)
    //                )
    //                .position(by: .value("Type", "Current"))
    //                .foregroundStyle(by: .value("Series", "Current Grade"))
    //            }
    //
    //            if let possible = item.possible {
    //                BarMark(
    //                    x: .value("Week", item.week),
    //                    y: .value("Percent", possible)
    //                )
    //                .position(by: .value("Type", "Possible"))
    //                .foregroundStyle(by: .value("Series", "Possible Grade"))
    //            }
    //        }
    //        .frame(height: 220)
    //        .chartYScale(domain: 0...100)
    //        .chartForegroundStyleScale([
    //                "Current Grade": Color.progressCurrentBar,
    //                "Max Possible": Color.progressPossibleBar
    //            ])
    //            .chartLegend(position: .top, alignment: .center)
    //            .chartXAxisLabel(position: .bottom, alignment: .center) {
    //                Text("Week")
    //            }
    //
    //        .chartXAxisLabel(position: .bottom, alignment: .center) {
    //            Text("Week")
    //        }
    //        .chartXAxis {
    //            AxisMarks(values: historyData.map { $0.week }) { value in
    //                AxisValueLabel {
    //                    if let week = value.as(String.self) {
    //                        Text(week.replacingOccurrences(of: "Wk", with: ""))
    //                    }
    //                }
    //            }
    //        }
    //        .chartYAxis {
    //            AxisMarks(position: .leading, values: [0, 20, 40, 60, 80, 100]) { _ in
    //                AxisGridLine()
    //                AxisTick()
    //                AxisValueLabel()
    //            }
    //        }
    //    }
    //}
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Percent vs Week")
                .font(.subheadline)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .center)
            
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
                AxisMarks(position: .leading, values: [0, 20, 40, 60, 80, 100]) { _ in
                    AxisGridLine()
                    AxisTick()
                    AxisValueLabel()
                }
                

            }
//            HStack {
//                Spacer() // Makes the legend right justified
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 6) {
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color.progressCurrentBar)
                            .frame(width: 12, height: 12)
                        
                        Text("Current Grade")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    HStack(spacing: 6) {
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color.progressPossibleBar)
                            .frame(width: 12, height: 12)
                        
                        Text("Max Possible Grade")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
//            }
        }
    }
}
