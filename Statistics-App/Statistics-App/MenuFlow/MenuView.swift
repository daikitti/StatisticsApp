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
    
     lazy var scrollView: UIScrollView = {
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
        
        return view
    }()
    
     lazy var topViewers: TopViewers = {
        let view = TopViewers()
        return view
    }()
    
     lazy var genderAgeChartView: GenderAgeChartView = {
        let view = GenderAgeChartView()
        return view
    }()
    
    var UsersData:[UserRealm] = [UserRealm]()
    var StatisticData:[StatisticRealm] = [StatisticRealm]()
    
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
         topViewers,
         genderAgeChartView].forEach(scrollContentView.addSubview)
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
            make.height.equalTo(300)
        }
        
        genderAgeChartView.snp.makeConstraints { make in
            make.top.equalTo(topViewers.snp.bottom).offset(20)
            make.leading.trailing.equalTo(statLabel)
            make.height.equalTo(400)
            make.bottom.equalToSuperview().inset(20)
        }
    }
}

extension MenuView{
 
    func UpdateUI(statistics: [StatisticRealm], users:[UserRealm]){
        self.StatisticData = statistics
        self.UsersData = users
        
        visitorsForm.configurate(statistic: statistics)
        chatForm.configurate(statistic: statistics)
        topViewers.configurate(statistic: statistics, users: users )
    }

}
