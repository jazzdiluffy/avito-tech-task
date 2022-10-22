import UIKit


final class IconView: UIView {
    
    private let imageView = UIImageView()
    
    init(systemName: String, backgroundColor: UIColor) {
        super.init(frame: .zero)
        layer.cornerRadius = 5
        self.backgroundColor = backgroundColor
        imageView.image = .init(systemName: systemName)
        imageView.tintColor = .white
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 3),
            imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -3),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3),
        ])
    }
}
