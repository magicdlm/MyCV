//
//  MasterViewModel.swift
//  MyCV
//
//  Created by Leming Deng on 2019-06-20.
//  Copyright © 2019 Leming Deng. All rights reserved.
//

import Foundation

final class MasterViewModel {
    
    var filters: Set<String> = [] {
        didSet {
            handleUpdate?()
        }
    }
    var handleUpdate: (() -> Void)?
    
    private let service: CVService
    private var model: Resume?
    
    enum Section {
        case summary([String])
        case experience([Experience])
        
        var title: String {
            switch self {
            case .summary:
                return "Summary of Qualifications".localizedCapitalized
            case .experience:
                return "Professional Experience".localizedCapitalized
            }
        }
        
        var itemNumber: Int {
            switch self {
            case .summary(let s):
                return s.count
            case .experience(let e):
                return e.count
            }
        }
    }
    
    var sections: [Section] {
        guard let resume = model else { return [] }
        return [.summary(resume.summary),
                .experience(resume.experience.filter({ !self.filters.isDisjoint(with: $0.keys) }))]
    }
    
    init(service: CVService = GithubService()) {
        self.service = service
    }
    
    func fetchData(success: @escaping (Profile) -> Void, fail: @escaping (Error) -> Void) {
        service.getCV(success: { (resume) in
            self.model = resume
            self.filters = Set(self.candidates)
            success(resume.profile)
        }, fail: fail)
    }
}

extension MasterViewModel: SearchViewModel {
    var candidates: [String] {
        guard let model = model else { return [] }
        return model.strength.knowledge + model.strength.technical
    }
}

extension Experience {
    var period: String {
        return [startDate, endDate].compactMap {
            $0.map(DateFormatter.displayFormatter.string)
            }.joined(separator: " - ")
    }
}
