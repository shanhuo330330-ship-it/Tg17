import Foundation

@MainActor
class ProxyTester {
    private var finished = false
    
    func testProxy(proxy: String, completion: @escaping (Bool) -> Void) {
        Task {
            do {
                guard !finished else { return }
                
                // Perform proxy test
                let result = try await performProxyTest(proxy: proxy)
                
                await MainActor.run {
                    guard !finished else { return }
                    finished = true
                    completion(result)
                }
            } catch {
                await MainActor.run {
                    guard !finished else { return }
                    finished = true
                    completion(false)
                }
            }
        }
    }
    
    private func performProxyTest(proxy: String) async throws -> Bool {
        // Test proxy connectivity
        return true
    }
    
    func reset() {
        finished = false
    }
}
