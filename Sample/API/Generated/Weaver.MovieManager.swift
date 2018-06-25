/// This file is generated by Weaver 0.9.10
/// DO NOT EDIT!
import Foundation
import WeaverDI
// MARK: - MovieManager
final class MovieManagerDependencyContainer: DependencyContainer {
    let host: String?
    init(parent: DependencyContainer? = nil, host: String?) {
        self.host = host
        super.init(parent)
    }
    override func registerDependencies(in store: DependencyStore) {
        store.register(APIProtocol.self, scope: .graph, name: "movieAPI", builder: { (dependencies) in
            return MovieAPI.makeMovieAPI(injecting: dependencies)
        })
        store.register(URLSession.self, scope: .container, name: "urlSession", builder: { (dependencies) in
            return self.urlSessionCustomRef()
        })
    }
}
protocol MovieManagerDependencyResolver {
    var host: String? { get }
    var movieAPI: APIProtocol { get }
    var urlSession: URLSession { get }
    var logger: Logger { get }
    func urlSessionCustomRef() -> URLSession
}
extension MovieManagerDependencyContainer: MovieManagerDependencyResolver {
    var movieAPI: APIProtocol {
        return resolve(APIProtocol.self, name: "movieAPI")
    }
    var urlSession: URLSession {
        return resolve(URLSession.self, name: "urlSession")
    }
    var logger: Logger {
        return resolve(Logger.self, name: "logger")
    }
}
extension MovieManager {
    static func makeMovieManager(injecting parentDependencies: DependencyContainer, host: String?) -> MovieManager {
        let dependencies = MovieManagerDependencyContainer(parent: parentDependencies, host: host)
        return MovieManager(injecting: dependencies)
    }
}
protocol MovieManagerDependencyInjectable {
    init(injecting dependencies: MovieManagerDependencyResolver)
}
extension MovieManager: MovieManagerDependencyInjectable {}
// MARK: - MovieManagerShim
final class MovieManagerShimDependencyContainer: DependencyContainer {
    private lazy var internalDependencies: MovieManagerDependencyContainer = {
        return MovieManagerDependencyContainer(parent: self, host: self.host)
    }()
    let logger: Logger
    let host: String?
    init(logger: Logger, host: String?) {
        self.logger = logger
        self.host = host
        super.init()
    }
    override func registerDependencies(in store: DependencyStore) {
        store.register(Logger.self, scope: .container, name: "logger", builder: { _ in
            return self.logger
        })
    }
}
extension MovieManagerShimDependencyContainer: MovieManagerDependencyResolver {
    var movieAPI: APIProtocol {
        return internalDependencies.resolve(APIProtocol.self, name: "movieAPI")
    }
    var urlSession: URLSession {
        return internalDependencies.resolve(URLSession.self, name: "urlSession")
    }
}
extension MovieManager {
    public convenience init(logger: Logger, host: String?) {
        let shim = MovieManagerShimDependencyContainer(logger: logger, host: host)
        self.init(injecting: shim)
    }
}