//
//  CourseDetailView.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-03.
//

import SwiftUI

struct CourseDetailView: View {
    @EnvironmentObject var store: AppStore
    let courseID: UUID

    @State private var showEdit = false
    @State private var showDeleteConfirm = false

    private var course: Course? {
        store.courses.first { $0.id == courseID }
    }

    var body: some View {
        Group {
            if let course {
                List {
                    Section("Course") {
                        DetailRow(label: "Code", value: course.code)
                        DetailRow(label: "Title", value: course.title)
                        DetailRow(label: "Instructor", value: course.instructor)
                    }

                    Section("Goals") {
                        DetailRow(label: "Grade Goal", value: course.gradeGoal.map { "\($0)%" } ?? "—")
                        DetailRow(label: "Start Week", value: course.startWeek.map { $0.formatted(date: .abbreviated, time: .omitted) } ?? "—")
                    }
                }
                .navigationTitle(course.code)
                .toolbar {
                    Button("Edit") { showEdit = true }
                }
                .sheet(isPresented: $showEdit) {
                    CourseEditView(course: course)
                        .environmentObject(store)
                }
                .safeAreaInset(edge: .bottom) {
                    Button(role: .destructive) {
                        showDeleteConfirm = true
                    } label: {
                        Text("Delete Course")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                    .confirmationDialog("Delete this course?", isPresented: $showDeleteConfirm) {
                        Button("Delete", role: .destructive) {
                            store.deleteCourse(id: course.id)
                        }
                    }
                }
            } else {
                Text("Course not found.")
                    .foregroundColor(.secondary)
                    .navigationTitle("Course")
            }
        }
    }
}

//#Preview {
//    NavigationStack { CourseDetailView(course: Course.sampleCourses[0]) }
//}

#Preview {
    let store = AppStore()
    return NavigationStack {
        CourseDetailView(courseID: store.courses.first!.id)
    }
    .environmentObject(store)
}
