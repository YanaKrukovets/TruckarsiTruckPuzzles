//
//  StoreConnector.swift
//  TTrukPuzzle
//
//  Created by Yana  on 2020-11-01.
//  Copyright © 2020 Yana . All rights reserved.
//

import Foundation
import StoreKit

class StoreObserver: NSObject, SKPaymentTransactionObserver {
    //Initialize the store observer.
    public var isRemoveAdsPurchased: Bool
    var plistManage = PlistManager()
    
    override init() {
        isRemoveAdsPurchased = false
        super.init()
        SKPaymentQueue.default().add(self)
        print("StoreObserver has been initialized")
        
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    //Observe transaction updates.
    func paymentQueue(_ queue: SKPaymentQueue,updatedTransactions transactions: [SKPaymentTransaction]) {
        print("transaction has been triggered")
        for transaction in transactions {
            switch transaction.transactionState {
                case .purchasing: print("transaction purchasing")
                // Do not block the UI. Allow the user to continue using the app.
                case .deferred: print("transaction deferred")
                // The purchase was successful.
                case .purchased: do {
                    self.isRemoveAdsPurchased = true
                    SKPaymentQueue.default().finishTransaction(transaction)
                    print("SUCCESS! transaction purchased")
                }
                // The transaction failed.
                case .failed: do {
                    print("transaction failed \(transaction.debugDescription)")
                    SKPaymentQueue.default().finishTransaction(transaction)
                }
                // There're restored products.
                case .restored: do {
                    print("SUCCESS! transaction restored")
                    self.isRemoveAdsPurchased = true
                    plistManage.writePlist(namePlist: "data", key: "isPurchased", data: true as AnyObject)
                    SKPaymentQueue.default().finishTransaction(transaction)
                }
                @unknown default: print("transaction fatal error")
            }
        }
    }
  
    deinit {
        SKPaymentQueue.default().remove(self)
        print("StoreObserver has been de-initialized")
    }
}

