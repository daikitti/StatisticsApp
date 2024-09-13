//
//  VisitorsFormView.swift
//  Statistics-App
//
//  Created by Havydope Diii on 12.09.2024.
//

import Foundation
import UIKit
import SnapKit

class VisitorsFormView:UIView {
    
      private lazy var content: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Посетители"
        label.font = CustomFonts.titleMedium
        label.textAlignment = .left
        return label
    }()
    
    private lazy var conteynirView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var grafimageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "greenGraf")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var countVisitLabel: UILabel = {
        let label = UILabel()
        label.text = "1337"
        label.font = CustomFonts.titleBold
        label.textAlignment = .left
        return label
    }()
    
    private lazy var arrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "arrow")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Количество посетителей в этом месяце выросло"
        label.font = CustomFonts.textRegular
        label.textColor = .gray
        label.textAlignment = .left
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUp()
        addSubViews()
        makeConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension VisitorsFormView: Designable{
    func setUp() {
        
    }
    
    func addSubViews() {
        self.addSubview(content)
        
        [ titleLabel,
          conteynirView].forEach(content.addSubview)
        
        [grafimageView,
         countVisitLabel,
         arrowImage,
         descriptionLabel].forEach(conteynirView.addSubview)
    }
    
    func makeConstrains() {
        
        content.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(content)
            make.height.equalTo(40)
        }
        
        conteynirView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalTo(titleLabel)
            make.bottom.equalTo(content)
        }
        
        grafimageView.snp.makeConstraints { make in
            make.top.bottom.equalTo(conteynirView).inset(10)
            make.leading.equalTo(conteynirView).offset(10)
            make.width.equalTo(conteynirView.snp.width).multipliedBy(0.36)
        }
        
        countVisitLabel.snp.makeConstraints { make in
            make.top.equalTo(grafimageView)
            make.leading.equalTo(grafimageView.snp.trailing).offset(20)
        }
        
        arrowImage.snp.makeConstraints { make in
            make.centerY.equalTo(countVisitLabel)
            make.leading.equalTo(countVisitLabel.snp.trailing).offset(8)
            make.height.equalTo(25)
            make.width.equalTo(arrowImage.snp.height)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(countVisitLabel)
            make.trailing.equalTo(conteynirView).inset(10)
            make.top.equalTo(countVisitLabel.snp.bottom)
            make.bottom.equalTo(grafimageView)
        }
    }
    
    
}
