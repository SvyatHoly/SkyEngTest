//
//  SplitViewController.swift
//  SkyEngTest
//
//  Created by Svyatoslav Ivanov on 27.01.2021.
//

import Foundation
import RxSwift
import RxDataSources
import RxCocoa

final class SplitViewController: UIViewController, BindableType {
    
    // MARK: - Properties
    // MARK: View components
    private lazy var textInput = UITextField.inputText
    private lazy var wordsTableView = UITableView.defaultTableView
    
    // MARK: Section models
    typealias WordsSectionModel = SectionModel<String, WordCellViewModelType>
    
    // MARK: Data sources
    private var wordsDataSource: RxTableViewSectionedReloadDataSource<WordsSectionModel>!
    
    // MARK: Private fields
    private let disposeBag = DisposeBag()
    
    // MARK: Public fields
    var viewModel: SplitViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupToHideKeyboardOnTapOnView()
        self.view.backgroundColor = ColorPreference.tertiaryColor
        title = "Search"
        self.setUpView()
    }
    
    deinit {
        Logger.info("SplitViewController dellocated")
    }
    
    private func setUpView() {
        self.view.addSubview(textInput)
        
        configureTableView()
        self.view.addSubview(wordsTableView)
        
        let layoutGuide = self.view.safeAreaLayoutGuide
        
        textInput.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: Constraints.offset).isActive = true
        textInput.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: Constraints.innerMargins).isActive = true
        textInput.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -Constraints.innerMargins).isActive = true
        textInput.heightAnchor.constraint(equalToConstant: Constraints.inputHeight).isActive = true
        
        wordsTableView.topAnchor.constraint(equalTo: textInput.bottomAnchor, constant: Constraints.padding).isActive = true
        wordsTableView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor).isActive = true
        wordsTableView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
        wordsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func configureTableView() {
        wordsTableView.register(WordCell.self, forCellReuseIdentifier: "wordCell")
        wordsDataSource = RxTableViewSectionedReloadDataSource<WordsSectionModel>(
            configureCell:  wordsTableViewDataSource
        )
    }
    
    
    func bindViewModel() {
        guard let viewModel = self.viewModel else { return }
        
        let input = viewModel.input
        let output = viewModel.output
        
        textInput.rx.text
            .orEmpty
            .subscribe(onNext: { [weak self] (value: String) -> Void in
                guard let self = self else { return }
                input.textFieldPromted(from: self, text: value)
            })
            .disposed(by: disposeBag)
        
        wordsTableView.rx.itemSelected
            .flatMap { [weak self] indexPath -> Observable<WordCell> in
                guard let cell = self?.wordsTableView.cellForRow(at: indexPath) as? WordCell
                    else { return .empty() }
                self?.wordsTableView.deselectRow(at: indexPath, animated: true)
                return .just(cell)
            }
        .map { $0.viewModel }
            .flatMap { $0.output.word }
        .bind(to: input.presentDetails)
            .disposed(by: self.disposeBag)
        
        output.wordCellsModelType
            .map { [WordsSectionModel(model: "", items: $0)]}
            .bind(to: wordsTableView.rx.items(dataSource: wordsDataSource))
            .disposed(by: disposeBag)
        
    }
    
    private var wordsTableViewDataSource:
        RxTableViewSectionedReloadDataSource<WordsSectionModel>.ConfigureCell {
        return { _, tableView, indexPath, cellModel in
            var cell: WordCell = tableView.dequeueReusableCell(withIdentifier: "wordCell", for: indexPath) as! WordCell
            cell.bind(to: cellModel)
            return cell
        }
    }
}

private struct Constraints {
    static let innerMargins = CGFloat(10)
    static let padding = CGFloat(20)
    static let offset = UIScreen.main.bounds.height/10
    static let inputHeight = CGFloat(50)
}


private extension UITextField {
    static var inputText: UITextField {
        let field = UITextField()
        field.backgroundColor = ColorPreference.mainColor
        field.textColor = ColorPreference.secondaryColor
        field.placeholder = "Text"
        field.setLeftPaddingPoints(10)
        field.setRightPaddingPoints(10)
        field.layer.cornerRadius = 20
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }
}
