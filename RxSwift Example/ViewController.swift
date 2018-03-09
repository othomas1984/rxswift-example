//
//  ViewController.swift
//  RxSwift Example
//
//  Created by Owen Thomas on 3/8/18.
//  Copyright © 2018 Owen Thomas. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
  var model = Model.singleton
  var countObserver: Disposable?
  var disposeBag = DisposeBag()
  
  @IBOutlet weak var valueLabel: UILabel!
  @IBOutlet weak var throttleLabel: UILabel!
  
}

// MARK: - Lifecycle Extension
extension ViewController {
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupCountObserver()
    setupThrottleObservers()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    countObserver?.dispose()
  }
  
  private func setupCountObserver() {
    // Dispose of existing count observer if it exists
    countObserver?.dispose()
    
    // Setup new observer to update count label
    countObserver = model.countText.bind(to: valueLabel.rx.text)
  }
  
  private func setupThrottleObservers() {
    // Setup observer to restart count observer whenever throttle value changes
    let trottleObserver1 = model.throttleValue.subscribe { _ in self.setupCountObserver() }
    disposeBag.insert(trottleObserver1)
    
    // Setup observer to show new throttle value
    let trottleObserver2 = model.throttleText.bind(to: throttleLabel.rx.text)
    disposeBag.insert(trottleObserver2)
  }
}

// MARK: - Actions Extension
extension ViewController {
  @IBAction func addTapped(_ sender: Any) { model.increase() }
  @IBAction func subtractTapped(_ sender: Any) { model.decrease() }
  @IBAction func throttleSliderChanged(_ sender: UISlider) { model.setThrottle(sender.value) }
}

