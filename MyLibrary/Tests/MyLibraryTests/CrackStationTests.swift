import XCTest
import MyLibrary

final class CrackStationTests: XCTestCase {
    func testCrackStationPasswordOneDigit() {
        // Given
        let crackstation = CrackStation()

        // When
        let password = crackstation.crack(hash: "86f7e437faa5a7fce15d1ddcb9eaeaea377667b8")
        print(password)
        // Then
        XCTAssert(password == "a")
        let password2 = crackstation.crack(hash: "8ee51caaa2c2f4ee2e5b4b7ef5a89db7df1068d7")
        print(password2)
        // Then
        XCTAssert(password2 == "92")
    }

    // func testCrackStationPasswordTwoDigits() {
    //     // Given
    //     let crackstation = CrackStation()

    //     // When
    //     let password = crackstation.crack(hash: "8ee51caaa2c2f4ee2e5b4b7ef5a89db7df1068d7")

    //     // Then
    //     XCTAssert(password == "92")
    // }

    // func testCrackStationPasswordTwoDigits() {
    //     // Given
    //     let crackstation = CrackStation()

    //     // When
    //     let password = crackstation.crack(hash: "801c34269f74ed383fc97de33604b8a905adb635")

    //     // Then
    //     XCTAssert(password == "AA")
    // }

    // func testCrackStationPasswordThreeDigits1() {
    //     // Given
    //     let crackstation = CrackStation()

    //     // When
    //     let password = crackstation.crack(hash: "4e3b829410608130547609a3e6ba89513d8013d5")

    //     // Then
    //     XCTAssert(password == "eta")
    // }

    // func testCrackStationPasswordThreeDigits2() {
    //     // Given
    //     let crackstation = CrackStation()

    //     // When
    //     let password = crackstation.crack(hash: "893a066695ecc655794a2d3f7b03f11a969fede3")

    //     // Then
    //     XCTAssert(password == "0i1")
    // }

    // func testCrackStationPasswordThreeDigits3() {
    //     // Given
    //     let crackstation = CrackStation()

    //     // When
    //     let password = crackstation.crack(hash: "59785da3dbfcccd392e34208e69f58a89ef198d2")

    //     // Then
    //     XCTAssert(password == "U1D")
    // }

    // func testCrackStationPasswordThreeDigits4() {
    //     // Given
    //     let crackstation = CrackStation()

    //     // When
    //     let password = crackstation.crack(hash: "7560bcbf2a7b023a0643a9252f8c76353972e8c1")

    //     // Then
    //     XCTAssert(password == "49p")
    // }

}
