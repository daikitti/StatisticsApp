//
//  Date+String.swift
//  Statistics-App
//
//  Created by Havydope Diii on 13.09.2024.
//

import Foundation

extension Date {
    var currentMonth: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        return dateFormatter.string(from: self)
    }
}

extension String {
    func monthFromDate() -> String? {
        guard count >= 6 else { return nil } // Проверяем длину строки
        let trimmedStart = self.dropFirst(2) // Удаляем первые 2 символа
        let trimmedEnd = trimmedStart.dropLast(4) // Удаляем последние 4 символа
        return String(trimmedEnd)
    }
}
