//
//  CourseDetailView.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-03.
//

import SwiftUI

struct CourseDetailView: View {
    @EnvironmentObject var store: AppStore
    let courseID: Int

    @State private var showEdit = false
    @State private var showDeleteConfirm = false

    private var course: Course? {
        store.courses.first { $0.id == courseID }
    }

    var courseTasks: [Task] {
        store.tasks.filter { $0.courseID == courseID }
    }

    var body: some View {
        DetailScreen(background: .coursesBackground) {
            if let course {
                List {
                    Section("Course") {
                        DetailRow(label: "Code", value: course.code)
                        DetailRow(label: "Title", value: course.title)
                        DetailRow(label: "Instructor", value: course.instructor)
                    }

                    Section("Tasks") {
                        if courseTasks.isEmpty {
                            Text("No tasks yet").foregroundColor(.secondary)
                        } else {
                            ForEach(courseTasks) { task in
                                if let taskID = task.id {
                                    NavigationLink {
                                        TaskDetailView(taskID: taskID)
                                    } label: {
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(task.title).font(.headline)
                                            Text(task.type).font(.caption).foregroundColor(.secondary)
                                            Text((task.dueDate ?? Date()).formatted(date: .abbreviated, time: .omitted))
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                }
                            }
                        }
                    }

                    Section("Goals") {
                        DetailRow(label: "Grade Goal", value: course.gradeGoal.map { "\($0)%" } ?? "—")
                        DetailRow(label: "Start Week", value: course.startWeek.map { $0.formatted(date: .abbreviated, time: .omitted) } ?? "—")
                    }
                }
                .navigationTitle(course.code)
                .padding(.bottom, 25)
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
                            Task {
                                await store.deleteCourse(id: courseID)
                            }
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

#Preview {
    let store = AppStore()
    return NavigationStack {
        Text("Preview disabled until API-compatible sample data is re-added")
    }
    .environmentObject(store)
}
