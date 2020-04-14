//
//  ViewController.swift
//  KeychainBundleIDSample
//
//  Created by Fumiya Tanaka on 2020/04/07.
//  Copyright © 2020 Fumiya Tanaka. All rights reserved.
//

import UIKit
import Security

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func addItem() {
        let account: String = "account"
        let password: Data = "password".data(using: .utf8)!
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: Bundle.main.bundleIdentifier!,
            kSecAttrAccount as String: account,
            kSecValueData as String: password
        ]
        let status = SecItemAdd(query as CFDictionary, nil)
        assert(status == errSecSuccess)
        print("succeed adding")
    }
    
    @IBAction private func fetchItem() {
        let query: [String: Any] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrService as String: Bundle.main.bundleIdentifier!,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ]
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        assert(status != errSecItemNotFound)
        assert(status == errSecSuccess)
        guard let existingItem = item as? [String: Any],
            let passwordData = existingItem[kSecValueData as String] as? Data,
            let password = String(data: passwordData, encoding: String.Encoding.utf8),
            let account = existingItem[kSecAttrAccount as String] as? String else {
                assert(false)
                return
        }
        assert(account == "account")
        assert(password == "password")
        print("succeed fetching")
    }
    
    @IBAction private func deleteItem() {
        
    }
    
}

