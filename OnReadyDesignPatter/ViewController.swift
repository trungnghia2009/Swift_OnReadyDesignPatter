//
//  ViewController.swift
//  OnReadyDesignPatter
//
//  Created by trungnghia on 17/07/2021.
//

import UIKit

class ViewController: UIViewController {
    
    var colors = [UIColor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playColorsWhenReady { colors in
            for (index, color) in colors.enumerated() {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.seconds(index)) { [weak self] in
                    self?.view.backgroundColor = color
                }
            }
        }
        getColors()
    }
    
    func getColors() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) { [weak self] in
            self?.colors = [
                .systemRed,
                .systemBlue,
                .systemPink,
                .systemTeal
            ]
            print("is ready")
            if self?.blocks.isEmpty == false {
                self?.blocks.forEach { self?.playColorsWhenReady(completion: $0)}
                self?.blocks.removeAll()
            }
        }
    }
    
    typealias Completion = (([UIColor]) -> Void)
    
    private var blocks = [Completion]()
    
    func playColorsWhenReady(completion: @escaping Completion) {
        guard !colors.isEmpty else {
            blocks.append(completion)
            return
        }
        completion(colors)
    }
}

