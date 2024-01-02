//
//  Dependency.swift
//  
//
//  Created by Arnaud LE BOURBLANC on 12/11/2023.
//

import DependencyResolver
import Foundation
import Github
import GithubService

public struct Dependency {
    public static func register() {
        let dependencies = DependencyResolver()
            .register(Github.ServiceProtocol.self, resolveClosure: GithubService.Service.init)
        dependencies.build()
    }
}
