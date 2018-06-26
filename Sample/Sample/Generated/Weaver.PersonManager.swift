/// This file is generated by Weaver 0.9.10
/// DO NOT EDIT!
import API
import Foundation
import WeaverDI
// MARK: - PersonManager
protocol PersonManagerDependencyResolver {
    var logger: Logger { get }
    var movieAPI: APIProtocol { get }
}
protocol PersonManagerDependencyInjectable {
    init(injecting dependencies: PersonManagerDependencyResolver)
}
extension PersonManager: PersonManagerDependencyInjectable {}