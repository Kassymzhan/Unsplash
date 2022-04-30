//
//  CellConfigurator.swift
//  Unsplash
//
//  Created by Нурым Нагиметов on 01.05.2022.
//
import Foundation
import UIKit

protocol ConfigurableCell {
    associatedtype DataType
    func configure(data: DataType)
}

protocol CellConfigurator {
    static var reuseId: String { get }
    static var cellClass: AnyClass { get }
    func configure(cell: UIView)
}

class TableCellConfigurator<CellType: ConfigurableCell, DataType>: CellConfigurator where CellType.DataType == DataType, CellType: UITableViewCell{
    static var cellClass: AnyClass { return CellType.self}
    static var reuseId: String { return String(describing: CellType.self) }
    let item: DataType
    init(item: DataType) {
        self.item = item
    }
    func configure(cell: UIView) {
        (cell as! CellType).configure(data: item)
    }
}
