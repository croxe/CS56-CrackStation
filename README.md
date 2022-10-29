# cs561-CrackStation

This library is called CrackStation; it takes SHA1, SHA256 hash as input, and output the password that corresponded to the hash. By using this library, one can break simple hashed password from 1 to 3 digits length.

### 1.0.1 (The PoC v1):

Create a prototype that be able to generate mapping between hash and password, I use dictionary to save those computed hash. 

Consider the possible of exntension, I made my generator takes input from one digit to infinite digit.

Meanwhile, I setup some tests for SHA1.

### 2.0.0 (The PoC v2):

Change the SHA1 to SHA256, and update all tests. Now decypher() only takes SHA256.

### The MVP:

The CrackStation now will be able to save computed hash dictionary into local disk, and each time when the CrackStation inits, it will check the local disk first.


# The API

This is an API description of this package.

### init()

This initializes the CrackStation as an instance.

### decypher(shaHash :String) -> password: String

When you calling api decypher from CrackStation, the decypher will return cracked password.

### recurGenDict(prefix: String, digits: Int)

Using permutation recursively generate random password that according to the "digits" parameter. The limit parameter will tell the function how many digits would have to be calculated up to. The prefix is a String can be inserted in front of generated password. For instance, if one know the password starts from "paste"; it would be best to try related password that append to this prefix.

### .caches Directory

One could put his or her dictionary that in .plist format under \.caches. By doing this, one can use their customized dictionary to decypher one password. 