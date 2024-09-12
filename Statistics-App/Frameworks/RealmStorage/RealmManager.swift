//
//  RealmManager.swift
//  Statistics-App
//
//  Created by Havydope Diii on 12.09.2024.
//

import Foundation
import RealmSwift

class RealmManager {
    
    static let shared = RealmManager() 
    private init() {}
    
    // Функция для сохранения статистики в Realm
    func saveStatisticsToRealm(statistics: [Statistic]) {
        let realm = try! Realm()
        try! realm.write {
            let statisticsRealm = statistics.map { statistic -> StatisticRealm in
                let statisticRealm = StatisticRealm()
                statisticRealm.userID = statistic.userID
                statisticRealm.type = statistic.type
                statisticRealm.dates.append(objectsIn: statistic.dates)
                return statisticRealm
            }
            realm.add(statisticsRealm, update: .modified)
        }
    }
    
    // Функция для сохранения пользователей в Realm
    func saveUsersToRealm(users: [User]) {
        let realm = try! Realm()
        try! realm.write {
            let usersRealm = users.map { user -> UserRealm in
                let userRealm = UserRealm()
                userRealm.id = user.id
                userRealm.sex = user.sex
                userRealm.username = user.username
                userRealm.isOnline = user.isOnline
                userRealm.age = user.age
                
                // Сохранение файлов
                let filesRealm = user.file.map { file -> FileRealm in
                    let fileRealm = FileRealm()
                    fileRealm.id = file.id
                    fileRealm.url = file.url
                    fileRealm.type = file.type
                    return fileRealm
                }
                userRealm.file.append(objectsIn: filesRealm)
                return userRealm
            }
            realm.add(usersRealm, update: .modified)
        }
    }
    
    // Функция для получения статистики из Realm
    func fetchStatisticsFromRealm() -> [StatisticRealm]? {
        let realm = try! Realm()
        let results = realm.objects(StatisticRealm.self)
        return Array(results)
    }
    
    // Функция для получения пользователей из Realm
    func fetchUsersFromRealm() -> [UserRealm]? {
        let realm = try! Realm()
        let results = realm.objects(UserRealm.self)
        return Array(results)
    }
}
