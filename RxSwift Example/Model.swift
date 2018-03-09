//
//  Model.swift
//  RxSwift Example
//
//  Created by Owen Thomas on 3/9/18.
//  Copyright © 2018 Owen Thomas. All rights reserved.
//

import RxSwift

struct Model {
  static var singleton = Model(0, 0.5)
  
  private var c: Variable<Int>
  private var t: Variable<Double>
  
  init(_ c: Int, _ t: Double) {
    self.c = Variable<Int>(c)
    self.t = Variable<Double>(t)
  }
  
  func increase(_ by: Int = 1) {
    c.value += by
  }
  
  func decrease(_ by: Int = 1) {
    c.value -= by
  }
  
  func setThrottle(_ to: Double) {
    t.value = to
  }
  
  func setThrottle(_ to: Float) {
    t.value = Double(to)
  }
  
  var countText: Observable<String> {
    return c.asObservable().map({ String($0) }).throttle(t.value, scheduler: MainScheduler.instance)
  }
  
  var throttleValue: Observable<Double> {
    return t.asObservable().throttle(0.25, scheduler: MainScheduler.instance)
  }
  
  var throttleText: Observable<String> {
    return t.asObservable().map({ String(format: "%.2f seconds", $0)})
  }
}
