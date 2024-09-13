//
//  TopCell.swift
//  Statistics-App
//
//  Created by Havydope Diii on 13.09.2024.
//

import Foundation
import UIKit
import SnapKit

class TopCell: UIView{
    
    private lazy var conteynirView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var titleName: UILabel = {
        let title = UILabel()
        title.text = ""
        title.font = CustomFonts.textRegular
        return title
    }()
    
    private lazy var shevronButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "shevron"), for: .normal)
        return button
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

extension TopCell: Designable {

    func addSubViews() {
        [conteynirView,
         avatarImageView,
         titleName,
         shevronButton].forEach(self.addSubview)
    }

    func makeConstrains() {
        conteynirView.snp.makeConstraints { make in
            make.top.trailing.leading.equalToSuperview()
            make.height.equalTo(60)
        }

        avatarImageView.snp.makeConstraints { make in
            make.leading.equalTo(conteynirView).inset(10)
            make.centerY.equalTo(conteynirView)
            make.height.width.equalTo(50)
        }

        titleName.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(10)
            make.trailing.equalTo(shevronButton.snp.leading).offset(-10)
            make.centerY.equalTo(avatarImageView)
        }

        shevronButton.snp.makeConstraints { make in
            make.trailing.equalTo(conteynirView).inset(20) 
            make.centerY.equalTo(avatarImageView)
            make.height.width.equalTo(30)
        }
    }
}

import UIKit

extension TopCell {
    func configurate(imagePath: String, name: String, age: Int) {
        // Устанавливаем изображение по умолчанию
        self.avatarImageView.image = UIImage(named: "avatar")
        self.titleName.text = "\(name), \(age)"
        
        // Проверяем, можно ли создать URL из переданного imagePath
        guard let url = URL(string: imagePath) else {
            print("Неверный URL: \(imagePath)")
            return
        }
        
        // Загрузка изображения асинхронно
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Проверяем наличие ошибки или данных
            if let error = error {
                print("Ошибка при загрузке изображения: \(error)")
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("Не удалось получить данные изображения")
                return
            }
            
            // Обновляем UI на главном потоке
            DispatchQueue.main.async {
                self.avatarImageView.image = image
            }
        }.resume()
    }
}
