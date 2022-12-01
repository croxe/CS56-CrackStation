import Crypto
import Foundation

public class Generator: Decrypter {
    var passwords: [String : String] = [:]

    let characterRanges = [
        UInt32("a") ..< (UInt32("z") + 1),
        UInt32("A") ..< (UInt32("Z") + 1),
        UInt32("0") ..< (UInt32("9") + 1),
        UInt32("!") ..< (UInt32("!") + 1),
        UInt32("?") ..< (UInt32("?") + 1)
    ]

    public required init() {
        // Get dictionary in document directory
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let fileName = "hash.json"
        // let fileName e= "hash.plist"

        // Create URL that relate to dictionary
        let URL = URL(fileURLWithPath: fileName, relativeTo: documentsDirectory)

        // Read file from disk
        do{
            let data = try Data(contentsOf: URL)
            passwords = try PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as! [String:String]
        }catch{
            print(error.localizedDescription)
        }

        // Generate hash if the file is not found in disk
        print(passwords.count)
        if(passwords.count == 0) {
            recurGenDict(prefixs: "", digits: 3)
        }

        // Save computed hashes into file
        do{
            try FileManager.default.createDirectory(at: documentsDirectory, withIntermediateDirectories: true)
            let encoder = JSONEncoder()
            if let jsonData = try? encoder.encode(passwords) {
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print(jsonString)
                }
                try jsonData.write(to: URL)
            }
            //try passwords.writeToURL(url: URL)
        }catch{
            print(error.localizedDescription)
        }
    }

    // find password in dictionary by sha hash
    public func decrypt(shaHash: String) -> String? {
        return passwords[shaHash.uppercased()]
    }

    // recursively generate the password
    public func recurGenDict(prefixs: String, digits: Int) {
        if(digits == 0){ return }
        for range in characterRanges {
            for character in range {
                let currentDigits:String = prefixs + String(UnicodeScalar(character)!)
                guard let data = currentDigits.data(using: .utf8) else {return}
                let hash_sha256 = SHA256.hash(data: data)
                let hash_sha1 = Insecure.SHA1.hash(data: data)
                passwords[hash_sha256.hexStr] = currentDigits
                passwords[hash_sha1.hexStr] = currentDigits
                recurGenDict(prefixs: currentDigits, digits: digits - 1)
            }
        }
    }
}

extension Dictionary where Key: Encodable, Value: Encodable {
    func writeToURL(url: URL) throws {
        // archive data
        let data = try PropertyListEncoder().encode(self)
        try data.write(to: url)
    }
}

extension Digest {
    var bytes: [UInt8] { Array(makeIterator()) }
    var data: Data { Data(bytes) }
    var hexStr: String {
        bytes.map { String(format: "%02X", $0) }.joined()
    }
}