import UIKit
import DGCharts
import Charts
import SnapKit

class GenderAgeChartView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Пол и возраст"
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
    
    private lazy var pieChartView: PieChartView = {
        let chartView = PieChartView()
        chartView.legend.enabled = false
        chartView.holeRadiusPercent = 0.88 // Увеличиваем радиус отверстия, чтобы края сегментов были закругленными
        chartView.transparentCircleRadiusPercent = 0.9
        chartView.drawEntryLabelsEnabled = false // Убираем подписи внутри
        chartView.rotationEnabled = false // Запрещаем вращение
        chartView.isUserInteractionEnabled = false // Отключаем интерактивность
        return chartView
    }()
    
    private lazy var barChartView: HorizontalBarChartView = {
        let chartView = HorizontalBarChartView()
        chartView.legend.enabled = false
        chartView.rightAxis.enabled = false
        chartView.leftAxis.enabled = false
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.labelCount = 5
        chartView.doubleTapToZoomEnabled = false
        chartView.isUserInteractionEnabled = false // Отключаем интерактивность
        return chartView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        setGenderData()
        setAgeData()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        [titleLabel,
         conteynirView,
         pieChartView,
         barChartView].forEach(addSubview)
        addSubview(conteynirView)
        addSubview(pieChartView)
        addSubview(barChartView)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
       
        conteynirView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(10)
        }
        
        pieChartView.snp.makeConstraints { make in
            make.top.equalTo(conteynirView).offset(20)
            make.centerX.equalTo(conteynirView)
            make.width.equalTo(200)
            make.height.equalTo(200)
        }
        
        barChartView.snp.makeConstraints { make in
            make.top.equalTo(pieChartView.snp.bottom).offset(20)
            make.leading.trailing.equalTo(conteynirView).inset(20)
            make.bottom.equalTo(conteynirView.snp.bottom).offset(10)
        }
    }
    
    private func setGenderData() {
        let entries = [
            PieChartDataEntry(value: 40, label: "Мужчины"),
            PieChartDataEntry(value: 60, label: "Женщины")
        ]
        
        let dataSet = PieChartDataSet(entries: entries, label: "")
        dataSet.colors = [UIColor(red: 0.85, green: 0.3, blue: 0.3, alpha: 1),
                          UIColor(red: 0.95, green: 0.6, blue: 0.4, alpha: 1)]
        dataSet.sliceSpace = 3 // Добавляем немного пространства между сегментами
        dataSet.selectionShift = 7
        dataSet.valueLineWidth = 2// Уменьшаем толщину линий
        dataSet.drawValuesEnabled = false // Убираем значения
        dataSet.valueLinePart1OffsetPercentage = 0.8 // Закругленные линии
        
        let data = PieChartData(dataSet: dataSet)
        pieChartView.data = data
    }
    
    private func setAgeData() {
        let entries = [
            BarChartDataEntry(x: 0, yValues: [10, 20]), // 18-21
            BarChartDataEntry(x: 1, yValues: [20, 30]), // 22-25
            BarChartDataEntry(x: 2, yValues: [5, 0]),   // 26-30
            BarChartDataEntry(x: 3, yValues: [0, 0]),   // 31-35
            BarChartDataEntry(x: 4, yValues: [5, 0]),   // 36-40
            BarChartDataEntry(x: 5, yValues: [0, 10]),  // 40-50
            BarChartDataEntry(x: 6, yValues: [0, 0])    // >50
        ]
        
        let dataSet = BarChartDataSet(entries: entries, label: "")
        dataSet.colors = [UIColor(red: 0.85, green: 0.3, blue: 0.3, alpha: 1),
                          UIColor(red: 0.95, green: 0.6, blue: 0.4, alpha: 1)]
        dataSet.stackLabels = ["Мужчины", "Женщины"]
        
        dataSet.barBorderWidth = 1 // Тонкие границы для баров
        dataSet.barBorderColor = UIColor.lightGray
        
        let data = BarChartData(dataSets: [dataSet])
        data.barWidth = 0.15 // Сделаем столбцы еще тоньше
        
        barChartView.data = data
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: ["18-21", "22-25", "26-30", "31-35", "36-40", "40-50", ">50"])
    }

}
