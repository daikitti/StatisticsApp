import UIKit
import DGCharts
import SnapKit

class ChartView: UIView, ChartViewDelegate {
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.delegate = self
        
        chartView.rightAxis.enabled = false
        chartView.leftAxis.enabled = false
        
        chartView.xAxis.drawGridLinesEnabled = true
        chartView.xAxis.gridColor = .gray
        chartView.xAxis.gridLineWidth = 1.0
        chartView.xAxis.gridLineDashLengths = [5, 5]
        
        chartView.doubleTapToZoomEnabled = false
        chartView.legend.enabled = false
        return chartView
    }()
    
    var visitData: [(date: String, visits: Int)] = []
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(containerView)
        containerView.addSubview(lineChartView)
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        lineChartView.snp.makeConstraints { make in
            make.edges.equalTo(containerView).inset(10)
        }
    }
    
    // Метод для установки данных
    func setData(visitData: [(date: String, visits: Int)]) {
        self.visitData = visitData
        
        var entries: [ChartDataEntry] = []
        
        for (index, data) in visitData.enumerated() {
            let entry = ChartDataEntry(x: Double(index), y: Double(data.visits))
            entries.append(entry)
        }
        
        let set = LineChartDataSet(entries: entries)
        set.colors = [NSUIColor.red]
        set.circleColors = [NSUIColor.red]
        set.circleHoleColor = .white
        set.circleRadius = 6
        set.circleHoleRadius = 3
        set.drawValuesEnabled = false
        set.mode = .linear
        set.lineWidth = 2
        
        let data = LineChartData(dataSet: set)
        lineChartView.data = data
        
        // Настройка отображения меток оси X
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: visitData.map { $0.date })
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.labelFont = .systemFont(ofSize: 12, weight: .regular)
        lineChartView.xAxis.labelTextColor = .gray
        lineChartView.xAxis.granularityEnabled = true
        lineChartView.xAxis.granularity = 1
        lineChartView.xAxis.labelCount = visitData.count
        
        // Установка диапазона оси X с отступами
        lineChartView.xAxis.axisMinimum = -0.5 // Добавляем отступ перед первым значением
        lineChartView.xAxis.axisMaximum = Double(visitData.count - 1) + 0.5 // Добавляем отступ после последнего значения
        
        // Обновление графика
        lineChartView.notifyDataSetChanged()
    }
    
    // MARK: - ChartViewDelegate
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        let index = Int(entry.x)
        let data = visitData[index]
        
        let infoView = UIView()
        infoView.backgroundColor = .white
        infoView.layer.borderColor = Colors.red.cgColor
        infoView.layer.borderWidth = 2
        infoView.layer.cornerRadius = 8
        
        let label = UILabel()
        label.text = "Посетители: \(data.visits)\nДата: \(data.date)"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        
        infoView.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        addSubview(infoView)
        infoView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(60)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            infoView.removeFromSuperview()
        }
    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        lineChartView.highlightValue(nil)
    }
}
