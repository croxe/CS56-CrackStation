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
        print(myStationProtocol.count)
        if(myStationProtocol.count == 0) {
            recurGenDict(preLetters: "", limit: 3)
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
                let digest = Insecure.SHA1.hash(data: data)
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