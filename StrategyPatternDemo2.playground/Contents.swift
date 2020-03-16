import UIKit

class BankAccount {
    var transactions = [Transaction]()
    //New attribute for sort type
    var sortBehaviour: SortBehaviour = DateSorting() {
        didSet {
            self.sortTransactions()
        }
    }
    
    //Action to sort
    func sortTransactions() {
        self.sortBehaviour.sort(transactions: &self.transactions)
    }
}

struct Transaction {
    let date: Date
    let vendor: String
    let amount: NSDecimalNumber
}

//New attribute for BankAccount binding to sort related function
protocol SortBehaviour {
    func sort(transactions: inout [Transaction])
}

//Package sorting function to different classes
class DateSorting: SortBehaviour {
    func sort(transactions: inout [Transaction]) {
        transactions.sort(by: { $0.date < $1.date })
    }
}

class VendorSorting: SortBehaviour {
    func sort(transactions: inout [Transaction]) {
        transactions.sort(by: { $0.vendor < $1.vendor })
    }
}

class AmountSorting: SortBehaviour {
    func sort(transactions: inout [Transaction]) {
        transactions.sort(by: { $0.amount.decimalValue < $1.amount.decimalValue })
    }
}

//Get dummy data for demo
let bankAccount = BankAccount()
var transaction = (0..<10).map{ Transaction(
    date: Date().addingTimeInterval(Double($0 * -Int.random(in: 1..<100))),
    vendor: "Vendor \(Int.random(in: 0..<100))",
    amount: NSDecimalNumber(integerLiteral: Int.random(in: 0..<100))
    ) }
bankAccount.transactions = transaction

//Sort data depends on transaction sorting type
bankAccount.sortBehaviour = DateSorting()
bankAccount.sortBehaviour = VendorSorting()
//Another method to init attr, more clear for further value init.
let amountSorting = AmountSorting()
bankAccount.sortBehaviour = amountSorting

print(transaction)
