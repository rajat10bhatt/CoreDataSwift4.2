//
//  LessonService.swift
//  keystone Park
//
//  Created by Rajat on 11/1/18.
//  Copyright © 2018 None. All rights reserved.
//

import Foundation
import CoreData

enum LessonType: String {
    case ski, snowboard
}

typealias StudentHandler = (Bool, [Student]) -> ()

class LessonService {
    private var moc: NSManagedObjectContext
    private var students: [Student] = []
    
    init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    //MARK: Public
    func addStudent(name: String, for type: LessonType, completion: StudentHandler) {
        let student = Student(context: moc)
        student.name = name
        
        if let lesson = lessonExists(type: type) {
            register(student: student, for: lesson)
            self.students.append(student)
            completion(true, students)
        }
    }
    
    //MARK: Private
    private func lessonExists(type: LessonType) -> Lesson? {
        let request: NSFetchRequest<Lesson> = Lesson.fetchRequest()
        request.predicate = NSPredicate(format: "type = %@", type.rawValue)
        var lesson: Lesson?
        do {
            let result = try moc.fetch(request)
            lesson = result.isEmpty ? addLesson(type) : result.first
        } catch let error as NSError {
            print("Unable to get lesson: \(error.localizedDescription)")
        }
        return lesson
    }
    
    private func addLesson(_ type: LessonType) -> Lesson {
        let lesson = Lesson(context: moc)
        lesson.type = type.rawValue
        return lesson
    }
    
    private func register(student: Student, for lesson: Lesson) {
        student.lesson = lesson
    }
    
    private func save() {
        do {
            try moc.save()
        } catch let error as NSError{
            print("Unable to save: \(error.localizedDescription)")
        }
    }
}
