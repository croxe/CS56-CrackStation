import Crypto
import Foundation

public class CrackStation {
    var myStationProtocol: [String : String] = [:]
    
    let ranges = [
        UInt32("a") ..< (UInt32("z") + 1),
        UInt32("A") ..< (UInt32("Z") + 1),
        UInt32("0") ..< (UInt32("9") + 1),
        UInt32("!") ..< (UInt32("!") + 1),
        UInt32("?") ..< (UInt32("?") + 1)
    ]
    
    public init() {
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
            recurGenDict(preLetters: "", limit: 3)
        }
        
        // Save computed hashes into file
        do{
            try FileManager.default.createDirectory(at: documentsDirectory, withIntermediateDirectories: true)
            try myStationProtocol.writeToURL(url: URL)
        }catch{
            print(error.localizedDescription)
        }
    }

    public func crack(hash: String) -> String? {
        return myStationProtocol[hash.uppercased()]
    }

    public func recurGenDict(preLetters: String, limit: Int) {
        if(limit == 0){ return }
        for range in ranges {
            for character in range {
                let temp:String = preLetters + String(UnicodeScalar(character)!)
                guard let data = temp.data(using: .utf8) else {return}
                //print(temp)
                let digest = SHA256.hash(data: data)
                myStationProtocol[digest.hexStr] = temp
                recurGenDict(preLetters: temp, limit: limit - 1)
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