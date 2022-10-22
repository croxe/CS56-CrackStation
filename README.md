# cs561-CrackStation

The PoC v1:

Create a prototype that be able to generate mapping between hash and password, I use dictionary to save those computed hash. 

Consider the possible of exntension, I made my generator takes input from one digit to infinite digit.

Meanwhile, I setup some tests for SHA1.

The PoC v2:

Change the SHA1 to SHA2, and update all tests.

The MVP:

The crackStation now will be able to save computed hash dictionary into local disk, and each time when the CrackStation inits, it will check the local disk first.
