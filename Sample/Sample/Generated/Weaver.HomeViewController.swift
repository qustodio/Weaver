/// This file is generated by Weaver
/// DO NOT EDIT!
import Weaver
// MARK: - HomeViewController
final class HomeViewControllerDependencyContainer: DependencyContainer {
    init(parent: DependencyContainer) {
        super.init(parent)
    }
    override func registerDependencies(in store: DependencyStore) {
        store.register(UIViewController.self, scope: .transient, name: "movieController", builder: { (dependencies, movieID: UInt, title: String) in
            return MovieViewController.makeMovieViewController(injecting: dependencies, movieID: movieID, title: title)
        })
        store.register(Logger.self, scope: .graph, name: "logger", builder: { (dependencies) in
            return Logger.makeLogger(injecting: dependencies)
        })
    }
}
protocol HomeViewControllerDependencyResolver {
    func movieController(movieID: UInt, title: String) -> UIViewController
    var logger: Logger { get }
    var movieManager: MovieManaging { get }
}
extension HomeViewControllerDependencyContainer: HomeViewControllerDependencyResolver {
    func movieController(movieID: UInt, title: String) -> UIViewController {
        return resolve(UIViewController.self, name: "movieController", parameters: movieID, title)
    }
    var logger: Logger {
        return resolve(Logger.self, name: "logger")
    }
    var movieManager: MovieManaging {
        return resolve(MovieManaging.self, name: "movieManager")
    }
}
extension HomeViewController {
    static func makeHomeViewController(injecting parentDependencies: DependencyContainer) -> HomeViewController {
        let dependencies = HomeViewControllerDependencyContainer(parent: parentDependencies)
        return HomeViewController(injecting: dependencies)
    }
}
protocol HomeViewControllerDependencyInjectable {
    init(injecting dependencies: HomeViewControllerDependencyResolver)
}
extension HomeViewController: HomeViewControllerDependencyInjectable {}