//
//  SuperVipPromoViewModel.swift
//  BadgesTutorial
//
//  Created by Alexander Korchak on 15.11.2023.
//

import Combine

// MARK: - Constant

extension SuperVipPromoViewModel {
    struct Constant {
        static let connect = "Подключить"
        static let disconnect = "Отключить"
    }
}

final class SuperVipPromoViewModel: ObservableObject {
    // MARK: - Attributes

    @Published var modelPublisher: SuperVipPromoModel?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Methods

    func sendDataToView() {
        modelPublisher = mockData
    }
}

// MARK: - Mock data

private extension SuperVipPromoViewModel {
    var mockData: SuperVipPromoModel {
        SuperVipPromoModel(
            mainLabelText: "Супер VIP на 30 дней",
            descriptionLabelText: "Только до 15 января вы можете подключить Супер VIP на 30 дней вместо 90 дней. Попробуйте полный безлимит всего за 45 000 UZS.",
            imageName: "premium",
            cashbackLabelText: "Вы получите кешбэк до 15%",
            connectButtonText: "Подключить",
            bottomButtonText: "Изменить с 6 октября"
        )
    }
}
