

来自：[AndyQ/NFCPassportReader](https://github.com/AndyQ/NFCPassportReader)



# NFCPassportReader

This package handles reading an NFC Enabled passport using iOS 13 CoreNFC APIS


Supported features:
* Basic Access Control (BAC)
* Secure Messaging
* Reads DG1 (MRZ data) and DG2 (Image) in both JPEG and JPEG2000 formats
* Passive Authentication (in Sample app only at the moment)

This is still very early days - the code is by no means perfect and there are still some rough edges  - there ARE most definitely bugs and I'm sure I'm not doing things perfectly. 

It reads and verifies my passport (and others I've been able to test) fine, however your mileage may vary.

## Usage 
To use, you first need to create the Passport MRZ Key which consists of the passport number, date of birth and expiry date (including the checksums).
Dates are in YYMMDD format

For example:

```
<passport number><passport number checksum><date of birth><date of birth checksum><expiry date><expiry date checksum>

e.g. for Passport nr 12345678, Date of birth 27-Jan-1998, Expiry 30-Aug-2025 the MRZ Key would be:

Passport number - 12345678
Passport number checksum - 8
Date Of birth - 980127
Date of birth checksum - 7
Expiry date - 250831
Expiry date checksum - 5

mrzKey = "12345678898012772508315"
```

Then on an instance of PassportReader, call the readPassport method passing in the mrzKey, the datagroups to read and a completion block.  
e.g.

```
passportReader.readPassport(mrzKey: mrzKey, tags: [.COM, .DG1, .DG2], completed: { (error) in
   ...
}
```

Currently the datagroups supported are: COM, DG1, DG2, SOD

This will then handle the reading of the passport, and image and will call the completion block either with an TagError error if there was an error of some kind, or nil if successful.

If successful, the passportReader object will then contain valid data for the passportMRZ and passportImage fields.

## Logging
Additional logging (very verbose)  can be enabled on the PassportReader by passing in a log level on creation:
e.g.

```
let reader = PassportReader(logLevel: .debug)
```

NOTE - currently this is just printing out to the console - I'd like to implement better logging later - probably using SwiftyBeaver 

## Sample app
There is a sample app included in the repo which demonstrates the functionality.

It now includes a sample of how to do Passive Authentication to ensure that an E-Passport is valid and hasn't been tampered with.

This however requires the use of the OpenSSL library (which is included as a Pod file from Marcin Krzyżanowski's OpenSSL-Universal Pod (https://github.com/krzyzanowskim/OpenSSL). 

I'd like to move this over to its own Swift Package BUT currently SPM doesn't support mixed languages so sadly I can't yet. Also, didn't want to get into the whole create a new CocoaPod thing yet so if anyone fancies doing something clever.....

It requires a set of CSCA certificates in PEM format from a master list (either from a country that publishes their master list, or the ICAO PKD repository). See the scripts folder for details on how to get and create this file.

**The masterList.pem file included in the Sample app is purely there to ensure no compiler warnings and contains only a single PEM file that was self-generated and won't be able to veryify anything!**

## Troubleshooting
* If when doing the initial Mutual Authenticate challenge, you get an error with and SW1 code 0x63, SW2 code 0x00, reason: No information given, then this is usualy because your MRZ key is incorrect, and possibly because your passport number is not quite right.  If your passport number in the MRZ contains a '<' then you need to include this in the MRZKey - the checksum should work out correct too.  For more details, check out App-D2 in the ICAO 9303 Part 11 document (https://www.icao.int/publications/Documents/9303_p11_cons_en.pdf)


## To do
There are a number of things I'd like to implement in no particular order:
 * Ability to dump passport stream and read it back in
 * Implement PACE authentication


## Thanks
I'd like to thank the writers of pypassport (Jean-Francois Houzard and Olivier Roger - can't find their website but referenced from https://github.com/andrew867/epassportviewer) who's work this is based on.

The EPassport section on YobiWiki (http://wiki.yobi.be/wiki/EPassport)  This has been an invaluable resource especially around Passive Authentication.

Marcin Krzyżanowski for his OpenSSL-Universal repo.
