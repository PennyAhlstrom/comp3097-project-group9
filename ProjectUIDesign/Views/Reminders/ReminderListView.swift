//
//  ReminderListView.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-03.
//

import SwiftUI

struct ReminderListView: View {
    @EnvironmentObject var store: AppStore
    @State private var showingAddReminder = false

    var body: some View {
        ZStack {
            ListScreen(background: .remindersBackground) {
                Section {
                    ForEach(store.reminders) { reminder in
                        if let reminderID = reminder.id {
                            CardRow {
                                NavigationLink {
                                    ReminderDetailView(reminderID: reminderID)
                                } label: {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(reminder.message)
                                            .font(.headline)

                                        Text("Date: \(reminder.scheduledAt.formatted(date: .abbreviated, time: .shortened))")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    .padding(.vertical, 6)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("REMINDERS")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddReminder = true
                    } label: {
                        Label("Add Reminder", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddReminder) {
                ReminderAddView()
                    .environmentObject(store)
            }
            .refreshable {
                await store.loadReminders()
            }
            .task {
                await store.loadRemindersIfNeeded()
            }

            LoadingErrorOverlay(
                isLoading: store.isLoading,
                errorMessage: store.errorMessage,
                onRetry: {
                    _Concurrency.Task {
                        await store.retryLoad(.reminders)
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
}

#Preview {
    NavigationStack {
        ReminderListView()
    }
    .environmentObject(AppStore())
}
