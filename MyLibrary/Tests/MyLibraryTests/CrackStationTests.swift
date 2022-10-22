import XCTest
import MyLibrary

final class CrackStationTests: XCTestCase {
    func testCrackStationPassword() {
        // Given
        let crackstation = CrackStation()

        // When
        let passwordList = [
            "aa",
            "aaa",
            "0",
            "!?",
            "A?0"
        ]

        let hashList = [
            "961b6dd3ede3cb8ecbaacbd68de040cd78eb2ed5889130cceb4c49268ea4d506",
            "9834876dcfb05cb167a5c24953eba58c4ac89b1adf57f28f2f9d09af107ee8f0",
            "5feceb66ffc86f38d952786c6d696c79c2dbc239dd4e91b46729d73a27fb57e9",
            "8faf838e27d8b53956614af56e7a87d24d0bc8b650eeea9864009dcad461c6d4",
            "a0cda20ded3ea2ae4dc8fa865512c7a44f0840500a6cb8850ab14f9c4b1f98f6",
        ]

        //Then
        for i in 0...4 {
            let tempPassword = crackstation.crack(hash: hashList[i])
            XCTAssert(passwordList[i] == tempPassword)
        }
    }

}
