# cs561-CrackStation

This library is called CrackStation; it takes SHA1, SHA256 hash as input, and output the password that corresponded to the hash. By using this library, one can break simple hashed password from 1 to 3 digits length.

# Overview

The CrackStation can crack the password that in the combination of Upper case, Lower case letters, numbers, "!", and "?" up to three characters length. For example, "0O!" is crackable for CrackStation, and "0aeb" is not crackable, because there is four characters.

The input for CrakStation can be SH1 or SHA256 as input. For example, "86f7e437faa5a7fce15d1ddcb9eaeaea377667b8" is a valid input, and CrackStation will output the password, "a".

# Installation

Create a swift project in your filesystem folder, then put the following dependecy in the "package.swift".

### Dependency
Put the following code insidet the package.swift will enable the dependency

```
    dependencies: [
        // Dependencies declare other packages that this package depends on.
		.package(url: "git@github.com:croxe/CrackStation.git", from: "3.0.0")
    ],
```

# The API

This is an API description of this package.

### init()

This initializes the CrackStation as an instance.

### decypher(shaHash :String) -> password: String

When you calling api decypher from CrackStation, the decypher will return cracked password.


### An Example
import CrackStation
let password = crackstation.decrypt(shaHash: "86f7e437faa5a7fce15d1ddcb9eaeaea377667b8")


# History Version
### 1.0.1 (The PoC v1)

Create a prototype that be able to generate mapping between hash and password, I use dictionary to save those computed hash. 

Consider the possible of exntension, I made my generator takes input from one digit to infinite digit.

Meanwhile, I setup some tests for SHA1.

### 2.0.0 (The PoC v2)

Change the SHA1 to SHA256, and update all tests. Now decypher() only takes SHA256.

### 3.0.0 (MVP)

The CrackStation now will precomputed the hashes and then read hash dictionary into local disk directly, and each time when the CrackStation inits, it will check the local disk first.