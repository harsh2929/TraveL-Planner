import Foundation

class UserManager {
    static let shared = UserManager()

    var username: String?
    var name: String?
    var email: String?
    var numberOfContributions: Int?
    private init() {
        
    }
}
