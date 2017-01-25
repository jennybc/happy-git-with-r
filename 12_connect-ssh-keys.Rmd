# Set up keys for SSH {#ssh-keys}

If you plan to push/pull using SSH, you need to set up SSH keys. You want to do this (or cache your username and password, chapter \@ref(credential-caching)), so you don't have to authenticate yourself interactively with GitHub over and over again. You'll need to set this up on each computer you want to connect to GitHub from.

## SSH keys

SSH keys provide a more secure way of logging into a server than using a password alone. While a password can eventually be cracked with a brute force attack, SSH keys are nearly impossible to decipher by brute force alone. Generating a key pair provides you with two long strings of characters: a public and a private key. You can place the public key on any server, and then unlock it by connecting to it with a client that already has the private key. When the two match up, the system unlocks without the need for a password. You can increase security even more by protecting the private key with a passphrase.

Adapted from instructions provided by [GitHub](https://help.github.com/categories/ssh/) and [Digital Ocean](https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys--2).

## Check for existing keys

Go to the shell (appendix \@ref(shell)).

List existing keys (at least, those in the default location):

``` bash
ls -al ~/.ssh 
```

If you are told `.ssh` doesn't exist, you don't have SSH keys! Keep reading to create them.

If you see a pair of files like `id_rsa.pub` and `id_rsa`, you have a key pair already. You can skip to the section about adding a key to the ssh-agent.

## Set up from RStudio

Instructions for setting up SSH keys from RStudio are given in the Git and GitHub chapter of Wickham's [R packages book](http://r-pkgs.had.co.nz/). Look at the end of the section on initial set up:

  * <http://r-pkgs.had.co.nz/git.html#git-init>

## Set up from the shell

### Create SSH key pair

Create the key pair by entering this, but substitute the email address **associated with your GitHub account**:

``` bash
$ ssh-keygen -t rsa -b 4096 -C "jenny@stat.ubc.ca"
```

Accept the proposal to save the key in the default location, i.e., just press Enter here:

``` bash
Enter file in which to save the key (/Users/jenny/.ssh/id_rsa):
```

You have the option to protect the key with a passphrase. If you take it, you will want to configure something called the ssh-agent to manage this for you (more below).

So either enter a passphrase (and store in your favorite password manager!) or decline by leaving this empty.

``` bash
Enter passphrase (empty for no passphrase):
```

The process should complete now and should have looked like this:

``` bash
jenny@2015-mbp ~ $ ssh-keygen -t rsa -b 4096 -C "jenny@stat.ubc.ca"
Generating public/private rsa key pair.
Enter file in which to save the key (/Users/jenny/.ssh/id_rsa):     
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /Users/jenny/.ssh/id_rsa.
Your public key has been saved in /Users/jenny/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:ki0TNHm8qIvpH7/c0qQmdv2xxhYHCwlpn3+rVhKVeDo jenny@stat.ubc.ca
The key's randomart image is:
+---[RSA 4096]----+
|      o+   . .   |
|     .=.o . +    |
|     ..= + +     |
|      .+* E      |
|     .= So =     |
|    .  +. = +    |
|   o.. = ..* .   |
|  o ++=.o =o.    |
| ..o.++o.=+.     |
+----[SHA256]-----+
```

### Add key to ssh-agent

Tell your ssh-agent about the key and, especially, set it up to manage the passphrase, if you chose to set one.

Make sure ssh-agent is enabled:

``` bash
jenny@2015-mbp ~ $ eval "$(ssh-agent -s)"
Agent pid 95727
```

Add your key. If you set a passphrase, you'll be challenged for it here. Give it.

``` bash
jenny@2015-mbp ~ $ ssh-add ~/.ssh/id_rsa
Enter passphrase for /Users/jenny/.ssh/id_rsa: 
Identity added: /Users/jenny/.ssh/id_rsa (/Users/jenny/.ssh/id_rsa)
```

### Provide public key to GitHub

Copy the public key onto your clipboard. Open `~/.ssh/id_rsa.pub` in an editor and copy the contents to your clipboard or do one of the following at the command line:

  * Mac OS: `pbcopy < ~/.ssh/id_rsa.pub`
  * Windows: `clip < ~/.ssh/id_rsa.pub`
  * Linux: `xclip -sel clip < ~/.ssh/id_rsa.pub`

*Linux: if needed, install via `apt-get` or `yum`. For example, `sudo apt-get install xclip`.*

In the top right corner of any page on [GitHub](GitHub.com), click your profile photo, then click Settings.

In the user settings sidebar, click SSH and GPG keys.

Click New SSH key.

In the "Title" field, add a descriptive label for the new key. For example, if you're using a personal Mac, you might call this key "Personal MacBook Air".

Paste your key into the "Key" field.

Click Add SSH key.

Confirm the action by entering your GitHub password.
