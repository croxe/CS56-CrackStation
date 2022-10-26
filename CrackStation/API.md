# CrackStation

This is an API description of this package.

### init()

This initializes the CrackStation as an instance.

### decypher(hash :String) -> password: String

When you calling api decypher from CrackStation, the decypher will return cracked password.

### recurGenDict(prefix: String, digits: Int)

Using permutation recursively generate random password that according to the "digits" parameter. The limit parameter will tell the function how many digits would have to be calculated up to. The prefix is a String can be inserted in front of generated password. For instance, if one know the password starts from "paste"; it would be best to try related password that append to this prefix.

### .caches Directory

One could put his or her dictionary that in .plist format under \.caches. By doing this, one can use their customized dictionary to decypher one password. 