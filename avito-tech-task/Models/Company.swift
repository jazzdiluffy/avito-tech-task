import Foundation

struct Company: Codable {
    let name: String
    let employees: [Employee]
}

struct Employee: Codable {
    let name: String
    let phoneNumber: String
    let skills: [String]
    
    enum CodingKeys: String, CodingKey {
        case name
        case phoneNumber = "phone_number"
        case skills
    }
}
