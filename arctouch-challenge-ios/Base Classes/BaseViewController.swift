//
//  BaseViewController.swift
//  arctouch-challenge-ios
//
//  Created by Pedro H J Fabrino on 10/03/18.
//  Copyright © 2018 AIS Digital. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController<T>: UIViewController {
    
    // MARK: Properties
    var viewModel: T?
    let disposeBag = DisposeBag()
    
    
    private var didSetupBinding: Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !didSetupBinding {
            setupBindings()
            didSetupBinding = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupBindings() {
        
    }
}
