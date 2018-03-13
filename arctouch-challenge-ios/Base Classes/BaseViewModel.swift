//
//  BaseViewModel.swift
//  arctouch-challenge-ios
//
//  Created by Pedro H J Fabrino on 10/03/18.
//  Copyright © 2018 AIS Digital. All rights reserved.
//

import Foundation
import RxSwift

class BaseViewModel: NSObject {
    
    // MARK: Properties
    weak var delegate: ViewModelType?
    var disposeBag: DisposeBag = DisposeBag()
    
    private func setupObservers() {
        
    }
    
    private func removeObservers() {
        
    }
}
