//
//  ClientIdClientServerTextFieldValidator.swift
//  wallabag
//
//  Created by Marinel Maxime on 10/10/2019.
//

import Foundation
import SwiftUI
import Combine

class ClientIdClientSecretTextFieldValidator: ObservableObject {
    private(set) var isValid: Bool = false {
        didSet {
            WallabagUserDefaults.clientId = clientId
            WallabagUserDefaults.clientSecret = clientSecret
        }
    }

    @Published var clientId: String = ""
    @Published var clientSecret: String = ""
    
    private var cancellable: AnyCancellable?

    init() {
        clientId = WallabagUserDefaults.clientId
        clientSecret = WallabagUserDefaults.clientSecret
        
        cancellable = Publishers.CombineLatest($clientId, $clientSecret).sink { clientId, clientSecret in
            self.isValid = !clientId.isEmpty && !clientSecret.isEmpty
        }
    }
    
    deinit {
        cancellable?.cancel()
    }
}
