import Foundation

struct ProxyProfile: Codable, Identifiable, Equatable {
    let id: UUID
    var name: String
    var host: String
    var port: Int
    var username: String?
    var password: String?
    var proxyProtocol: ProxyProtocol
    var isActive: Bool = false
    var createdAt: Date
    var lastUsedAt: Date?
    
    enum ProxyProtocol: String, Codable, CaseIterable {
        case http
        case https
        case socks5
        case socks4a
        
        var displayName: String {
            switch self {
            case .http: return "HTTP"
            case .https: return "HTTPS"
            case .socks5: return "SOCKS5"
            case .socks4a: return "SOCKS4a"
            }
        }
    }
    
    init(name: String, host: String, port: Int, username: String? = nil, password: String? = nil, proxyProtocol: ProxyProtocol = .http) {
        self.id = UUID()
        self.name = name
        self.host = host
        self.port = port
        self.username = username
        self.password = password
        self.proxyProtocol = proxyProtocol
        self.isActive = false
        self.createdAt = Date()
        self.lastUsedAt = nil
    }
    
    var displayString: String {
        "\(host):\(port) (\(proxyProtocol.displayName))"
    }
    
    var isValid: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty &&
        !host.trimmingCharacters(in: .whitespaces).isEmpty &&
        port > 0 && port < 65536
    }
}
