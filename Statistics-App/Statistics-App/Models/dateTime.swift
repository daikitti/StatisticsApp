//
//  dateTime.swift
//  Statistics-App
//
//  Created by Havydope Diii on 12.09.2024.
//

import Foundation

enum typeSortDate{
    case forDays,  forWeeks, forMonth
}

struct DateItem{
    let title: String
    let type: typeSortDate
    var isSelected:Bool
}

struct DateSortList{
    func getAllSortDate() -> [DateItem] {
        var sortList = [DateItem]()
        sortList.append(DateItem(title: "По дням", type: .forDays, isSelected: true))
        sortList.append(DateItem(title: "По неделям", type: .forWeeks, isSelected: false))
        sortList.append(DateItem(title: "По месяцам", type: .forMonth, isSelected: false))
        return sortList
    }
}
