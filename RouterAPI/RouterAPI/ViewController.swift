//
//  ViewController.swift
//  RouterAPI
//
//  Created by Gia Han on 5/6/20.
//  Copyright © 2020 vn.netstars. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let catFactApi = CatFactApi()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }

    private func fetchData() {
        catFactApi.randomFact {
            switch $0 {
            case .failure(let err):
                NSLog(err.localizedDescription)
            case .success(let fact):
                print(fact)
            }
        }
    }
}

