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
    func configurate() {
        Vstack.subviews.forEach { view in
            view.removeFromSuperview()
        }
        
        for _ in 0...2 {
            let view = TopCell()
            view.configurate(imagePath: "", name: "takoyaki", age: "23")
            
            view.snp.makeConstraints { make in
                        make.height.equalTo(60) 
                    }
            Vstack.addArrangedSubview(view)
        }
        self.updateConstraints()
    }
}
