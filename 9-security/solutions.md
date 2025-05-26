# Security and Cryptography

## Solutions 

### 1. Entropy

#### Exercise 1.1

Selecting four words at random from a dictionary of 100,000 words, there will be $100,000^4 = 10^{20}$ possible combinations.

$\log_2{10^{20}} \approx 66.44$ bits of entropy

#### Exercise 1.2

Number of alphanumeric characters:

$
26 + 26 + 10 = 62
$

Number of combinations of 8 random alphanumeric characters is $62^8$

$\log_2{62^8} \approx 47.63$ bits of entropy

#### Exercise 1.3

The four randomly chose words is a stronger password because it has more possible combinations/more bits of entropy.

#### Exercise 1.4

Time taken to guess the random words password:

$
\dfrac{10^{20}}{10000}=10^{16}\text{ seconds}\approx317\text{ million years}
$

Time taken to guess the random alphanumeric characters password:

$
\dfrac{62^8}{10000}\approx2.18 \cdot 10^{10}\text{ seconds}\approx692\text{ years}
$

### 2. Cryptographic hash functions

#### Exercise 2.1

Downloaded from https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/

```
$ sha256sum debian-12.11.0-amd64-netinst.iso 
30ca12a15cae6a1033e03ad59eb7f66a6d5a258dcf27acd115c2bd42d22640e8  debian-12.11.0-amd64-netinst.iso
```

Which matches https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/SHA256SUMS

```
30ca12a15cae6a1033e03ad59eb7f66a6d5a258dcf27acd115c2bd42d22640e8  debian-12.11.0-amd64-netinst.iso
c9e91acea848d9ac0156e186eb5afbbe76c911ac492d5650d22f678c005d30e7  debian-edu-12.11.0-amd64-netinst.iso
d436c62a059cfeb309d2c4cade969067507ee7cb21f021963d4ed88efb3767d9  debian-mac-12.11.0-amd64-netinst.iso
```

Downloaded from https://debian.grena.ge/debian-cd/current/amd64/iso-cd/

```
$ sha256sum 'debian-12.11.0-amd64-netinst (1).iso' 
30ca12a15cae6a1033e03ad59eb7f66a6d5a258dcf27acd115c2bd42d22640e8  debian-12.11.0-amd64-netinst (1).iso
```

Which matches https://debian.grena.ge/debian-cd/current/amd64/iso-cd/SHA256SUMS

```
30ca12a15cae6a1033e03ad59eb7f66a6d5a258dcf27acd115c2bd42d22640e8  debian-12.11.0-amd64-netinst.iso
c9e91acea848d9ac0156e186eb5afbbe76c911ac492d5650d22f678c005d30e7  debian-edu-12.11.0-amd64-netinst.iso
d436c62a059cfeb309d2c4cade969067507ee7cb21f021963d4ed88efb3767d9  debian-mac-12.11.0-amd64-netinst.iso
```

### 3. Symmetric cryptography

#### Exercise 3.1

``` 
$ echo "The quick brown fox jumps over the lazy dog" > quickbrownfox

$ openssl aes-256-cbc -salt -in quickbrownfox -out encryptedbrownfox
enter AES-256-CBC encryption password:
Verifying - enter AES-256-CBC encryption password:
*** WARNING : deprecated key derivation used.
Using -iter or -pbkdf2 would be better.

$ cat encryptedbrownfox 
�H�'7�U����qcH��@���=�S
�Bpa�t���Q��9N���f֡�

$ openssl aes-256-cbc -d -in encryptedbrownfox -out quickbrownfox2
enter AES-256-CBC decryption password:
*** WARNING : deprecated key derivation used.
Using -iter or -pbkdf2 would be better.

$ cat quickbrownfox2
The quick brown fox jumps over the lazy dog

$ cmp quickbrownfox quickbrownfox2
```

### 4. Asymmetric cryptography

#### Exercise 4.1

```
$ ssh-keygen -t ed25519
```

#### Exercise 4.2

```
$ gpg --gen-key
```

#### Exercise 4.3

I'm not going to do it for real but this is the procedure:

```
$ curl https://keybase.io/username/pgp_keys.asc | gpg --import

$ echo "Your secret message" | gpg -ea -r "Recipient Name" | mail -s "Subject" recipient@example.com
```

#### Exercise 4.4

```
$ git config --global user.signingkey XXXXXXXXXXXXXXXXXXXXXXXXXX

$ git commit -S
[master (root-commit) bd05f0e] Some commit
 1 file changed, 1 insertion(+)
 create mode 100644 somefile.txt

$ git show --show-signature
commit bd05f0e6a4f4d5ffd43ae251d0948747bf33979d (HEAD -> master)
gpg: Signature made Mon 26 May 2025 20:16:28 BST
gpg:                using EDDSA key XXXXXXXXXXXXXXXXXXXXXXXXXX
gpg: Good signature from "Xxxxx Xxxxx <xxx@xxxxxxx.com>" [ultimate]
...
```