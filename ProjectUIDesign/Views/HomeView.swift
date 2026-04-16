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
        ListScreen(title: "ClassMate", background: .homeBackground){
                Section {
                    CardRow(backgroundColor: .coursesBackground) {
                    NavigationLink {
                        //CourseListView(courses: Course.sampleCourses)
                        CourseListView() // Remove argument to use store instead of sample array?
                    } label: {
//                        CardRow(backgroundColor: .coursesBackground) {
                            Label {
                                Text("Courses")
                            } icon: {
                                Image(systemName: "book.closed")
                                    .foregroundStyle(Color.coursesCurrentBar)
                            }
                        }
                    }
//                    .listRowBackground(Color.coursesBackground)
                    
                    CardRow(backgroundColor: .tasksBackground) {
                    NavigationLink {
                        //TaskListView(tasks: Task.sampleTasks)
                        TaskListView() // Remove argument to use store instead of sample array?
                    } label: {
//                        CardRow(backgroundColor: .tasksBackground) {
                            Label {
                                Text("Tasks")
                            } icon: {
                                Image(systemName: "checklist")
                                    .foregroundStyle(Color.tasksCurrentBar)
                            }
                        }
                    }
//                    .listRowBackground(Color.tasksBackground)
                    
                    CardRow(backgroundColor: .remindersBackground) {
                    NavigationLink {
                        //ReminderListView(reminders: Reminder.sampleReminders)
                        ReminderListView() // Remove argument to use store instead of sample array?
                    } label: {
//                        CardRow(backgroundColor: .remindersBackground) {
                            Label {
                                Text("Reminders")
                            } icon: {
                                Image(systemName: "bell")
                                    .foregroundStyle(Color.remindersCurrentBar)
                            }
                        }
                    }
//                    .listRowBackground(Color.remindersBackground)
                    
                    CardRow(backgroundColor: .progressBackground) {
                    NavigationLink {
                        //ProgressListView(progresses: Progress.sampleProgresses)
                        ProgressListView() // Remove argument to use store instead of sample array?
                    } label: {
//                        CardRow(backgroundColor: .progressBackground) {
                            Label {
                                Text("Progress")
                            } icon: {
                                Image(systemName: "chart.line.uptrend.xyaxis")
                                    .foregroundStyle(Color.progressCurrentBar)
                            }
                        }
                    }
//                    .listRowBackground(Color.progressBackground)
                }
            //}
            .navigationTitle("HOME")
//            .toolbar {
//                ToolbarItem(placement: .topBarTrailing) {
//                    Button("Logout") {
//                        AuthManager.shared.logout()
//                    }
//                }
//            }
            
            Section {
                Button(role: .destructive) {
                    AuthManager.shared.logout()
                } label: {
                    Text("Logout")
                        .frame(maxWidth: .infinity)
                }
            }
        }
        
    }
}

#Preview {
//    HomeView()
    NavigationStack { HomeView() }
        .environmentObject(AppStore())
}
