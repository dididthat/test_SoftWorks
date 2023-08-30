//
//  MainViewController.swift
//  test
//
//  Created by Diana Nikulina on 30.08.2023.
//

import UIKit
import SnapKit

protocol MainFlowInput: AnyObject {
    func reloadData()
    func showError()
}

final class MainViewController: UIViewController {
    
    private let output: MainFlowOutput
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        
        tableView.register(DeviceTableViewCell.self, forCellReuseIdentifier: DeviceTableViewCell.identifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private let reloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("ОБНОВИТЬ", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 25
        button.configuration = .plain()
        button.configuration?.contentInsets = .init(top: 15, leading: 24, bottom: 15, trailing: 24)
        return button
    }()
    
    init(
        output: MainFlowOutput
    ) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindButton()
        
        output.viewDidLoad()
    }
    
    private func setupUI() {
        view.backgroundColor = .background
        
        view.addSubview(tableView)
        view.addSubview(reloadButton)
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(view.snp.leading).inset(30)
            $0.trailing.equalTo(view.snp.trailing).inset(30)
            $0.bottom.equalTo(view.snp.bottom)
        }
        
        reloadButton.snp.makeConstraints {
            $0.trailing.equalTo(view.snp.trailing).inset(17)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(26)
        }
    }
    
    private func bindButton() {
        reloadButton.addTarget(self, action: #selector(reloadButtonDidTap), for: .touchUpInside)
    }
    
    @objc
    private func reloadButtonDidTap() {
        output.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output.viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(of: DeviceTableViewCell.self, for: indexPath),
           let model = output.viewModels[safe: indexPath.row] {
            cell.configure(with: model)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        guard editingStyle == .delete else { return }
        
        output.removeItem(at: indexPath.row)
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }
}

// MARK: - MainFlowInput
extension MainViewController: MainFlowInput {
    func reloadData() {
        tableView.reloadData()
    }
    
    func showError() {
        
    }
}
