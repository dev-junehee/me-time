//
//  ViewModelType.swift
//  me-time
//
//  Created by junehee on 10/25/24.
//

import Foundation
import Combine

protocol ViewModelType: AnyObject, ObservableObject {
    associatedtype Action
    associatedtype Input
    associatedtype Output
    
    var cancellables: Set<AnyCancellable> { get set }
    var input: Input { get set }
    var output: Output { get set }
    
    func transform()
}
