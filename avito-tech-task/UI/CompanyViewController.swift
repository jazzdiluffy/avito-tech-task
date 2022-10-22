import UIKit

final class CompanyViewController<View: CompanyView>: BaseViewController<View>, UICollectionViewDataSource {
    
    private let companyNetworkingService = CompanyNetworkingService.shared
    
    var company: Company?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(statusManager),
            name: .flagsChanged,
            object: nil
        )
        rootView.companyCollectionView.dataSource = self
        updateUserInterface()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        rootView.companyCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    private func fetchCompanyData() {
        companyNetworkingService.getCompanyInfo { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let company):
                    self?.company = .init(name: company.name, employees: company.employees.sorted(by: {
                        $0.name < $1.name
                    }))
                    self?.rootView.companyCollectionView.reloadData()
                    self?.title = company.name
                case .failure:
                    self?.rootView.update(with: .noData)
                }
            }
        }
    }
    
    func updateUserInterface() {
        switch Network.reachability.status {
        case .unreachable:
            rootView.update(with: .noInternet)
            company = companyNetworkingService.lookInCache()
            self.title = company?.name
            if company == nil { rootView.update(with: .noData) }
        default:
            fetchCompanyData()
            rootView.update(with: .hasInternet)
        }
        Network.logs()
    }
    
    @objc func statusManager(_ notification: Notification) {
        updateUserInterface()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return company?.employees.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.create(cell: EmployeeCell.self, at: indexPath), let company = company else {
            fatalError("🚨 [Error] Cant dequeue 'EmployeeCell' ")
        }
        cell.configure(with: company.employees[indexPath.row])
        return cell
    }
}
