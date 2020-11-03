//
//  AppStoreConnector.swift
//  TTrukPuzzle
//
//  Created by Yana  on 2020-11-01.
//  Copyright © 2020 Yana . All rights reserved.
//

import Foundation
import StoreKit
 
// main logic
open class AppStoreConnector: NSObject{
    
    let storeObserver: StoreObserver = StoreObserver()
    // Keep a strong reference to the product request.
    fileprivate var request: SKProductsRequest!
    
    public var products = [SKProduct]()
    // SKProductsRequestDelegate protocol method.
    
    fileprivate func logAvailableProducts(){
        for product in products {
            print("display: \(product.localizedDescription) : \(product.regularPrice)")
        }
    }
    
    public func isAuthorizedForPayments() -> Bool {
        return SKPaymentQueue.canMakePayments()
    }
    
    public func isRemoveAdsPurchased() -> Bool {
        return storeObserver.isRemoveAdsPurchased
    }
    
    public func restorePurchases(){
        return SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    public func purchaseAdRemoval() {
        if (isAuthorizedForPayments() && products.count > 0) {
            let payment = SKPayment(product: products[0])
            SKPaymentQueue.default().add(payment)
            print("purchase has been triggered")
        }else{
            print("client is not authorized for payments")
        }
    }
}

// to recieve product details
extension AppStoreConnector: SKProductsRequestDelegate{
    open func triggerDelegateToRecieveProducts(_ productIdentifiers: [String]) {
         print("triggerDelegateToRecieveProducts has started")
         let productIdentifiers = Set(productIdentifiers)
         request = SKProductsRequest(productIdentifiers: productIdentifiers)
         request.delegate = self
         request.start()
    }
    
    public func request(_ request: SKRequest, didFailWithError error: Error){
        print("has failed with an error in the response from App Store: \(error.localizedDescription)")
    }
    
    public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("productsRequest has started. Products property is to be assigned")
        if !response.products.isEmpty {
           products = response.products
           logAvailableProducts()
        }

        for invalidIdentifier in response.invalidProductIdentifiers {
            print("has failed with invalid identifiers: \(invalidIdentifier.description)")
        }
    }
    
    public func restorePurchase() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
}

extension SKProduct {
    /// - returns: The cost of the product formatted in the local currency.
    var regularPrice: String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = self.priceLocale
        return formatter.string(from: self.price)
    }
}
