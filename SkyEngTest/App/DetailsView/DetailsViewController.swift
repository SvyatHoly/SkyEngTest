//
//  DetailsViewController.swift
//  SkyEngTest
//
//  Created by Svyatoslav Ivanov on 27.01.2021.
//

import UIKit
import RxSwift
import RxCocoa

final class DetailsViewController: UIViewController, BindableType {
    
    // MARK: - Properties
    // MARK: Viewmodel
    var viewModel: DetailsViewModelType!
    
    // MARK: View components
    private var imageView = UIImageView.imageView
    private let textView = UILabel.textView
    private let translationView = UILabel.translationView
    private let closeButton = UIButton.closeButton
    
    // MARK: Private
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    deinit {
        Logger.info("DetailsViewController dellocated")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        viewModel.input.dismissed.onNext(Void())
    }
    
    private func setUpView() {
        self.view.backgroundColor = ColorPreference.tertiaryColor
        
        self.view.addSubview(imageView)
        self.view.addSubview(textView)
        self.view.addSubview(translationView)
        self.view.addSubview(closeButton)
        
        closeButton.addTarget(self, action: #selector(handleCloseButtonPress), for: .touchUpInside)
        
        let layoutGuide = self.view.safeAreaLayoutGuide
        
        closeButton.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: Constraints.margin).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: Constraints.height).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: Constraints.height).isActive = true
        
        imageView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: Constraints.margin).isActive = true
        imageView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Constraints.imageHeight).isActive = true
        
        textView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constraints.margin).isActive = true
        textView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor).isActive = true
        textView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
        textView.heightAnchor.constraint(equalToConstant: Constraints.height).isActive = true
        
        translationView.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: Constraints.margin).isActive = true
        translationView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor).isActive = true
        translationView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
        translationView.heightAnchor.constraint(equalToConstant: Constraints.height).isActive = true
    }
    
    @objc private func handleCloseButtonPress() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func bindViewModel() {
        let output = viewModel.output
        
        output.word
            .subscribe(onNext: { [weak self] word in
                if word.imageURL != nil {
                    self?.imageView.load(url: word.imageURL!, targetSize: (self?.imageView.bounds.size)!)
                }
                self?.textView.text = word.text
                self?.translationView.text = word.translation
            })
            .disposed(by: disposeBag)
        
    }
}

private extension UIImageView {
    static var imageView: UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}

private extension UILabel {
    static var textView: UILabel {
        let view = UILabel()
        view.textAlignment = .center
        view.textColor = ColorPreference.secondaryColor
        view.font = .boldSystemFont(ofSize: 30)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    static var translationView: UILabel {
        let view = UILabel()
        view.textAlignment = .center
        view.textColor = ColorPreference.secondaryColor
        view.font = .systemFont(ofSize: 24)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}

private extension UIButton {
    static var closeButton: UIButton {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}

private struct Constraints {
    static let margin = CGFloat(16)
    static let height = CGFloat(50)
    static let imageHeight = UIScreen.main.bounds.height/5
    
}
