import UIKit

final class CompanyView: UIView {
    
    let companyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    private let noInternetBannerView = NoInternetBannerView()
    
    private var noDataView: NoDataView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        companyCollectionView.delegate = self
        companyCollectionView.register(classCell: EmployeeCell.self)

        let view = companyCollectionView
        view.backgroundColor = UIColor(named: "backgroundColor")
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.leftAnchor.constraint(equalTo: leftAnchor),
            view.rightAnchor.constraint(equalTo: rightAnchor),
        ])

        addSubview(noInternetBannerView)
        noInternetBannerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            noInternetBannerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            noInternetBannerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            noInternetBannerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            noInternetBannerView.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func update(with event: CompanyViewEvent) {
        switch event {
        case .noInternet:
            noInternetBannerView.isHidden = false
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        case .hasInternet:
            noDataView?.removeFromSuperview()
            noDataView = nil
            noInternetBannerView.isHidden = true
        case .noData:
            noDataView = NoDataView()
            setupNoDataView()
        }
    }
    
    private func setupNoDataView() {
        guard let noDataView = noDataView else { return }
        addSubview(noDataView)
        noDataView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            noDataView.topAnchor.constraint(equalTo: topAnchor),
            noDataView.bottomAnchor.constraint(equalTo: bottomAnchor),
            noDataView.leftAnchor.constraint(equalTo: leftAnchor),
            noDataView.rightAnchor.constraint(equalTo: rightAnchor),
        ])
    }
}

extension CompanyView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath ) -> CGSize {
        let width: CGFloat = collectionView.bounds.width - 32
        return CGSize(width: width, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 22, left: 16, bottom: 22, right: 16)
    }
}
