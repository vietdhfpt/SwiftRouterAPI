//
//  ViewController.swift
//  RouterAPI
//
//  Created by Gia Han on 5/6/20.
//  Copyright © 2020 vn.netstars. All rights reserved.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    var publishers = [AnyCancellable]()
    let catFactApi = CatFactApi()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }

    private func fetchData() {
        catFactApi.randomFact()
            .map { $0.text }
            .sink(receiveCompletion: { err in
                print(err)
            }, receiveValue: {
                print($0.description)
            })
            .store(in: &publishers)
    }
}

