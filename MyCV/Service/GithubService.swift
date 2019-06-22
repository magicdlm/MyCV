//
//  GithubService.swift
//  MyCV
//
//  Created by Leming Deng on 2019-06-21.
//  Copyright © 2019 Leming Deng. All rights reserved.
//

import Foundation

final class GithubService: CVService {
    private enum Url: String {
        case resume
        
        var url: URL {
            switch self {
            case .resume:
                return URL(string: "https://gist.github.com/magicdlm/23997deed71081b42d62b3cfc580e57a/raw/363a0d11e4fe8be7e4df60b7404baf5b35006284/lemingdengCV.json")!
            }
        }
    }
    
    
    private let session = URLSession.shared
    
    func getCV(success: @escaping (Resume) -> Void, fail: @escaping (Error) -> Void) {
        session.dataTask(with: Url.resume.url) { (data, _, error) in
            guard let data = data else {
                fail(error ?? ServiceError.unknown)
                return
            }
            
            do {
                success(try self.decoder.decode(Resume.self, from: data))
            } catch {
                debugPrint(error)
                fail(error)
            }
            }.resume()
    }
}
