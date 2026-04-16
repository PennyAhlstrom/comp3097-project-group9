//
//  ProgressListView.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-03.
//

import SwiftUI

struct ProgressListView: View {
    @EnvironmentObject var store: AppStore

    var body: some View {
        ZStack {
            ListScreen(background: .progressBackground) {
                Section {
                    ForEach(store.courses) { course in
                        if let courseID = course.id {
                            CardRow {
                                let latest = latestProgress(for: courseID)

                                if latest != nil {
                                    NavigationLink {
                                        ProgressDetailView(courseID: courseID)
                                    } label: {
                                        courseRow(course: course, progress: latest)
                                    }
                                } else {
                                    courseRow(course: course, progress: nil)
                                }
                            }
                        }
                    }
                    .navigationTitle("PROGRESS")
                }
            }
            .refreshable {
                await store.loadProgresses()
            }
            .task {
                await store.loadProgressesIfNeeded()
            }

            LoadingErrorOverlay(
                isLoading: store.isLoading,
                errorMessage: store.errorMessage,
                onRetry: {
                    _Concurrency.Task {
                        await store.retryLoad(.progresses)
                    }
                },
                onDemoMode: {
                    store.enterDemoMode()
                }
            )

            if let successMessage = store.successMessage {
                ToastView(message: successMessage)
            }
        }
    }

    private func courseRow(course: Course, progress: Progress?) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(course.code)
                .font(.headline)

            Text(course.title)
                .font(.subheadline)
                .foregroundColor(.secondary)

            if let progress {
                HStack(spacing: 12) {
                    Text("Accumulated: \n\(progress.accumulatedPercentPoints.whole)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fontWeight(.semibold)

                    Text("Current: \n\(progress.currentGradePercent.percent)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fontWeight(.semibold)

                    Text("Possible: \n\(progress.maxPossiblePercent.percent)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fontWeight(.semibold)
                }

                Text(progress.canMeetGoal ? "On track to meet goal" : "At risk of missing goal")
                    .font(.subheadline)
                    .foregroundColor(progress.canMeetGoal ? .secondary : .red)
            } else {
                Text("No progress calculated yet")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 6)
    }

    private func latestProgress(for courseID: Int) -> Progress? {
        store.progresses
            .filter { $0.courseID == courseID }
            .sorted { $0.weekOf > $1.weekOf }
            .first
    }
}

#Preview {
    NavigationStack {
        ProgressListView()
    }
    .environmentObject(AppStore())
}
