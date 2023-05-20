//
//  NetworkError.swift
//  GualdoTube
//
//  Created by Eduardo De La Cruz on 20/5/23.
//

import Foundation

enum NetworkError: String, Error {
    case invalidURL
    case serializationFailed
    case generic
    case couldNotDecodeData
    case httpResponseError
    case statusCodeError
    case jsonDecoder
    case unauthorized
}

extension NetworkError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("La URL es inválida", comment: "")
        case .serializationFailed:
            return NSLocalizedString("Falló cuando se trató de serializar el body del request", comment: "")
        case .generic:
            return NSLocalizedString("La app faló por un error desconocido, validar API-Key", comment: "")
        case .couldNotDecodeData:
            return NSLocalizedString("No se pudo hacer el decode de la data", comment: "")
        case .httpResponseError:
            return NSLocalizedString("Imposible obtener el HTTPURLResponse", comment: "")
        case .statusCodeError:
            return NSLocalizedString("El status code es diferente a 200", comment: "")
        case .jsonDecoder:
            return NSLocalizedString("Falló cuando leyó el JSON y no pudo decodificar", comment: "")
        case .unauthorized:
            return NSLocalizedString("La sesión finalizó, vuelva a iniciarla", comment: "")
        }
    }
}
