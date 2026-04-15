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

    @Published var courses: [Course] = []
    @Published var tasks: [Task] = []
    @Published var reminders: [Reminder] = []
    @Published var progresses: [Progress] = []

    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var successMessage: String?

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
        let previous = courses
        let optimistic = [course] + courses
        courses = optimistic
        saveCourses()

        do {
            let created = try await courseService.create(course)
            if let createdID = created.id,
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
        let previous = tasks
        tasks = [task] + tasks
        saveTasks()

        do {
            let created = try await taskService.create(task)
            if let createdID = created.id,
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
        let previous = reminders
        reminders = [reminder] + reminders
        saveReminders()

        do {
            let created = try await reminderService.create(reminder)
            if let createdID = created.id,
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
        let previous = progresses
        progresses = [progress] + progresses
        saveProgresses()

        do {
            let created = try await progressService.create(progress)
            if let createdID = created.id,
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

        Task {
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            await MainActor.run {
                if self.successMessage == message {
                    self.successMessage = nil
                }
            }
        }
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
