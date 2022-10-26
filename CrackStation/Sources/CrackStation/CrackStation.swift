import Crypto
import Foundation

public class CrackStation: Decrypter {
    var myStationProtocol: [String : String] = [:]
    
    let ranges = [
        UInt32("a") ..< (UInt32("z") + 1),
        UInt32("A") ..< (UInt32("Z") + 1),
        UInt32("0") ..< (UInt32("9") + 1)//,
        //UInt32("!") ..< (UInt32("!") + 1),
        //UInt32("?") ..< (UInt32("?") + 1)
    ]
    
    public required init() {
        // Get dictionary in document directory
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let fileName = "hash.txt"

        let URL = URL(fileURLWithPath: fileName, relativeTo: documentsDirectory)
        print(URL)
        do{
            let data = try Data(contentsOf: URL)
            myStationProtocol = try PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as! [String:String] 
        }catch{
            print(error.localizedDescription)
        }
        
        print(myStationProtocol.count)
        if(myStationProtocol.count == 0) {
            recurGenDict(prefixs: "", digits: 4)
        }
        
        // Save computed hashes into file
        do{
            try FileManager.default.createDirectory(at: documentsDirectory, withIntermediateDirectories: true)
            try myStationProtocol.writeToURL(url: URL)
        }catch{
            print(error.localizedDescription)
        }
    }

    public func decrypt(shaHash: String) -> String? {
        return myStationProtocol[shaHash.uppercased()]
    }

    public func recurGenDict(prefixs: String, digits: Int) {
        if(digits == 0){ return }
        for range in ranges {
            for character in range {
                let temp:String = prefixs + String(UnicodeScalar(character)!)
                guard let data = temp.data(using: .utf8) else {return}
                //print(temp)
                //let digest = SHA256.hash(data: data)
                let digest = Insecure.SHA1.hash(data: data)
                myStationProtocol[digest.hexStr] = temp
                recurGenDict(prefixs: temp, digits: digits - 1)
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