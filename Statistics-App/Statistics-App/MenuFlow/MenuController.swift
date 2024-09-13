import RxSwift
import Foundation
class MenuController {

    private let menuView: MenuView
    private let disposeBag = DisposeBag()
    
    var UsersData:[UserRealm] = [UserRealm]()
    var StatisticData:[StatisticRealm] = [StatisticRealm]()

    
    init(menuView: MenuView) {
        self.menuView = menuView
        self.menuView.controller = self
        setup()
    }

    private func setup() {
        // Подключаем refreshControl к scrollView
        menuView.scrollView.refreshControl = menuView.refreshControl
        menuView.refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        // Загружаем данные при инициализации
        loadData()
    }

    @objc private func refreshData() {
        fetchDataFromAPI()
    }

    private func loadData() {
        // Проверяем наличие данных в Realm
        if let statistics = RealmManager.shared.fetchStatisticsFromRealm(), !statistics.isEmpty,
           let users = RealmManager.shared.fetchUsersFromRealm(), !users.isEmpty {
            UsersData = users
            StatisticData = statistics
            menuView.UpdateUI(statistics: statistics, users: users)
            
        } else {
            // Загружаем данные из API
            fetchDataFromAPI()
        }
    }

    private func fetchDataFromAPI() {
        let statisticsObservable = ApiService.shared.fetchStatistics()
        let usersObservable = ApiService.shared.fetchUsers()

        Observable.zip(statisticsObservable, usersObservable)
            .subscribe(onNext: { [weak self] statistics, users in
                // Сохраняем данные в Realm
                RealmManager.shared.saveStatisticsToRealm(statistics: statistics.statistics)
                RealmManager.shared.saveUsersToRealm(users: users.users)
                
                // Загружаем данные из Realm и обновляем UI
                if let statisticsRealm = RealmManager.shared.fetchStatisticsFromRealm(),
                   let usersRealm = RealmManager.shared.fetchUsersFromRealm() {
                    self?.menuView.UpdateUI(statistics: statisticsRealm, users: usersRealm)
                }
                
                // Завершаем обновление
                self?.menuView.refreshControl.endRefreshing()
            }, onError: { [weak self] error in
                print("Ошибка при загрузке данных: \(error)")
                self?.menuView.refreshControl.endRefreshing()
            })
            .disposed(by: disposeBag)
    }

}
