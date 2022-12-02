# CrackStation, a Decrypter implementation

A Decrypter, decipher SHA1 and SHA256 hashes.  

### Overview

This library is called CrackStation; it takes SHA1, SHA256 hash as input, and output the password that corresponded to the hash. The size of library is very small and can be easily installed. 

Moreover, the CrackStation can crack the password that in the combination of Upper case, Lower case letters, numbers, "!", and "?" up to three characters length. For example, "0O!" is crackable for CrackStation, and "0aeb" is not crackable, because there is four characters. There is some constrain on what the CrackStation can do. By using this library, one can break simple hashed password from 1 to 3 digits length. The input for CrakStation can be SH1 or SHA256 as input. For example, "86f7e437faa5a7fce15d1ddcb9eaeaea377667b8" is a valid input, and CrackStation will output the password, "a".

### Mission Statement

The purpose is to help people who forget their password to recover the password. This library can decipher salted password that has "!" or "?" being inserted in the password. From Wikipedia Salt page: "In cryptography, a salt is random data that is used as an additional input to a one-way function that hashes data, a password or passphrase." This provides additional benefits to users. 


# Installation

### Swift Package Manager
The Swift Package Manager is "a tool for managing the distribution of Swift code. It's integrated with the Swift build system to automate the process of downloading, compiling, and liking dependencies."

Once you have the Swift package set up, put the following code inside the $$package.swift$$ will enable the dependency

```
    dependencies: [
        // Dependencies declare other packages that this package depends on.
		.package(url: "git@github.com:croxe/CrackStation.git", from: "3.0.0")
    ],
```

# Usage

### The API

This is an API description of this package.

### init()

This initializes the CrackStation as an instance.

### decypher(shaHash :String) -> password: String

When you calling api decypher from CrackStation, the decypher will return cracked password.

The input: shaHash can be SH1 or SHA256. 
The output: the password, but decypher can only decode password string inside range of the regular expression [A-Za-z0-9?!]{1,3}, so if the password is not found it will return nil.

### An Example
```
import CrackStation

public class myClass {
	let crackstation = CrackStation()
	let password = crackstation.decrypt(shaHash: "86f7e437faa5a7fce15d1ddcb9eaeaea377667b8")
	print(password) //Outputs password: "a"
}
```

### Author

The author is Song Gao.



# History Version
### 1.0.1 (The PoC v1)

Create a prototype that be able to generate mapping between hash and password, I use dictionary to save those computed hash. 

Consider the possible of exntension, I made my generator takes input from one digit to infinite digit.

Meanwhile, I setup some tests for SHA1.

### 2.0.0 (The PoC v2)

Change the SHA1 to SHA256, and update all tests. Now decypher() only takes SHA256.

### 3.0.0 (MVP)

The CrackStation now will precomputed the hashes and then read hash dictionary into local disk directly, and each time when the CrackStation inits, it will check the local disk first.

### 4.0.1 (Decrypter as Server)

Now a web version of CrackStation is available. Please refer the Decrypter.yaml for more information.