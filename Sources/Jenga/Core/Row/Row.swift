import UIKit

public protocol RowActionable {
    
    var isSelectable: Bool { get set }
    
    var action: RowAction? { get set }
}

public protocol Row: JengaHashable, RowActionable, Reform {
    
    var cellType: UITableViewCell.Type { get }
    
    var reuseIdentifier: String { get }
    
    var selectionStyle: UITableViewCell.SelectionStyle { get set }
    
    var height: RowHeight? { get set }
    
    var estimatedHeight: RowHeight? { get set }
}

public extension Row {
      
    func height(_ value: RowHeight?) -> Self {
        reform { $0.height = value }
    }
    
    func estimatedHeight(_ value: RowHeight?) -> Self {
        reform { $0.estimatedHeight = value }
    }
    
    func selectionStyle(_ value: UITableViewCell.SelectionStyle) -> Self {
        reform { $0.selectionStyle = value }
    }

    func onTap(_ value: RowAction?) -> Self {
        reform { $0.action = value }
    }
    
    func onTap<S>(on target: S, _ value: @escaping (S) -> Void) -> Self {
        reform { $0.action = { value(target) } }
    }
    
    func onTap<S>(on target: S, _ value: @escaping (S) -> Void) -> Self where S: AnyObject {
        reform {
            $0.action = { [weak target]  in
                guard let target = target else { return }
                value(target)
            }
        }
    }
}

public typealias RowHeight = CGFloat
public typealias RowAction = () -> Void

