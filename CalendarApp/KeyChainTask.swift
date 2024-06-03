//
//  KeyChainTask.swift
//  CalendarApp
//
//  Created by Rodrigo Adauto Ortiz on 25/05/24.
//

import Foundation
import Security
import SwiftData

class KeyChainTask {
    static func saveToKeyChain(account: String, service: String, data: Data) -> Bool {
//        let tag = "com.example.Rodrigo.CalendarApp".data(using: .utf8)!
        let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
//                kSecAttrApplicationTag as String: tag,
                kSecAttrAccount as String: account,
                kSecAttrService as String: service,
                kSecValueData as String: data
            ]
            
        // Eliminar cualquier elemento existente antes de añadir el nuevo
            SecItemDelete(query as CFDictionary)
            
            // Añadir el nuevo elemento
            let status = SecItemAdd(query as CFDictionary, nil)
            return status == errSecSuccess
    }
    
    static func getToKeyChain(account: String, service: String) -> Data? {
//        let tag = "com.example.Rodrigo.CalendarApp".data(using: .utf8)!
        let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
//                kSecAttrApplicationTag as String: tag,
                kSecAttrAccount as String: account,
                kSecAttrService as String: service,
                kSecReturnData as String: kCFBooleanTrue!,
                kSecMatchLimit as String: kSecMatchLimitOne
            ]
            
            var item: CFTypeRef?
            let status = SecItemCopyMatching(query as CFDictionary, &item)
            
            guard status == errSecSuccess else { return nil }
            return item as? Data
    }
    
}


struct Test {
    func add(task: Task) {
        guard let newTaskData = try? JSONEncoder().encode(task) else { return }
        let isSuccess = KeyChainTask.saveToKeyChain(account: "Testing", service: "app.Rodrigo", data: newTaskData)
    }
    
    func getTask() {
        let data = KeyChainTask.getToKeyChain(account: "Testing", service: "app.Rodrigo")
        guard let data, let task = try? JSONDecoder().decode(Task.self, from: data)
        else {
            return
        }
        print(task)
    }
}

