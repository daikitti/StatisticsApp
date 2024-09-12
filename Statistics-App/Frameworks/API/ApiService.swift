//
//  ApiService.swift
//  Statistics-App
//
//  Created by Havydope Diii on 12.09.2024.
//

import Foundation
import RxSwift

class ApiService {
    
    static let shared = ApiService()
    private init() {}
    
    // Получение статистики
    func fetchStatistics() -> Observable<StatisticsViewers> {
        return Observable.create { observer in
            let url = URL(string: "https://cars.cprogroup.ru/api/episode/statistics/")!
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    observer.onError(error)
                } else if let data = data {
                    do {
                        let statistics = try JSONDecoder().decode(StatisticsViewers.self, from: data)
                        print(statistics)
                        observer.onNext(statistics)
                        observer.onCompleted()
                    } catch {
                        observer.onError(error)
                    }
                }
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    // Получение пользователей
    func fetchUsers() -> Observable<Users> {
        return Observable.create { observer in
            let url = URL(string: "https://cars.cprogroup.ru/api/episode/users/")!
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    observer.onError(error)
                } else if let data = data {
                    do {
                        let users = try JSONDecoder().decode(Users.self, from: data)
                        print(users)
                        observer.onNext(users)
                        observer.onCompleted()
                    } catch {
                        observer.onError(error)
                    }
                }
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
