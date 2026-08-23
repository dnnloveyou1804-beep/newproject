import Foundation
import Network
import UIKit

class LocalProfileServer: ObservableObject {
    private var listener: NWListener?
    private let queue = DispatchQueue(label: "com.primesensilock.server")
    @Published var isRunning = false
    
    init() {
        startServer()
    }
    
    func startServer() {
        guard !isRunning else { return }
        do {
            let parameters = NWParameters.tcp
            listener = try NWListener(using: parameters, on: 8080)
            
            listener?.newConnectionHandler = { [weak self] connection in
                self?.handleConnection(connection)
            }
            
            listener?.start(queue: queue)
            DispatchQueue.main.async {
                self.isRunning = true
            }
        } catch {
            print("LocalProfileServer: Failed to start server - \(error)")
        }
    }
    
    func stopServer() {
        listener?.cancel()
        listener = nil
        DispatchQueue.main.async {
            self.isRunning = false
        }
    }
    
    private func handleConnection(_ connection: NWConnection) {
        connection.start(queue: queue)
        
        // Receive the HTTP Request
        connection.receive(minimumIncompleteLength: 1, maximumLength: 4096) { [weak self] data, _, isComplete, error in
            guard let self = self else { return }
            
            // Check if file exists
            if let fileURL = Bundle.main.url(forResource: "DucThinh", withExtension: "mobileconfig"),
               let fileData = try? Data(contentsOf: fileURL) {
                
                // Construct standard HTTP Response with correct Apple Config Profile MIME type
                let header = """
                HTTP/1.1 200 OK\r
                Content-Type: application/x-apple-aspen-config\r
                Content-Disposition: attachment; filename="DucThinh.mobileconfig"\r
                Content-Length: \(fileData.count)\r
                Connection: close\r
                \r\n
                """
                
                var responseData = header.data(using: .utf8)!
                responseData.append(fileData)
                
                connection.send(content: responseData, completion: .contentProcessed({ _ in
                    connection.cancel()
                }))
            } else {
                let notFound = "HTTP/1.1 404 Not Found\r\nConnection: close\r\n\r\n"
                connection.send(content: notFound.data(using: .utf8)!, completion: .contentProcessed({ _ in
                    connection.cancel()
                }))
            }
        }
    }
    
    func installProfile() {
        if let url = URL(string: "http://127.0.0.1:8080/DucThinh.mobileconfig") {
            DispatchQueue.main.async {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}
