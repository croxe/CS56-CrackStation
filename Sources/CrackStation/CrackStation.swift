import Crypto
import Foundation

public class CrackStation: Decrypter {
    var passwords: [String : String] = [:]

    public required init() {
        do{
            // The file format is apple's plist, URL will take the filename from resources bundle
            let tempURL:URL? = Bundle.module.url(forResource: "hash", withExtension: "plist") 
            if let hURL = tempURL {
                print("hash.plist loaded")
                // Load hashed password from hash.plist
                let data = try Data(contentsOf: hURL )
                // Check the nil type after read file from disk, and ensure the data is not corrupted
                let tempPasswords = try PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as? [String:String]
                if(tempPasswords == nil) {throw "Data corrupted"}
                else {self.passwords = tempPasswords ?? [:]}
            }    
            else {
                throw "URL not found, Library corrupted"
            }
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