import Crypto
import Foundation

public class CrackStation: Decrypter {
    var passwords: [String : String] = [:]

    public required init() {
        // The file format is apple's plist
        let fileName = "hash.plist"

        // URL will take the filename and add current directory
        let URL = URL(fileURLWithPath: fileName)
        
        // Try to read the file from current directory
        do{
            let data = try Data(contentsOf: URL)

            // Check the nil type after read file from disk, and ensure the data is not corrupted
            let tempPasswords = try PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as? [String:String]
            if(tempPasswords == nil) {throw "Data corrupted"}
            else {self.passwords = tempPasswords ?? [:]}
        }catch{
            // Print error if the file not founds
            print(error.localizedDescription)
        }
    }

    // look up the password dictionary and return the password
    public func decrypt(shaHash: String) -> String? {
        return passwords[shaHash.uppercased()]
    }
}

// add extension to be able to print in throw
extension String: Error {}