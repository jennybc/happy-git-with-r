# Set up keys for SSH {#ssh-keys}

If you plan to push/pull using SSH, you need to set up SSH keys. You want to do this (or cache your username and password, chapter \@ref(credential-caching)), so you don't have to authenticate yourself interactively with GitHub over and over again. I suggest you set up one of these methods of authentication on each computer you want to connect to GitHub from.

## SSH keys

SSH keys provide a more secure way of logging into a server than using a password alone. While a password can eventually be cracked with a brute force attack, SSH keys are nearly impossible to decipher by brute force alone. Generating a key pair provides you with two long strings of characters: a public and a private key. You can place the public key on any server (like GitHub!), and then unlock it by connecting to it with a client that already has the private key (your computer!). When the two match up, the system unlocks without the need for a password. You can increase security even more by protecting the private key with a passphrase.

Adapted from instructions provided by [GitHub](https://help.github.com/categories/ssh/) and [Digital Ocean](https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys--2).

## SSH outline and advice

High level overview of what must happen:

  * Create a public-private SSH key pair. Literally, 2 special files, in a special place. Optionally, encrypt the private key with a passphrase (best practice).
  * Add the private key to your ssh-agent. If you protected it with a passphrase, you may have additional configuration.
  * Add your public key to your GitHub profile.

Advice:

  * If you are new to programming and the shell, you'll probably find HTTPS easier at first (chapter \@ref(credential-caching)). You can always switch to SSH later. You can use one method from computer A and the other from computer B.
  * You should swap out your SSH keys periodically. Something like once a year.
  * It's best practice to protect your private key with a passphrase. This can make setup and usage harder, so if you're not up for that (yet), either don't use a passphrase or seriously consider using HTTPS instead.
  * Don't do weird gymnastics in order to have only one key pair, re-used over multiple computers. You should probably have one key per computer (I do this). Some people even have one key per computer, per service (I do not do this).
  * It is normal to associate multiple public keys with your GitHub account. For example, one public key for each computer you connect with.

## Do you already have keys?

You can check this from RStudio or from the shell.

Global advice: if you do have existing keys, but have no clue where they came from or why you created them, you should seriously consider creating a new SSH key pair. It's up to you to figure out whether/how to delete the old ones. But don't let that keep you from creating new keys and moving forward.

### From RStudio

Go to *Tools > Global Options...> Git/SVN*. If you see something like `~/.ssh/id_rsa` in the SSH RSA Key box, you definitely have existing keys. Caveat: RStudio only looks for a key pair named `id_rsa` and `id_rsa.pub`. This makes sense, because it's the default and very common. But SSH keys *can* have other names. If you want to be completely certain, you should also check in the shell.

### From the shell

Go to the shell (appendix \@ref(shell)).

List existing keys:

``` bash
ls -al ~/.ssh/
```

If you are told `~/.ssh/` doesn't exist, you don't have SSH keys!

If you see a pair of files like `id_rsa.pub` and `id_rsa`, you have a key pair already. The typical pattern is `id_FOO.pub` (the public key) and `id_FOO` (the private key). If you're happy to stick with your existing keys, skip to the sections about adding a key to the ssh-agent and GitHub.

## Create an SSH key pair

### Option 1: Set up from RStudio

Go to *Tools > Global Options...> Git/SVN > Create RSA Key...*.

RStudio prompts you for a passphrase. It is optional, but also a best practice. Configuring your system for smooth operation with a passphrase-protected key introduces more moving parts. If you're completely new at all this, skip the passphrase (or use HTTPS!) and implement it next time, when you are more comfortable with system configuration. I did not use a passphrase at first, but I do now, and record it in a password manager.

Click "Create" and RStudio will generate an SSH key pair, stored in the files `~/.ssh/id_rsa` and `~/.ssh/id_rsa.pub`.

### Option 2: Set up from the shell

Create the key pair like so, but substitute a comment that means something to you, especially if you'll have multiple SSH keys in your life. Consider the email associated with your GitHub account or the name of your computer, e.g. `you@example.com` or `2018-mbp`.

``` bash
$ ssh-keygen -t rsa -b 4096 -C "USEFUL-COMMENT"
```

Accept the proposal to save the key in the default location. Just press Enter here:

``` bash
Enter file in which to save the key (/Users/jenny/.ssh/id_rsa):
```

You have the option to protect the key with a passphrase. It is optional, but also a best practice. Configuring your system for smooth operation with a passphrase-protected key introduces more moving parts. If you're completely new at all this, skip the passphrase and implement it next time, when you are more comfortable with system configuration. I did not use a passphrase at first, but I do now, and record it in a password manager.

``` bash
Enter passphrase (empty for no passphrase):
```

The process should complete now and should have looked like this:

``` bash
jenny@2015-mbp ~ $ ssh-keygen -t rsa -b 4096 -C "USEFUL-COMMENT"
Generating public/private rsa key pair.
Enter file in which to save the key (/Users/jenny/.ssh/id_rsa):     
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /Users/jenny/.ssh/id_rsa.
Your public key has been saved in /Users/jenny/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:ki0TNHm8qIvpH7/c0qQmdv2xxhYHCwlpn3+rVhKVeDo USEFUL-COMMENT
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

Things get a little OS-specific around here. When in doubt, consult [GitHub's instructions for SSH](https://help.github.com/articles/connecting-to-github-with-ssh/), which is kept current for Mac, Windows, and Linux.

#### Mac OS

Make sure ssh-agent is enabled:

``` bash
jenny@2015-mbp ~ $ eval "$(ssh-agent -s)"
Agent pid 95727
```

Add your key. If you set a passphrase, you'll be challenged for it here. Give it. The `-K` option stores your passphrase in the keychain.

``` bash
jenny@2015-mbp ~ $ ssh-add -K ~/.ssh/id_rsa
Enter passphrase for /Users/jenny/.ssh/id_rsa: 
Identity added: /Users/jenny/.ssh/id_rsa (/Users/jenny/.ssh/id_rsa)
```

If you're using a passphrase AND on macOS Sierra 10.12.2 and higher, you need to do one more thing. Create a file `~/.ssh/config` with these contents:

``` bash
Host *
 AddKeysToAgent yes
 UseKeychain yes
```

This should store your passphrase *persistently* in the keychain. Otherwise, you will have to enter it every time you log in. Useful StackOverflow thread: [How can I permanently add my SSH private key to Keychain so it is automatically available to ssh?](https://apple.stackexchange.com/questions/48502/how-can-i-permanently-add-my-ssh-private-key-to-keychain-so-it-is-automatically).

#### Windows

In a Git Bash shell, make sure ssh-agent is running:

``` bash
$ eval $(ssh-agent -s)
Agent pid 59566
```

Add your key.

``` bash
$ ssh-add ~/.ssh/id_rsa
```

#### Linux

In a shell, make sure ssh-agent is running:

``` bash
$ eval "$(ssh-agent -s)"
Agent pid 59566
```

Add your key.

``` bash
ssh-add ~/.ssh/id_rsa
```

## Provide public key to GitHub

Now we store a copy of your public key on GitHub.

### RStudio to clipboard

Go to *Tools > Global Options...> Git/SVN*. If your key pair has the usual name, `id_rsa.pub` and `id_rsa`, RStudio will see it and offer to "View public key". Do that and accept the offer to copy to your clipboard. If your key pair is named differently, use another method.

### Shell to clipboard

Copy the public key onto your clipboard. For example, open `~/.ssh/id_rsa.pub` in an editor and copy the contents to your clipboard. Or do one of the following at the command line:

  * Mac OS: `pbcopy < ~/.ssh/id_rsa.pub`
  * Windows: `clip < ~/.ssh/id_rsa.pub`
  * Linux: `xclip -sel clip < ~/.ssh/id_rsa.pub`

*Linux: if needed, install via `apt-get` or `yum`. For example, `sudo apt-get install xclip`.*

### On GitHub

Make sure you're signed into GitHub. Click on your profile pic in upper right corner and go *Settings*, then *SSH and GPG keys*. Click "New SSH key". Paste your public key in the "Key" box. Give it an informative title, presumably related to the comment you used abov, during key creation. For example, you might use `2018-mbp` to record the year and computer. Click "Add SSH key".

In theory, we're done! You can use [`ssh -T git@github.com`](https://help.github.com/articles/testing-your-ssh-connection/) to test your connection to GitHub. If you're not sure what to make of the output, see the link for details. Of course, the best test is to work through the realistic usage examples elsewhere in this guide.

## Troubleshooting

### HTTPS vs SSH

If you think you have SSH set up correctly and yet you are still challenged for credentials, consider this: for the repo in question, have you possibly set up GitHub, probably called `origin`, as an HTTPS remote, instead of SSH?

How to see the remote URL(s) associated with the current repo in the shell:

``` bash
git remote -v
```

An SSH remote will look like this:

```
git@github.com:USERNAME/REPOSITORY.git
```

whereas an HTTPS remote will look like this:

```
https://github.com/USERNAME/REPOSITORY.git
```

You can toggle between these with `git remote set-url`:

  * <https://help.github.com/articles/changing-a-remote-s-url/>

### git2r -- or some other tool -- can't find SSH keys on Windows

Have you seen this error message?

```
Error in .local(object, ...) : 
  Error in 'git2r_push': error authenticating: failed connecting agent
```

We've seen it when working with Git/GitHub from R via the [git2r](https://cran.r-project.org/web/packages/git2r/index.html) package, which is used under the hood by many R packages, such as devtools, ghit, and usethis.

git2r uses the libgit2 library, not the Git you installed. This means you can have SSH keys configured properly for Git work in a Git Bash shell and from RStudio and still have problems with git2r! Ugh.

The root cause is confusion about the location of `.ssh/` on Windows. R's idea of your home directory on Windows often differs from the default location of config files for Git and ssh, such as `.ssh/`. On *nix systems, these generally coincide and there's no problem.

Two important directories on Windows are the user's HOME and USERPROFILE. R usually associates `~` with HOME, but Git and ssh often consult USERPROFILE for their config files. On my Windows 10 VM, I see:

``` r
normalizePath("~")
#> [1] "C:\\Users\\JennyVM\\Documents"

as.list(Sys.getenv(
  c("HOME", "USERPROFILE")
))
#> $HOME
#> [1] "C:/Users/JennyVM/Documents"
#> 
#> $USERPROFILE
#> [1] "C:\\Users\\JennyVM"

list.files(
  Sys.getenv("USERPROFILE"),
  pattern = "ssh|git",
  include.dirs = TRUE,
  all.files = TRUE
)
#> [1] ".gitconfig" ".ssh"
```

Two workarounds:

  * Tell git2r explicitly where to find your public and private key. Example using `usethis::use_github()`:
  
    ``` r
    cred <- git2r::cred_ssh_key(
      publickey = "~/../.ssh/id_rsa.pub",
      privatekey = "~/../.ssh/id_rsa"
    )
    use_github(credentials = cred)
    ```
  * [Create a symbolic link](https://www.howtogeek.com/howto/16226/complete-guide-to-symbolic-links-symlinks-on-windows-or-linux/) so that `.ssh/` in R's home directory points to your actual `.ssh/` directory. Example contributed by Ian Lyttle on Windows 7 using Command Prompt:
  
    ``` bash   
    MKLINK /D "C:\Users\username\Documents\.ssh" "C:\Users\username\.ssh"
    ```
    
Finally, if git2r seems unable to get your SSH passphrase from ssh-agent, install the getPass package:

``` r
install.packages("getPass")
```

and git2r should launch a popup where you can enter your passphrase. Thanks to Ian Lyttle for this tip.

This link provides a great explanation of the uncertainty about where `.ssh/` and user's `.gitconfig` are located on Windows: [git on Windows - location of configuration files](https://www.onwebsecurity.com/configuration/git-on-windows-location-of-global-configuration-file.html). Bottom line: locate where your main tool expects and create symbolic links to help other tools find this stuff.

### Other

Other things to double-check:

  * Did you add the SSH to your ssh-agent?
  * Did you configure Mac OS Sierra or High Sierra to persistently store your passphrase in the keychain?
  * Did you add the public key to GitHub?
