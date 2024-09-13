import Foundation
import UIKit
import SnapKit

class TopViewers: UIView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Чаще всех посещают Ваш профиль"
        label.font = CustomFonts.titleMedium
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private lazy var conteynirView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var Vstack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.layer.cornerRadius = 12
        stack.spacing  = 1
        stack.distribution = .equalSpacing
        stack.clipsToBounds = true
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubViews()
        makeConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TopViewers: Designable {
    func addSubViews() {
        [titleLabel,
         conteynirView
         ].forEach(self.addSubview)
        conteynirView.addSubview(Vstack)
    }
    
    func makeConstrains() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
       
        conteynirView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(Vstack.snp.bottom).offset(10)
        }
        
        Vstack.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(conteynirView).offset(10)
        }
    }
}

extension TopViewers {
    func configurate(statistic: [StatisticRealm], users: [UserRealm]) {
        Vstack.subviews.forEach { view in
            view.removeFromSuperview()
        }
        
        // Шаг 1: Подсчитываем количество просмотров для каждого пользователя
        var userVisits: [Int: Int] = [:] // Ключ - user_id, значение - количество просмотров
        
        for stat in statistic {
            if stat.type == "view" { // Считаем только просмотры
                if let currentCount = userVisits[stat.userID] {
                    userVisits[stat.userID] = currentCount + stat.dates.count
                } else {
                    userVisits[stat.userID] = stat.dates.count
                }
            }
        }
        
        // Шаг 2: Сортируем пользователей по количеству просмотров в порядке убывания
        let sortedUsers = users.sorted { (user1, user2) -> Bool in
            let visits1 = userVisits[user1.id] ?? 0
            let visits2 = userVisits[user2.id] ?? 0
            return visits1 > visits2 
        }
        
        // Шаг 3: Берём только трёх пользователей с наибольшим количеством просмотров
        let topUserViewvers = Array(sortedUsers.prefix(3))
        
        // Шаг 4: Конфигурируем ячейки для каждого пользователя
        for user in topUserViewvers {
            let view = TopCell()
            
            guard let urlImage = user.file.first?.url else { return }
            view.configurate(imagePath: urlImage, name: user.username, age: user.age)
            
            view.snp.makeConstraints { make in
                make.height.equalTo(60)
            }
            
            Vstack.addArrangedSubview(view)
        }
        
        // Обновляем констрейнты
        self.updateConstraints()
    }
}

