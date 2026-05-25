import Foundation

enum APIError: Error, LocalizedError, Sendable {
    case missingCredential(String)
    case unauthorized
    case rateLimited
    case networkFailure(String)
    case invalidResponse
    case decodingFailure(String)

    var errorDescription: String? {
        switch self {
        case .missingCredential(let key):
            return "Credencial faltante: \(key). Ve a Configuración para agregarla."
        case .unauthorized:
            return "Credenciales inválidas. Revisa tu configuración."
        case .rateLimited:
            return "Límite de solicitudes alcanzado. Espera un momento."
        case .networkFailure(let message):
            return "Error de red: \(message)"
        case .invalidResponse:
            return "Respuesta inválida del servidor."
        case .decodingFailure(let message):
            return "Error al procesar la respuesta: \(message)"
        }
    }
}
