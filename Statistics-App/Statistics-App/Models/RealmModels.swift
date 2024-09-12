//
//  RealmModels.swift
//  Statistics-App
//
//  Created by Havydope Diii on 12.09.2024.
//

import Foundation

// Модель для хранения статистики
class StatisticRealm: Object {
    @Persisted var userID: Int = 0
    @Persisted var type: String = ""
    @Persisted var dates = List<Int>()

    override static func primaryKey() -> String? {
        return "userID"
    }
}

import RealmSwift

// Модель для хранения пользователей
class UserRealm: Object {
    @Persisted var id: Int = 0
    @Persisted var sex: String = ""
    @Persisted var username: String = ""
    @Persisted var isOnline: Bool = false
    @Persisted var age: Int = 0
    @Persisted var file = List<FileRealm>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}


// Модель для хранения файлов
class FileRealm: Object {
    @Persisted var id: Int = 0
    @Persisted var url: String = ""
    @Persisted var type: String = ""
}
