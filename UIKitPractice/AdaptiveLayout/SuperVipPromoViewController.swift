import UIKit
import Combine

final class SuperVipPromoViewController: UIViewController {
    // MARK: - Constant
    
    private enum Constants {
        static let imageViewSize: CGFloat = 228
        static let detailsButtonColor = UIColor(
            red: 1/255,
            green: 21/255,
            blue: 60/255,
            alpha: 0.68
        )
        static let cashbackLabelColor = UIColor(
            red: 108/255,
            green: 192/255,
            blue: 177/255,
            alpha: 1
        )

        static let viewWidth: CGFloat = 335
    }
    
    // MARK: - Attributes

    private var cancellables = Set<AnyCancellable>()
    private var viewModel: SuperVipPromoViewModel = .init()
    private var topConstraint: NSLayoutConstraint?

    @Autolayout private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    @Autolayout private var mainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()

    @Autolayout private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()

    @Autolayout private var detailsButton: UIButton = {
        let button = UIButton()
        return button
    }()

    @Autolayout private var bannerContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray.withAlphaComponent(0.5)
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        return view
    }()

    @Autolayout private var cashbackLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = Constants.cashbackLabelColor
        label.textAlignment = .center
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    @Autolayout private var connectButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 24
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        return button
    }()
    

    @Autolayout private var bottomButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        return button
    }()
    
    
    // MARK: - Action
    
    @objc private func connectButtonTapped() {
        if bottomButton.isHidden == true {
            Animator.animateInTop(self, willShowButton: bottomButton, constraint: topConstraint)
            connectButton.setTitle(SuperVipPromoViewModel.Constant.disconnect, for: .normal)
        } else {
            Animator.animateInBottom(self, willHideButton: bottomButton, constraint: topConstraint)
            connectButton.setTitle(SuperVipPromoViewModel.Constant.connect, for: .normal)
        }
    }
    
    // MARK: - Life Cycle

    public override func viewDidLoad() {
        super.viewDidLoad()
        bindPublishers()
        viewModel.sendDataToView()
        setupAction()
        setupUI()
    }
    
    // MARK: - Methods
    
    private func setupAction() {
        connectButton.addTarget(self, action: #selector(connectButtonTapped), for: [.touchUpInside])
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        bottomButton.isHidden = true

        view.addSubviews([
            imageView,
            mainLabel,
            descriptionLabel,
            detailsButton,
            bannerContainerView,
            cashbackLabel,
            connectButton,
            bottomButton
        ])


        let detailsButtonAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .regular),
            .foregroundColor: Constants.detailsButtonColor,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
        ]
        let attributedString = NSMutableAttributedString(
            string: "Подробнее",
            attributes: detailsButtonAttributes
        )
        detailsButton.setAttributedTitle(attributedString, for: .normal)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: Constants.imageViewSize),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageViewSize),

            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 32),
            mainLabel.heightAnchor.constraint(equalToConstant: 30),
            mainLabel.widthAnchor.constraint(equalToConstant: Constants.viewWidth),

            descriptionLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.widthAnchor.constraint(equalToConstant: Constants.viewWidth),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 96),

            detailsButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            detailsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            detailsButton.heightAnchor.constraint(equalToConstant: 24),

            bannerContainerView.topAnchor.constraint(equalTo: detailsButton.bottomAnchor, constant: 26),
            bannerContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bannerContainerView.widthAnchor.constraint(equalToConstant: Constants.viewWidth),
            bannerContainerView.heightAnchor.constraint(equalToConstant: 112),

            cashbackLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cashbackLabel.heightAnchor.constraint(equalToConstant: 24),
            cashbackLabel.widthAnchor.constraint(equalToConstant: 200),

            connectButton.topAnchor.constraint(equalTo: cashbackLabel.bottomAnchor, constant: 8),
            connectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            connectButton.heightAnchor.constraint(equalToConstant: 64),
            connectButton.widthAnchor.constraint(equalToConstant: Constants.viewWidth),

            bottomButton.topAnchor.constraint(equalTo: connectButton.bottomAnchor, constant: 12),
            bottomButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomButton.widthAnchor.constraint(equalToConstant: Constants.viewWidth),
            bottomButton.heightAnchor.constraint(equalToConstant: 64)
        ])
        
        topConstraint = cashbackLabel.topAnchor.constraint(equalTo: bannerContainerView.bottomAnchor, constant: 60)
        topConstraint?.isActive = true
    }
}

// MARK: - Bind publishers

private extension SuperVipPromoViewController {
    func bindPublishers() {
        viewModel.$modelPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] model in
                guard let self = self else { return }
                self.imageView.image = UIImage(named: model?.imageName ?? "")
                self.mainLabel.text = model?.mainLabelText
                self.descriptionLabel.text = model?.descriptionLabelText
                self.cashbackLabel.text = model?.cashbackLabelText
                self.bottomButton.setTitle(model?.bottomButtonText, for: .normal)
                self.connectButton.setTitle(model?.connectButtonText, for: .normal)
            }
            .store(in: &cancellables)
    }
}
