//
//  MorningPaperViewModel.swift
//  me-time
//
//  Created by junehee on 10/25/24.
//

import Foundation
import Combine

final class MorningPaperViewModel: ViewModelType {
    
    enum Action {
        case filterButtonTap(MorningPaperFilterCase)
    }
    
    struct Input {
        let filterCase = CurrentValueSubject<MorningPaperFilterCase, Never>(.all)
    }
    
    struct Output {
        var filterCase: MorningPaperFilterCase = .all
    }
    
    var input = Input()
    @Published var output = Output()
    
    var cancellables = Set<AnyCancellable>()
   
    init() {
        transform()
    }
    
    func transform() {
        input.filterCase
            .sink { [weak self] filterCase in
                self?.output.filterCase = filterCase
            }
            .store(in: &cancellables)
    }
    
}

extension MorningPaperViewModel {
    func action(_ action: Action) {
        switch action {
        case .filterButtonTap(let filterCase):
            print("filterButtonTap", filterCase)
            input.filterCase.send(filterCase)
        }
    }
}
