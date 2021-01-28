
import Foundation
import UIKit
import RxSwift

class WordCell: UITableViewCell, BindableType {
    // MARK: - Properties
    // MARK: View components
    private lazy var wordName = UILabel.wordLabel

    
    // MARK: Rx
    private let disposeBag = DisposeBag()
    
    // MARK: Viewmodel
    var viewModel: WordCellViewModelType!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Loading this view from a nib is unsupported in favor of initializer dependency injection.")
    }
    
    deinit {
        Logger.info("WordCell dellocated")
    }

    private func setUpView() {
        self.addSubview(wordName)
        
        self.setUpConstraints()
    }
    
    private func setUpConstraints() {
        let layoutGuide = self.safeAreaLayoutGuide
        
        self.wordName.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: Constraints.outerMargins).isActive = true
        self.wordName.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: Constraints.outerMargins).isActive = true
        self.wordName.trailingAnchor.constraint(equalTo: layoutGuide.centerXAnchor, constant: Constraints.outerMargins).isActive = true
        
    }
    
    func bindViewModel() {
        let output = viewModel.output
        
        output.word
            .map { $0.text }
            .bind(to: wordName.rx.text)
            .disposed(by: disposeBag)
    }
}

private struct Constraints {
    static let outerMargins = CGFloat(8)
    static let innerMargins = CGFloat(4)
}


private extension UILabel {
    static var wordLabel: UILabel {
        let label = UILabel()
        label.textColor = ColorPreference.secondaryColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
}
