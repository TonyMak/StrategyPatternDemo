import UIKit

class BankAccount {
    var transactions = [Transaction]()
    var sortType = 1
}

struct Transaction {
    let date: Date
    let vendor: String
    let amount: NSDecimalNumber
}

func sortByDate(transactions: inout [Transaction]) {
    transactions.sort(by: { $0.date < $1.date })
}

func sortByVendor(transactions: inout [Transaction]) {
    transactions.sort(by: { $0.vendor < $1.vendor })
}

func sortByAmount(transactions: inout [Transaction]) {
    transactions.sort(by: { $0.amount.decimalValue < $1.amount.decimalValue })
}

//Get dummy data for demo
let bankAccount = BankAccount()
var transaction = (0..<10).map{ Transaction(
    date: Date().addingTimeInterval(Double($0 * -Int.random(in: 1..<100))),
    vendor: "Vendor \(Int.random(in: 0..<100))",
    amount: NSDecimalNumber(integerLiteral: Int.random(in: 0..<100))
    ) }
bankAccount.transactions = transaction

//Sort data with specified sorting function called everytime, not dynamic & reusable
//May need to set different confusing condition
switch bankAccount.sortType {
case 1:
    sortByDate(transactions: &transaction)
case 2:
    sortByVendor(transactions: &transaction)
case 3:
    sortByAmount(transactions: &transaction)
default:
    break
}

print(transaction)
