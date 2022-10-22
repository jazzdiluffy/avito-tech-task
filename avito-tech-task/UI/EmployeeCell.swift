import UIKit

final class EmployeeCell: UICollectionViewCell {
    
    let nameIconView = IconView(systemName: "person.crop.circle", backgroundColor: .systemOrange)
    let nameLabel = UILabel(textColor: .label)
    let phoneIconView = IconView(systemName: "phone.fill", backgroundColor: .systemBlue)
    let phoneNumberLabel = UILabel(textColor: .label)
    let skillsIconView = IconView(systemName: "mail.stack.fill", backgroundColor: .systemGreen)
    let skillsLabel = UILabel(textColor: .label, numberOfLines: 2)
    
    let firstSeparatorView = UIView.separator()
    let secondSeparatorView = UIView.separator()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        [nameIconView, nameLabel, phoneIconView, phoneNumberLabel, skillsIconView, skillsLabel, firstSeparatorView, secondSeparatorView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        contentView.backgroundColor = UIColor(named: "cellColor")
        contentView.layer.cornerRadius = 8

        NSLayoutConstraint.activate([
            nameIconView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            nameIconView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            nameIconView.heightAnchor.constraint(equalToConstant: 26),
            nameIconView.widthAnchor.constraint(equalToConstant: 26),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            nameLabel.leftAnchor.constraint(equalTo: nameIconView.rightAnchor, constant: 7),
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),

            firstSeparatorView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            firstSeparatorView.heightAnchor.constraint(equalToConstant: 0.5),
            firstSeparatorView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            firstSeparatorView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
        
            phoneIconView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            phoneIconView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            phoneIconView.heightAnchor.constraint(equalToConstant: 26),
            phoneIconView.widthAnchor.constraint(equalToConstant: 26),
            phoneNumberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            phoneNumberLabel.leftAnchor.constraint(equalTo: phoneIconView.rightAnchor, constant: 7),
            phoneNumberLabel.heightAnchor.constraint(equalToConstant: 30),
            phoneNumberLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
        
            secondSeparatorView.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 8),
            secondSeparatorView.heightAnchor.constraint(equalToConstant: 0.5),
            secondSeparatorView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            secondSeparatorView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
        
            skillsIconView.centerYAnchor.constraint(equalTo: skillsLabel.centerYAnchor),
            skillsIconView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            skillsIconView.heightAnchor.constraint(equalToConstant: 26),
            skillsIconView.widthAnchor.constraint(equalToConstant: 26),
            skillsLabel.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 12),
            skillsLabel.leftAnchor.constraint(equalTo: skillsIconView.rightAnchor, constant: 7),
            skillsLabel.heightAnchor.constraint(equalToConstant: 30),
            skillsLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
        ])
    }
    
    func configure(with model: Employee) {
        nameLabel.attributedText = makeAttributedText(boldPart: "Name: ", regularPart: model.name)
        phoneNumberLabel.attributedText = makeAttributedText(boldPart: " Phone number: ", regularPart: model.phoneNumber)
        skillsLabel.attributedText = makeAttributedText(boldPart: "Skills: ", regularPart: model.skills.joined(separator: ", "))
    }
    
    private func makeAttributedText(boldPart: String, regularPart: String) -> NSMutableAttributedString {
        let boldTextAttributes = [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)
        ]
        let bolded = NSMutableAttributedString(string: boldPart, attributes: boldTextAttributes)
        let regularPartAttributedString = NSAttributedString(string: regularPart)
        bolded.append(regularPartAttributedString)
        return bolded
    }
}
