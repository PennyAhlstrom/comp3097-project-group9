//
//  AppStore.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-03-03.
//

import Foundation
import Combine

@MainActor
final class AppStore: ObservableObject {

    enum AppMode {
        case live
        case demo
    }

    enum DataSection {
        case courses
        case tasks
        case reminders
        case progresses
    }

    @Published var courses: [Course] = []
    @Published var tasks: [Task] = []
    @Published var reminders: [Reminder] = []
    @Published var progresses: [Progress] = []

    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var successMessage: String?
    @Published var appMode: AppMode = .live

    private let courseService = CourseService()
    private let taskService = TaskService()
    private let reminderService = ReminderService()
    private let progressService = ProgressService()

    private var hasLoadedCourses = false
    private var hasLoadedTasks = false
    private var hasLoadedReminders = false
    private var hasLoadedProgresses = false

    private enum CacheKeys {
        static let courses = "cache_courses"
        static let tasks = "cache_tasks"
        static let reminders = "cache_reminders"
        static let progresses = "cache_progresses"
    }

    init() {
        loadCachedCourses()
        loadCachedTasks()
        loadCachedReminders()
        loadCachedProgresses()
        syncSessionMode()
    }

    // MARK: - Mode

    func syncSessionMode() {
        if AuthManager.shared.isDemoMode {
            appMode = .demo
            isLoading = false
            errorMessage = nil

            courses = ClassMateDemoData.courses
            tasks = ClassMateDemoData.tasks
            reminders = ClassMateDemoData.reminders
            progresses = ClassMateDemoData.progresses

            hasLoadedCourses = true
            hasLoadedTasks = true
            hasLoadedReminders = true
            hasLoadedProgresses = true
        } else {
            appMode = .live
            errorMessage = nil
        }
    }

    func enterDemoMode() {
        AuthManager.shared.enterDemoMode()
        syncSessionMode()

        _Concurrency.Task {
            await showSuccess("Demo mode enabled")
        }
    }

    func switchToLiveMode() {
        AuthManager.shared.exitDemoMode()
        syncSessionMode()
    }

    func retryLoad(_ section: DataSection) async {
        switchToLiveMode()

        switch section {
        case .courses:
            hasLoadedCourses = false
            await loadCoursesIfNeeded()
        case .tasks:
            hasLoadedTasks = false
            await loadTasksIfNeeded()
        case .reminders:
            hasLoadedReminders = false
            await loadRemindersIfNeeded()
        case .progresses:
            hasLoadedProgresses = false
            await loadProgressesIfNeeded()
        }
    }

    // MARK: - First Load Guards

    func loadCoursesIfNeeded() async {
        guard !hasLoadedCourses else { return }
        hasLoadedCourses = true
        await loadCourses()
    }

    func loadTasksIfNeeded() async {
        guard !hasLoadedTasks else { return }
        hasLoadedTasks = true
        await loadTasks()
    }

    func loadRemindersIfNeeded() async {
        guard !hasLoadedReminders else { return }
        hasLoadedReminders = true
        await loadReminders()
    }

    func loadProgressesIfNeeded() async {
        guard !hasLoadedProgresses else { return }
        hasLoadedProgresses = true
        await loadProgresses()
    }

    // MARK: - Load

    func loadCourses() async {
        if appMode == .demo {
            courses = ClassMateDemoData.courses
            errorMessage = nil
            return
        }

        isLoading = true
        defer { isLoading = false }

        do {
            let loaded = try await courseService.getAll()
            courses = loaded
            saveCourses()
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func loadTasks() async {
        if appMode == .demo {
            tasks = ClassMateDemoData.tasks
            errorMessage = nil
            return
        }

        isLoading = true
        defer { isLoading = false }

        do {
            let loaded = try await taskService.getAll()
            tasks = loaded
            saveTasks()
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func loadReminders() async {
        if appMode == .demo {
            reminders = ClassMateDemoData.reminders
            errorMessage = nil
            return
        }

        isLoading = true
        defer { isLoading = false }

        do {
            let loaded = try await reminderService.getAll()
            reminders = loaded
            saveReminders()
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func loadProgresses() async {
        if appMode == .demo {
            progresses = ClassMateDemoData.progresses
            errorMessage = nil
            return
        }

        isLoading = true
        defer { isLoading = false }

        do {
            let loaded = try await progressService.getAll()
            progresses = loaded
            saveProgresses()
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    // MARK: - Courses

    func addCourse(_ course: Course) async {
        if appMode == .demo {
            let localCourse = Course(
                id: nextCourseID(),
                code: course.code,
                title: course.title,
                instructor: course.instructor,
                meetings: course.meetings,
                gradeGoal: course.gradeGoal,
                startWeek: course.startWeek
            )
            courses = [localCourse] + courses
            errorMessage = nil
            await showSuccess("Course added in demo mode")
            return
        }

        let previous = courses
        let optimistic = [course] + courses
        courses = optimistic
        saveCourses()

        do {
            let created = try await courseService.create(course)
            if let _ = created.id,
               let index = courses.firstIndex(where: { $0.id == nil && $0.code == course.code && $0.title == course.title }) {
                courses[index] = created
            } else {
                await loadCourses()
            }
            saveCourses()
            errorMessage = nil
            await showSuccess("Course added")
        } catch {
            courses = previous
            saveCourses()
            errorMessage = error.localizedDescription
        }
    }

    func updateCourse(_ updated: Course) async {
        guard let id = updated.id, let idx = courses.firstIndex(where: { $0.id == id }) else { return }

        if appMode == .demo {
            courses[idx] = updated
            errorMessage = nil
            await showSuccess("Course updated in demo mode")
            return
        }

        let previous = courses
        courses[idx] = updated
        saveCourses()

        do {
            let saved = try await courseService.update(updated)
            if let savedIndex = courses.firstIndex(where: { $0.id == id }) {
                courses[savedIndex] = saved
            }
            saveCourses()
            errorMessage = nil
            await showSuccess("Course updated")
        } catch {
            courses = previous
            saveCourses()
            errorMessage = error.localizedDescription
        }
    }

    func deleteCourse(id: Int) async {
        if appMode == .demo {
            courses.removeAll { $0.id == id }
            tasks.removeAll { $0.courseID == id }
            progresses.removeAll { $0.courseID == id }
            errorMessage = nil
            await showSuccess("Course deleted in demo mode")
            return
        }

        let previous = courses
        courses.removeAll { $0.id == id }
        saveCourses()

        do {
            try await courseService.delete(id: id)
            errorMessage = nil
            await showSuccess("Course deleted")
        } catch {
            courses = previous
            saveCourses()
            errorMessage = error.localizedDescription
        }
    }

    // MARK: - Tasks

    func addTask(_ task: Task) async {
        if appMode == .demo {
            let localTask = Task(
                id: nextTaskID(),
                courseID: task.courseID,
                title: task.title,
                type: task.type,
                dueDate: task.dueDate,
                priorityThresholdDays: task.priorityThresholdDays,
                manualPriorityOverride: task.manualPriorityOverride,
                weight: task.weight,
                scorePercent: task.scorePercent,
                isPriority: task.isPriority,
                isCompleted: task.isCompleted,
                isBonus: task.isBonus
            )
            tasks = [localTask] + tasks
            errorMessage = nil
            await showSuccess("Task added in demo mode")
            return
        }

        let previous = tasks
        tasks = [task] + tasks
        saveTasks()

        do {
            let created = try await taskService.create(task)
            if let _ = created.id,
               let index = tasks.firstIndex(where: { $0.id == nil && $0.title == task.title && $0.courseID == task.courseID }) {
                tasks[index] = created
            } else {
                await loadTasks()
            }
            saveTasks()
            errorMessage = nil
            await showSuccess("Task added")
        } catch {
            tasks = previous
            saveTasks()
            errorMessage = error.localizedDescription
        }
    }

    func updateTask(_ updated: Task) async {
        guard let id = updated.id, let idx = tasks.firstIndex(where: { $0.id == id }) else { return }

        if appMode == .demo {
            tasks[idx] = updated
            errorMessage = nil
            await showSuccess("Task updated in demo mode")
            return
        }

        let previous = tasks
        tasks[idx] = updated
        saveTasks()

        do {
            let saved = try await taskService.update(updated)
            if let savedIndex = tasks.firstIndex(where: { $0.id == id }) {
                tasks[savedIndex] = saved
            }
            saveTasks()
            errorMessage = nil
            await showSuccess("Task updated")
        } catch {
            tasks = previous
            saveTasks()
            errorMessage = error.localizedDescription
        }
    }

    func deleteTask(id: Int) async {
        if appMode == .demo {
            tasks.removeAll { $0.id == id }
            reminders.removeAll { $0.taskID == id }
            errorMessage = nil
            await showSuccess("Task deleted in demo mode")
            return
        }

        let previous = tasks
        tasks.removeAll { $0.id == id }
        saveTasks()

        do {
            try await taskService.delete(id: id)
            errorMessage = nil
            await showSuccess("Task deleted")
        } catch {
            tasks = previous
            saveTasks()
            errorMessage = error.localizedDescription
        }
    }

    // MARK: - Reminders

    func addReminder(_ reminder: Reminder) async {
        if appMode == .demo {
            let localReminder = Reminder(
                id: nextReminderID(),
                taskID: reminder.taskID,
                message: reminder.message,
                scheduledAt: reminder.scheduledAt,
                wasSent: reminder.wasSent
            )
            reminders = [localReminder] + reminders
            errorMessage = nil
            await showSuccess("Reminder added in demo mode")
            return
        }

        let previous = reminders
        reminders = [reminder] + reminders
        saveReminders()

        do {
            let created = try await reminderService.create(reminder)
            if let _ = created.id,
               let index = reminders.firstIndex(where: { $0.id == nil && $0.message == reminder.message && $0.taskID == reminder.taskID }) {
                reminders[index] = created
            } else {
                await loadReminders()
            }
            saveReminders()
            errorMessage = nil
            await showSuccess("Reminder added")
        } catch {
            reminders = previous
            saveReminders()
            errorMessage = error.localizedDescription
        }
    }

    func updateReminder(_ updated: Reminder) async {
        guard let id = updated.id, let idx = reminders.firstIndex(where: { $0.id == id }) else { return }

        if appMode == .demo {
            reminders[idx] = updated
            errorMessage = nil
            await showSuccess("Reminder updated in demo mode")
            return
        }

        let previous = reminders
        reminders[idx] = updated
        saveReminders()

        do {
            let saved = try await reminderService.update(updated)
            if let savedIndex = reminders.firstIndex(where: { $0.id == id }) {
                reminders[savedIndex] = saved
            }
            saveReminders()
            errorMessage = nil
            await showSuccess("Reminder updated")
        } catch {
            reminders = previous
            saveReminders()
            errorMessage = error.localizedDescription
        }
    }

    func deleteReminder(id: Int) async {
        if appMode == .demo {
            reminders.removeAll { $0.id == id }
            errorMessage = nil
            await showSuccess("Reminder deleted in demo mode")
            return
        }

        let previous = reminders
        reminders.removeAll { $0.id == id }
        saveReminders()

        do {
            try await reminderService.delete(id: id)
            errorMessage = nil
            await showSuccess("Reminder deleted")
        } catch {
            reminders = previous
            saveReminders()
            errorMessage = error.localizedDescription
        }
    }

    // MARK: - Progress

    func addProgress(_ progress: Progress) async {
        if appMode == .demo {
            let localProgress = Progress(
                id: nextProgressID(),
                courseID: progress.courseID,
                accumulatedPercentPoints: progress.accumulatedPercentPoints,
                usedPercentPoints: progress.usedPercentPoints,
                lostPercentPoints: progress.lostPercentPoints,
                maxPossiblePercent: progress.maxPossiblePercent,
                currentGradePercent: progress.currentGradePercent,
                canMeetGoal: progress.canMeetGoal,
                weekOf: progress.weekOf,
                computedAt: progress.computedAt
            )
            progresses = [localProgress] + progresses
            errorMessage = nil
            await showSuccess("Progress added in demo mode")
            return
        }

        let previous = progresses
        progresses = [progress] + progresses
        saveProgresses()

        do {
            let created = try await progressService.create(progress)
            if let _ = created.id,
               let index = progresses.firstIndex(where: { $0.id == nil && $0.courseID == progress.courseID && $0.weekOf == progress.weekOf }) {
                progresses[index] = created
            } else {
                await loadProgresses()
            }
            saveProgresses()
            errorMessage = nil
            await showSuccess("Progress added")
        } catch {
            progresses = previous
            saveProgresses()
            errorMessage = error.localizedDescription
        }
    }

    func updateProgress(_ updated: Progress) async {
        guard let id = updated.id, let idx = progresses.firstIndex(where: { $0.id == id }) else { return }

        if appMode == .demo {
            progresses[idx] = updated
            errorMessage = nil
            await showSuccess("Progress updated in demo mode")
            return
        }

        let previous = progresses
        progresses[idx] = updated
        saveProgresses()

        do {
            let saved = try await progressService.update(updated)
            if let savedIndex = progresses.firstIndex(where: { $0.id == id }) {
                progresses[savedIndex] = saved
            }
            saveProgresses()
            errorMessage = nil
            await showSuccess("Progress updated")
        } catch {
            progresses = previous
            saveProgresses()
            errorMessage = error.localizedDescription
        }
    }

    func deleteProgress(id: Int) async {
        if appMode == .demo {
            progresses.removeAll { $0.id == id }
            errorMessage = nil
            await showSuccess("Progress deleted in demo mode")
            return
        }

        let previous = progresses
        progresses.removeAll { $0.id == id }
        saveProgresses()

        do {
            try await progressService.delete(id: id)
            errorMessage = nil
            await showSuccess("Progress deleted")
        } catch {
            progresses = previous
            saveProgresses()
            errorMessage = error.localizedDescription
        }
    }

    // MARK: - Toast

    func showSuccess(_ message: String) async {
        successMessage = message

        _Concurrency.Task {
            try? await _Concurrency.Task .sleep(nanoseconds: 2_000_000_000)
            await MainActor.run {
                if self.successMessage == message {
                    self.successMessage = nil
                }
            }
        }
    }

    // MARK: - ID Helpers

    private func nextCourseID() -> Int {
        (courses.compactMap { $0.id }.max() ?? 0) + 1
    }

    private func nextTaskID() -> Int {
        (tasks.compactMap { $0.id }.max() ?? 0) + 1
    }

    private func nextReminderID() -> Int {
        (reminders.compactMap { $0.id }.max() ?? 0) + 1
    }

    private func nextProgressID() -> Int {
        (progresses.compactMap { $0.id }.max() ?? 0) + 1
    }

    // MARK: - Cache

    private func saveCourses() {
        save(courses, key: CacheKeys.courses)
    }

    private func loadCachedCourses() {
        courses = load([Course].self, key: CacheKeys.courses) ?? []
    }

    private func saveTasks() {
        save(tasks, key: CacheKeys.tasks)
    }

    private func loadCachedTasks() {
        tasks = load([Task].self, key: CacheKeys.tasks) ?? []
    }

    private func saveReminders() {
        save(reminders, key: CacheKeys.reminders)
    }

    private func loadCachedReminders() {
        reminders = load([Reminder].self, key: CacheKeys.reminders) ?? []
    }

    private func saveProgresses() {
        save(progresses, key: CacheKeys.progresses)
    }

    private func loadCachedProgresses() {
        progresses = load([Progress].self, key: CacheKeys.progresses) ?? []
    }

    private func save<T: Codable>(_ value: T, key: String) {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        if let data = try? encoder.encode(value) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    private func load<T: Codable>(_ type: T.Type, key: String) -> T? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try? decoder.decode(type, from: data)
    }
}
