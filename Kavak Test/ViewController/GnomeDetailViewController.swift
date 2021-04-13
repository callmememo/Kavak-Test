//
//  GnomeDetailViewController.swift
//  Kavak Test
//
//  Created by Memo on 4/13/21.
//

import UIKit

class GnomeDetailViewController: MVVMViewController<GnomeDetailViewModel> {
    
    weak var containerView: UIView!
    weak var titleLabel: UILabel!
    weak var ageLabel: UILabel!
    weak var weightLabel: UILabel!
    weak var heightLabel: UILabel!
    weak var hairLabel: UILabel!
    weak var tableView: UITableView!
    
    override func loadView() {
        super.loadView()
        
        let containerView = UIView()
        let titleLabel = UILabel()
        let ageLabel = UILabel()
        let weightLabel = UILabel()
        let heightLabel = UILabel()
        let hairLabel = UILabel()
        let tableView = UITableView()
        
        [containerView,
         tableView].forEach { view.addSubview($0) }
        
        [ageLabel,
         weightLabel,
         heightLabel,
         titleLabel,
         hairLabel].forEach { containerView.addSubview($0) }
        
        containerView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view).inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.height.equalTo(200)
        }
        
        tableView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view)
            $0.top.equalTo(containerView.snp.bottom).offset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(containerView).inset(20)
            $0.top.equalTo(containerView).offset(20)
        }
        
        ageLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(containerView).inset(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
        
        weightLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(containerView).inset(20)
            $0.top.equalTo(ageLabel.snp.bottom).offset(10)
        }
        
        heightLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(containerView).inset(20)
            $0.top.equalTo(weightLabel.snp.bottom).offset(10)
        }
        
        hairLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(containerView).inset(20)
            $0.top.equalTo(heightLabel.snp.bottom).offset(10)
        }
        
        self.containerView = containerView
        self.titleLabel = titleLabel
        self.ageLabel = ageLabel
        self.weightLabel = weightLabel
        self.heightLabel = heightLabel
        self.hairLabel = hairLabel
        self.tableView = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
}

extension GnomeDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self)) else { return UITableViewCell() }
        cell.backgroundColor = .clear
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = viewModel.text(at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.title(at: section)
    }
}

private extension GnomeDetailViewController {
    func configureUI() {
        
        viewModel.setup()
        
        navigationItem.title = "Details"
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = .label
        
        view.backgroundColor = .tertiarySystemBackground
        
        containerView.layer.cornerRadius = 10
        containerView.backgroundColor = .secondarySystemBackground
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.textColor = UIColor.label
        titleLabel.text = viewModel.nameText
        
        ageLabel.font = UIFont.systemFont(ofSize: 14)
        ageLabel.tintColor = .secondaryLabel
        ageLabel.attributedText = viewModel.ageText
        
        weightLabel.font = UIFont.systemFont(ofSize: 14)
        weightLabel.tintColor = .secondaryLabel
        weightLabel.attributedText = viewModel.weightText
        
        heightLabel.font = UIFont.systemFont(ofSize: 14)
        heightLabel.tintColor = .secondaryLabel
        heightLabel.attributedText = viewModel.heightText
        
        hairLabel.font = UIFont.systemFont(ofSize: 14)
        hairLabel.tintColor = .secondaryLabel
        hairLabel.attributedText = viewModel.hairColorNameText
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .tertiarySystemBackground
    }
}

extension UIViewController {
    
    func showGnomeDetailViewController(gnome: Gnome) {
        let viewModel = GnomeDetailViewModel(gnome: gnome)
        let controller = GnomeDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(controller, animated: true)
    }
}
