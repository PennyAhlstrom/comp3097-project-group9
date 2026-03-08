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
                        Label("Courses", systemImage: "book.closed")
                    }

                    NavigationLink {
                        //TaskListView(tasks: Task.sampleTasks)
                        TaskListView() // Remove argument to use store instead of sample array?
                    } label: {
                        Label("Tasks", systemImage: "checklist")
                    }

                    NavigationLink {
                        //ReminderListView(reminders: Reminder.sampleReminders)
                        ReminderListView() // Remove argument to use store instead of sample array?
                    } label: {
                        Label("Reminders", systemImage: "bell")
                    }

                    NavigationLink {
                        //ProgressListView(progresses: Progress.sampleProgresses)
                        ProgressListView() // Remove argument to use store instead of sample array?
                    } label: {
                        Label("Progress", systemImage: "chart.line.uptrend.xyaxis")
                    }
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
