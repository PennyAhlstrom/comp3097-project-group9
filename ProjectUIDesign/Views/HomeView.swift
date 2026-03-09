//
//  HomeView.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-03.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        //NavigationStack { // removed navigation stack here and added it in ProjectUIDesignApp to get the back buttons to appear on each page
            List {
                Section {
                    NavigationLink {
                        //CourseListView(courses: Course.sampleCourses)
                        CourseListView() // Remove argument to use store instead of sample array?
                    } label: {
                        Label {
                            Text("Courses")
                        } icon: {
                            Image(systemName: "book.closed")
                                .foregroundStyle(Color.coursesCurrentBar)
                        }
                    }
                    .listRowBackground(Color.coursesBackground)

                    NavigationLink {
                        //TaskListView(tasks: Task.sampleTasks)
                        TaskListView() // Remove argument to use store instead of sample array?
                    } label: {
                        Label {
                            Text("Tasks")
                        } icon: {
                            Image(systemName: "checklist")
                                .foregroundStyle(Color.tasksCurrentBar)
                        }
                    }
                    .listRowBackground(Color.tasksBackground)

                    NavigationLink {
                        //ReminderListView(reminders: Reminder.sampleReminders)
                        ReminderListView() // Remove argument to use store instead of sample array?
                    } label: {
                        Label {
                            Text("Reminders")
                        } icon: {
                            Image(systemName: "bell")
                                .foregroundStyle(Color.remindersCurrentBar)
                        }
                    }
                    .listRowBackground(Color.remindersBackground)

                    NavigationLink {
                        //ProgressListView(progresses: Progress.sampleProgresses)
                        ProgressListView() // Remove argument to use store instead of sample array?
                    } label: {
                        Label {
                            Text("Progress")
                        } icon: {
                            Image(systemName: "chart.line.uptrend.xyaxis")
                                .foregroundStyle(Color.progressCurrentBar)
                        }
                    }
                    .listRowBackground(Color.progressBackground)
                }
            //}
            .navigationTitle("ClassMate")
        }
    }
}

#Preview {
//    HomeView()
    NavigationStack { HomeView() }
        .environmentObject(AppStore())
}
