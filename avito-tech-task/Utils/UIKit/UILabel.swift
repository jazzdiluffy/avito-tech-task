import UIKit

extension UILabel {
    convenience init(textColor: UIColor, numberOfLines: Int = 1, fontSize: CGFloat = 15, weight: UIFont.Weight = .regular) {
        self.init()
        self.numberOfLines = numberOfLines
        self.font = .systemFont(ofSize: fontSize, weight: weight)
        self.textColor = textColor
    }
}
