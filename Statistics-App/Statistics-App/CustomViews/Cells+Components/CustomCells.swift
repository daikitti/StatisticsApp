//
//  TimeCell.swift
//  Statistics-App
//
//  Created by Havydope Diii on 12.09.2024.
//

import Foundation
import SnapKit
import UIKit

class TimeCell: UICollectionViewCell{
    
    static let CellID = "TimeCell"
    
    private lazy var conteynir: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = CustomFonts.textRegular
        label.textColor = .black
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
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

extension TimeCell:Designable {
    func setUp() {
    }
    
    func addSubViews() {
        self.addSubview(conteynir)
        conteynir.addSubview(titleLabel)
    }
    
    func makeConstrains() {
        
        conteynir.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.edges.equalTo(conteynir).inset(5)
        }
        
    }
}

extension TimeCell {
    func configurate(typeDate: DateItem){
        self.titleLabel.text = typeDate.title
        if typeDate.isSelected {
            titleLabel.textColor = .white
            conteynir.backgroundColor = Colors.red
            conteynir.layer.borderColor = UIColor.clear.cgColor
        }else{
            titleLabel.textColor = .black
            conteynir.backgroundColor = .white
            conteynir.layer.borderColor = .init(gray: 1.0, alpha: 0.5)

        }
    }
}
