//
//  CourseListView.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-03.
//

import SwiftUI

struct CourseListView: View {
    @EnvironmentObject var store: AppStore
    @State private var showingAddCourse = false

    var body: some View {
        ZStack {
            ListScreen(background: .coursesBackground) {
                Section {
                    ForEach(store.courses) { course in
                        if let id = course.id {
                            CardRow {
                                NavigationLink {
                                    CourseDetailView(courseID: id)
                                } label: {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(course.code)
                                            .font(.headline)

                                        Text(course.title)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)

                                        Text("Instructor: \(course.instructor)")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    .padding(.vertical, 6)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("COURSES")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddCourse = true
                    } label: {
                        Label("Add Course", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddCourse) {
                CourseAddView()
                    .environmentObject(store)
            }
            .refreshable {
                await store.loadCourses()
            }
            .task {
                await store.loadCoursesIfNeeded()
            }

            LoadingErrorOverlay(
                isLoading: store.isLoading,
                errorMessage: store.errorMessage,
                onRetry: {
                    Task {
                        await store.loadCourses()
                    }
                }
            )

            if let successMessage = store.successMessage {
                ToastView(message: successMessage)
            }
        }
    }
}

#Preview {
    NavigationStack {
        CourseListView()
    }
    .environmentObject(AppStore())
}
