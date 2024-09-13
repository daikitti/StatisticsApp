//
//  VisitorsСhart.swift
//  Statistics-App
//
//  Created by Havydope Diii on 12.09.2024.
//

import Foundation
import UIKit
import SnapKit


class VisitorsСhart:UIView{
    
    
    private lazy var timeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TimeCell.self, forCellWithReuseIdentifier: TimeCell.CellID)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    let chartView = ChartView()

    
    var typeDate:[DateItem] = DateSortList().getAllSortDate()
    var currentDateSort:typeSortDate = .forDays
    
    
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

extension VisitorsСhart: Designable {
    func setUp() {
        
    }
    
    func addSubViews() {
        [timeCollectionView,
        chartView].forEach(self.addSubview)
    }
    
    func makeConstrains() {
        
        timeCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        
        chartView.snp.makeConstraints { make in
            make.top.equalTo(timeCollectionView.snp.bottom).offset(20)
            make.leading.trailing.equalTo(timeCollectionView)
            make.bottom.equalToSuperview()
        }
        
    }
    
    
}

extension VisitorsСhart: UICollectionViewDelegate, UICollectionViewDataSource,
                         UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return typeDate.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeCell.CellID, for: indexPath) as! TimeCell
        let sortDate = typeDate[indexPath.row]
        cell.configurate(typeDate: sortDate)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var typeSortItem = typeDate[indexPath.row]
        if typeSortItem.type != self.currentDateSort {
            for i in 0..<typeDate.count {
                typeDate[i].isSelected = false
            }
            typeSortItem.isSelected = true
            typeDate[indexPath.row] = typeSortItem
            self.currentDateSort = typeSortItem.type
            collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = DesignConstans.screenWidth/3.6
        let height = 30.0
        return CGSize(width: width, height: height)
    }
}

extension VisitorsСhart {
    func configurate(statistic: [StatisticRealm]) {
        // Шаг 1: Собираем все даты в один массив
        var allDates: [Int] = []
        
        statistic.forEach { stat in
            stat.dates.forEach { date in
                allDates.append(date)
            }
        }
        
        // Вывод всех собранных дат для отладки
        print("Все даты: \(allDates)")
        
        // Шаг 2: Подсчитываем количество уникальных дат
        var visitCounts: [String: Int] = [:]
        
        for dateInt in allDates {
            // Преобразуем дату в строку
            let dateString = String(dateInt)
            let paddedDateString: String
            
            // Добавляем ведущий ноль, если длина даты — 7 символов
            if dateString.count == 7 {
                paddedDateString = "0\(dateString)"
            } else {
                paddedDateString = dateString
            }
            
            // Извлекаем день и месяц
            let day = paddedDateString.prefix(2) // Первые 2 символа — день
            let month = paddedDateString.dropFirst(2).prefix(2) // Следующие 2 символа — месяц
            
            // Форматируем как "dd.MM"
            let formattedDate = "\(day).\(month)"
            
            // Считаем посещения для каждой уникальной даты
            if let count = visitCounts[formattedDate] {
                visitCounts[formattedDate] = count + 1
            } else {
                visitCounts[formattedDate] = 1
            }
        }
        
        // Вывод подсчитанных посещений для каждой даты для отладки
        print("Посчитанные посещения: \(visitCounts)")
        
        // Шаг 3: Преобразуем данные в формат, который ожидает chartView
        var visitData: [(date: String, visits: Int)] = []
        for (date, visits) in visitCounts {
            visitData.append((date: date, visits: visits))
        }
        
        // Шаг 4: Сортируем данные по дате
        visitData.sort { $0.date < $1.date }
        
        // Вывод финальных данных для графика
        print("Данные для графика: \(visitData)")
        
        // Шаг 5: Обновляем данные в chartView
        chartView.setData(visitData: visitData)
    }
}
