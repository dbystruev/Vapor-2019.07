import Routing
import Vapor

/// Register your application's routes here.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#routesswift)
public func routes(_ router: Router) throws {
    router.get { req -> Future<View> in
        let context = [String: String]()
        return try req.view().render("home", context)
    }
    
    router.get("help", String.parameter) { req -> Future<View> in
        let topic = try req.parameters.next(String.self)
        
        let topics = [
            "swift": "Swift — классный язык программирования",
            "vapor": "Vapor — сервер, построенный на Swift",
            "default": "Не понял вопроса.  Спросите «swift» или «vapor»"
        ]
        
        struct HelpView: Codable {
            var topic: String?
            var answer: String?
        }
        
        let answer = topics[topic.lowercased()] ?? topics["default"]!
        let context = HelpView(topic: topic, answer: answer)
        
        return try req.view().render("help", context)
    }
    
    router.get("contact") { req -> Future<View> in
        let context = [String: String]()
        return try req.view().render("contact", context)
    }
}
