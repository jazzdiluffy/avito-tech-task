import UIKit

protocol ReuseIdentifiableProtocol: UIView {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifiableProtocol {
    static var reuseIdentifier: String { String(describing: Self.self) }
}

extension UICollectionViewCell: ReuseIdentifiableProtocol {}

extension UICollectionView {
    func create<A: ReuseIdentifiableProtocol>(cell: A.Type, at index: IndexPath) -> A? {
        self.dequeueReusableCell(withReuseIdentifier: cell.reuseIdentifier, for: index) as? A
    }

    func register<A: ReuseIdentifiableProtocol>(classCell: A.Type) {
        self.register(classCell.self, forCellWithReuseIdentifier: classCell.reuseIdentifier)
    }
}
