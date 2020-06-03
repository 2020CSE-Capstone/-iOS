//
//  DependencyPool.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/06/03.
//  Copyright © 2020 남수김. All rights reserved.
//

import Foundation

class DependencyContainer {
    private let dependencyPool = DependencyPool()
    
    public static let shared: DependencyContainer = DependencyContainer()
    
    private init() {
       
        let communityService: CommunityServiceProtocol = CommunityServiceImp()
        
        do {
            try dependencyPool.register(key: .communityService,
                                        dependency: communityService)
        } catch {
            fatalError("register Fail")
        }
        
    }
    
    public func getDependency<T>(key: DependencyKey) -> T {
        do {
            return try dependencyPool.pullOutDependency(key: key)
        } catch DependencyError.keyAlreadyExistsError {
            fatalError("keyAlreadyExistError")
        } catch DependencyError.unregisteredKeyError {
            fatalError("unregisteredKeyError")
        } catch DependencyError.downcastingFailureError {
            fatalError("downcastingFailureError")
        } catch {
            fatalError("getDependency Fail")
        }
    }
}

enum DependencyKey {
    case communityService
}
