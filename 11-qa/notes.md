# Q&A

## Notes 

### Learning about OS

- MIT's 6.828 Operating System Engineering class
- Good book - "Modern Operating Systems" by Andy Tanenbaum
- [Writing an OS in Rust](https://os.phil-opp.com/)

### What is the difference between `source script.sh` and `./script.sh`

Sourcing vs. executing a script in bash. Sourcing - runs it in the current bash shell session. Executing - runs it in a new isolated instance of bash. For example the current working directory of the shell session will persist after the script ends with sourcing.

### Browser Plugins

- Stylus - sideload custom CSS for any websites [userstyles.org](userstyles.org) has user submitted styles you can load with Stylus.

### Data-wrangling

`jq` and `pup` for parsing JSON and HTML respectively.

`pandas` Python library great for tabular data like CSVs, particularly plotting.

### 2FA

U2F solution like Yubikey better than SMS one-time passcodes for 2FA. The SMS approach is not secure if your smartphone was compromised.