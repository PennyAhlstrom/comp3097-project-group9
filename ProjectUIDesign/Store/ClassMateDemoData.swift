//
//  ClassMateDemoData.swift
//  ProjectUIDesign
//
//  Created by Penny Ahlstrom on 2026-04-15.
//

import Foundation

enum ClassMateDemoData {
    enum IDs {
        static let courseMobile = 101
        static let courseML = 102
        static let courseCyber = 103
        static let courseFullstack = 104
        static let courseComm = 105
        static let courseIT = 106

        static let taskLabEx1 = 1001
        static let taskAssignment1 = 1002
        static let taskQuizWeek1 = 1003
        static let taskMLProposal = 1004
        static let taskMLQuiz1 = 1005
        static let taskMLAssignment2 = 1006
        static let taskCyberLab1 = 1007
        static let taskMLMidterm = 1008
        static let taskMLQuizWeek2 = 1009
        static let taskCyberAudit = 1010
        static let taskCyberBonus = 1011
        static let taskReactCRUD = 1012
        static let taskGraphQLQuiz = 1013
        static let taskCyberMidterm = 1014

        static let reminder1 = 2001
        static let reminder2 = 2002
        static let reminder3 = 2003
        static let reminder4 = 2004
        static let reminder5 = 2005
        static let reminder6 = 2006
        static let reminder7 = 2007
        static let reminder8 = 2008
        static let reminder9 = 2009

        static let progress1 = 3001
        static let progress2 = 3002
        static let progress3 = 3003
        static let progress4 = 3004
        static let progress5 = 3005
        static let progress6 = 3006
        static let progress7 = 3007
        static let progress8 = 3008
    }

    static let courses: [Course] = [
        Course(
            id: IDs.courseMobile,
            code: "COMP3097",
            title: "Mobile Dev II",
            instructor: "Professor Kiani",
            meetings: [],
            gradeGoal: 85,
            startWeek: ymd(2026, 1, 12)
        ),
        Course(
            id: IDs.courseML,
            code: "COMP3132",
            title: "Machine Learning",
            instructor: "Professor Ajellu",
            meetings: [],
            gradeGoal: 85,
            startWeek: ymd(2026, 1, 12)
        ),
        Course(
            id: IDs.courseCyber,
            code: "COMP3134",
            title: "Cyber Security",
            instructor: "Professor Blanc",
            meetings: [],
            gradeGoal: 85,
            startWeek: ymd(2026, 1, 12)
        ),
        Course(
            id: IDs.courseFullstack,
            code: "COMP3133",
            title: "Fullstack Dev II",
            instructor: "Professor Patel",
            meetings: [],
            gradeGoal: 85,
            startWeek: ymd(2026, 1, 12)
        ),
        Course(
            id: IDs.courseComm,
            code: "COMM2000",
            title: "Communicating Across Contexts",
            instructor: "Professor Karimian",
            meetings: [],
            gradeGoal: 93,
            startWeek: ymd(2026, 1, 12)
        ),
        Course(
            id: IDs.courseIT,
            code: "COMP1151",
            title: "IT Essentials",
            instructor: "Professor Danison",
            meetings: [],
            gradeGoal: 95,
            startWeek: ymd(2026, 1, 12)
        )
    ]

    static let tasks: [Task] = [
        Task(
            id: IDs.taskLabEx1,
            courseID: IDs.courseMobile,
            title: "LabEx1",
            type: "LAB",
            dueDate: ymd(2026, 2, 3),
            priorityThresholdDays: nil,
            manualPriorityOverride: nil,
            weight: 1.5,
            scorePercent: 100,
            isPriority: false,
            isCompleted: true,
            isBonus: false
        ),
        Task(
            id: IDs.taskAssignment1,
            courseID: IDs.courseMobile,
            title: "Assignment 1",
            type: "ASSIGNMENT",
            dueDate: ymd(2026, 2, 23),
            priorityThresholdDays: nil,
            manualPriorityOverride: nil,
            weight: 15,
            scorePercent: 100,
            isPriority: false,
            isCompleted: true,
            isBonus: false
        ),
        Task(
            id: IDs.taskQuizWeek1,
            courseID: IDs.courseMobile,
            title: "Quiz Week 1",
            type: "QUIZ",
            dueDate: ymd(2026, 2, 8),
            priorityThresholdDays: nil,
            manualPriorityOverride: nil,
            weight: 2,
            scorePercent: 0,
            isPriority: true,
            isCompleted: false,
            isBonus: false
        ),
        Task(
            id: IDs.taskMLProposal,
            courseID: IDs.courseML,
            title: "ML Project Proposal",
            type: "PROJECT",
            dueDate: ymd(2026, 3, 1),
            priorityThresholdDays: nil,
            manualPriorityOverride: nil,
            weight: 5,
            scorePercent: 0,
            isPriority: true,
            isCompleted: false,
            isBonus: false
        ),
        Task(
            id: IDs.taskMLQuiz1,
            courseID: IDs.courseML,
            title: "Quiz 1",
            type: "QUIZ",
            dueDate: ymd(2026, 3, 5),
            priorityThresholdDays: nil,
            manualPriorityOverride: nil,
            weight: 2,
            scorePercent: 0,
            isPriority: true,
            isCompleted: false,
            isBonus: false
        ),
        Task(
            id: IDs.taskMLAssignment2,
            courseID: IDs.courseML,
            title: "Assignment 2",
            type: "ASSIGNMENT",
            dueDate: ymd(2026, 3, 12),
            priorityThresholdDays: nil,
            manualPriorityOverride: nil,
            weight: 10,
            scorePercent: 0,
            isPriority: false,
            isCompleted: false,
            isBonus: false
        ),
        Task(
            id: IDs.taskCyberLab1,
            courseID: IDs.courseCyber,
            title: "Cyber Sec Lab 1",
            type: "LAB",
            dueDate: ymd(2026, 2, 10),
            priorityThresholdDays: nil,
            manualPriorityOverride: nil,
            weight: 5,
            scorePercent: 92,
            isPriority: false,
            isCompleted: true,
            isBonus: false
        ),
        Task(
            id: IDs.taskMLMidterm,
            courseID: IDs.courseML,
            title: "Midterm Exam",
            type: "EXAM",
            dueDate: ymd(2026, 3, 5),
            priorityThresholdDays: nil,
            manualPriorityOverride: nil,
            weight: 25,
            scorePercent: 0,
            isPriority: true,
            isCompleted: false,
            isBonus: false
        ),
        Task(
            id: IDs.taskMLQuizWeek2,
            courseID: IDs.courseML,
            title: "Quiz Week 2",
            type: "QUIZ",
            dueDate: ymd(2026, 2, 15),
            priorityThresholdDays: nil,
            manualPriorityOverride: nil,
            weight: 2,
            scorePercent: 88,
            isPriority: false,
            isCompleted: true,
            isBonus: false
        ),
        Task(
            id: IDs.taskCyberAudit,
            courseID: IDs.courseCyber,
            title: "Security Audit Report",
            type: "ASSIGNMENT",
            dueDate: ymd(2026, 2, 20),
            priorityThresholdDays: nil,
            manualPriorityOverride: nil,
            weight: 20,
            scorePercent: 95,
            isPriority: false,
            isCompleted: true,
            isBonus: false
        ),
        Task(
            id: IDs.taskCyberBonus,
            courseID: IDs.courseCyber,
            title: "Bonus: CTF Challenge",
            type: "LAB",
            dueDate: ymd(2026, 3, 1),
            priorityThresholdDays: nil,
            manualPriorityOverride: nil,
            weight: 5,
            scorePercent: 0,
            isPriority: false,
            isCompleted: false,
            isBonus: true
        ),
        Task(
            id: IDs.taskReactCRUD,
            courseID: IDs.courseFullstack,
            title: "React CRUD App",
            type: "ASSIGNMENT",
            dueDate: ymd(2026, 2, 28),
            priorityThresholdDays: nil,
            manualPriorityOverride: nil,
            weight: 15,
            scorePercent: 90,
            isPriority: false,
            isCompleted: true,
            isBonus: false
        ),
        Task(
            id: IDs.taskGraphQLQuiz,
            courseID: IDs.courseFullstack,
            title: "GraphQL Quiz",
            type: "QUIZ",
            dueDate: ymd(2026, 2, 12),
            priorityThresholdDays: nil,
            manualPriorityOverride: nil,
            weight: 3,
            scorePercent: 85,
            isPriority: false,
            isCompleted: true,
            isBonus: false
        ),
        Task(
            id: IDs.taskCyberMidterm,
            courseID: IDs.courseCyber,
            title: "Midterm Exam",
            type: "EXAM",
            dueDate: ymd(2026, 3, 1),
            priorityThresholdDays: nil,
            manualPriorityOverride: nil,
            weight: 20,
            scorePercent: 0,
            isPriority: true,
            isCompleted: false,
            isBonus: false
        )
    ]

    static let reminders: [Reminder] = [
        Reminder(
            id: IDs.reminder1,
            taskID: IDs.taskMLQuiz1,
            message: "Complete Quiz 1",
            scheduledAt: ymd(2026, 3, 6),
            wasSent: false
        ),
        Reminder(
            id: IDs.reminder2,
            taskID: IDs.taskMLMidterm,
            message: "Study for Midterm",
            scheduledAt: ymd(2026, 2, 8),
            wasSent: false
        ),
        Reminder(
            id: IDs.reminder3,
            taskID: IDs.taskCyberLab1,
            message: "Submit Lab 3",
            scheduledAt: ymd(2026, 3, 12),
            wasSent: false
        ),
        Reminder(
            id: IDs.reminder4,
            taskID: IDs.taskCyberMidterm,
            message: "Midterm Exam",
            scheduledAt: ymd(2026, 2, 18),
            wasSent: false
        ),
        Reminder(
            id: IDs.reminder5,
            taskID: IDs.taskMLMidterm,
            message: "ML Midterm prep - review notes",
            scheduledAt: ymd(2026, 3, 3),
            wasSent: false
        ),
        Reminder(
            id: IDs.reminder6,
            taskID: IDs.taskReactCRUD,
            message: "Push React CRUD to GitHub",
            scheduledAt: ymd(2026, 2, 27),
            wasSent: false
        ),
        Reminder(
            id: IDs.reminder7,
            taskID: IDs.taskMLProposal,
            message: "Start Project Proposal",
            scheduledAt: ymd(2026, 3, 1),
            wasSent: false
        ),
        Reminder(
            id: IDs.reminder8,
            taskID: IDs.taskMLAssignment2,
            message: "Submit Final Project",
            scheduledAt: ymd(2026, 4, 10),
            wasSent: false
        ),
        Reminder(
            id: IDs.reminder9,
            taskID: IDs.taskCyberAudit,
            message: "Attend Review Session",
            scheduledAt: ymd(2026, 3, 15),
            wasSent: false
        )
    ]

    static let progresses: [Progress] = [
        Progress(
            id: IDs.progress1,
            courseID: IDs.courseMobile,
            accumulatedPercentPoints: 12,
            usedPercentPoints: 15,
            lostPercentPoints: 3,
            maxPossiblePercent: 97,
            currentGradePercent: 80,
            canMeetGoal: true,
            weekOf: date("2026-01-12"),
            computedAt: date("2026-01-12")
        ),
        Progress(
            id: IDs.progress2,
            courseID: IDs.courseMobile,
            accumulatedPercentPoints: 22,
            usedPercentPoints: 25,
            lostPercentPoints: 3,
            maxPossiblePercent: 97,
            currentGradePercent: 88,
            canMeetGoal: true,
            weekOf: date("2026-01-26"),
            computedAt: date("2026-01-26")
        ),
        Progress(
            id: IDs.progress3,
            courseID: IDs.courseMobile,
            accumulatedPercentPoints: 39,
            usedPercentPoints: 45,
            lostPercentPoints: 6,
            maxPossiblePercent: 94,
            currentGradePercent: 87,
            canMeetGoal: true,
            weekOf: date("2026-02-09"),
            computedAt: date("2026-02-09")
        ),
        Progress(
            id: IDs.progress4,
            courseID: IDs.courseMobile,
            accumulatedPercentPoints: 58,
            usedPercentPoints: 65,
            lostPercentPoints: 7,
            maxPossiblePercent: 93,
            currentGradePercent: 89,
            canMeetGoal: true,
            weekOf: date("2026-02-23"),
            computedAt: date("2026-02-23")
        ),
        Progress(
            id: IDs.progress5,
            courseID: IDs.courseML,
            accumulatedPercentPoints: 7,
            usedPercentPoints: 7,
            lostPercentPoints: 0,
            maxPossiblePercent: 100,
            currentGradePercent: 92,
            canMeetGoal: true,
            weekOf: date("2026-02-09"),
            computedAt: date("2026-02-09")
        ),
        Progress(
            id: IDs.progress6,
            courseID: IDs.courseML,
            accumulatedPercentPoints: 9,
            usedPercentPoints: 9,
            lostPercentPoints: 0,
            maxPossiblePercent: 100,
            currentGradePercent: 90,
            canMeetGoal: true,
            weekOf: date("2026-02-23"),
            computedAt: date("2026-02-23")
        ),
        Progress(
            id: IDs.progress7,
            courseID: IDs.courseML,
            accumulatedPercentPoints: 10,
            usedPercentPoints: 12,
            lostPercentPoints: 2,
            maxPossiblePercent: 98,
            currentGradePercent: 85,
            canMeetGoal: true,
            weekOf: date("2026-03-02"),
            computedAt: date("2026-03-02")
        ),
        Progress(
            id: IDs.progress8,
            courseID: IDs.courseML,
            accumulatedPercentPoints: 25,
            usedPercentPoints: 30,
            lostPercentPoints: 5,
            maxPossiblePercent: 95,
            currentGradePercent: 87,
            canMeetGoal: true,
            weekOf: date("2026-03-09"),
            computedAt: date("2026-03-09")
        )
    ]

    private static func ymd(_ year: Int, _ month: Int, _ day: Int) -> Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = 12
        components.minute = 0
        components.second = 0
        return Calendar(identifier: .gregorian).date(from: components) ?? Date()
    }

    private static func date(_ string: String) -> Date {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: string) ?? Date()
    }
}
