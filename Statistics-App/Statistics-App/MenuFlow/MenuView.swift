import UIKit
import SnapKit

class MenuView: UIViewController {
    
    private lazy var statLabel: UILabel = {
        let label = UILabel()
        label.text = "Статистика"
        label.font = CustomFonts.titleBold
        label.textAlignment = .left
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.clipsToBounds = true
        scrollView.layer.cornerRadius = 12
        return scrollView
    }()
    
    private lazy var scrollContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
        
    private lazy var visitorsForm: VisitorsFormView = {
        let view = VisitorsFormView()
        return view
    }()
    
    private lazy var chatForm: VisitorsСhart = {
        let view = VisitorsСhart()
        
        let visitData = [
                    (date: "01.09", visits: 10),
                    (date: "04.09", visits: 15),
                    (date: "01.09", visits: 7),
                    (date: "04.09", visits: 12),
                    (date: "03.10", visits: 25)
                ]
                
        // Передаем данные в ChartView
        view.chartView.setData(visitData: visitData)
        return view
    }()
    
    private lazy var topViewers: TopViewers = {
        let view = TopViewers()
        view.configurate()
        return view
    }()
    
    let refreshControl = UIRefreshControl()
    var controller: MenuController?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        addSubViews()
        makeConstrains()
    }
}

extension MenuView: Designable {
    func setUp() {
        self.view.backgroundColor = Colors.background
    }
    
    func addSubViews() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        
        [statLabel,
         visitorsForm,
         chatForm,
         topViewers].forEach(scrollContentView.addSubview)
    }
    
    func makeConstrains() {
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
        
        scrollContentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView.snp.width)
        }
        
        statLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(scrollContentView).inset(20)
            make.height.equalTo(50)
        }
        
        visitorsForm.snp.makeConstraints { make in
            make.top.equalTo(statLabel.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(200)
        }
        
        chatForm.snp.makeConstraints { make in
            make.top.equalTo(visitorsForm.snp.bottom).offset(20)
            make.leading.trailing.equalTo(statLabel)
            make.height.equalTo(350)
        }
        
        topViewers.snp.makeConstraints { make in
            make.top.equalTo(chatForm.snp.bottom).offset(20)
            make.leading.trailing.equalTo(statLabel)
            make.height.equalTo(400)
            make.bottom.equalToSuperview().inset(20)
        }
    }
}
