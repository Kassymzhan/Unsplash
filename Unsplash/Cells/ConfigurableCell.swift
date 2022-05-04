//
//  ConfigurableCell.swift
//  Unsplash
//
//  Created by Касымжан Гиждуан on 01.05.2022.
//

import Foundation

protocol ConfigurableCell {
    associatedtype DataType
    static var reuseIdentifier: String { get }
    func configure(data: DataType)
}

// MARK: - ConfigurableCell
extension ConfigurableCell {
    static var reuseIdentifier: String { return String(describing: Self.self) }
}
