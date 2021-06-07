---
layout:     post
title:      "Shooting myself in the foot - part 1"
date:       2021-06-07 16:10:05 +0200
categories: admin
tags:       yubikey ssh putty
published:  true
---
I got me a [Yubikey][1]. One of those neat security tokens to make our live as 
admins more secure and easier. And I really like it. The hardware looks sturdy
and it is the first USB stick like thing I trust to survive on a keyring any
amount of time. 
<!--more-->

One of my main probles I wanted to solve was the secure handling of ssh keys for
my servers. I am using multiple devices to access them, and it is not easy to
have the same key on all devices at all times. Neither is it feasable to use
different keys from every device, because then the `authorized_keys` file on the
server simply explodes. So I went ahead and followd [this guide.][2] (Sidenote:
I am still not sure, why the guide creates a special signature key, if that
cannot be transfered to the yubikey because of the limitation to 3 keys, but...)
Everything went fine, until I got to the point where I wanted to push the key
over to the hardware. `gpg` did not  want to speak with the yubikey. Even though
I double checked everything, version, command line, everything - it did not
work. 

After a while i noticed slight differences in the output of gpg depending on
wether or not I called it with the absolute path. One google search later I
learned about the handy command `where` in the windows commandline. For those
who don't know it: it is like the `which -a` command in linux. It shows you all
places where a binary to the command happens to be:

```
H:\>where gpg
C:\Program Files\Git\usr\bin\gpg.exe
C:\Program Files (x86)\GnuPG\bin\gpg.exe
```

And there you have it. The default `gpg` was installed with git on my host. And
it happens to not have smart card capabilities. At least not the correct ones
to be used with the yubikey. A small shift in the windows %PATH% variable solved
this problem and averything was fine. (FYI: This is not the *shooting in the
foot* part.)

I set everything up, got my ssh public key as well (`gpg --export-ssh-key
<keyid>` is surprisingly hard to goolge...) and set it up with one of my server.
Usual procedure when playing around with ssh login options: 
* Create a backup user.
* Set everything up for the backup user.
* Make sure, the backup user may `sudo` as well, in case things go south.

I worked great, testing with `plink` on the command line, no problem. GUI comes
up and asks for PIN-entry after reinsertion of the key, remembers the PIN for
some time, if the key stays in the port. Nice!

Let's continue with putty itself. "Server refused our key". What?!?

Insert about 1h of searching through sshd logs, unplugging the key, replugging
the key, double checking the authorized_keys file (Why? It *still* works with
plink!) to absolutly no avail. Until I finally get the idea of looking at the
debug log of putty (After filtering all the raw package contents):

```
Event Log: Reading key file "C:\Users\userid\Documents\key.ppk"
Event Log: Pageant is running. Requesting keys.
Event Log: Pageant has 1 SSH-2 keys
Event Log: Configured key file not in Pageant
Event Log: Offered public key
Event Log: Server refused our key
```

"Configured key file not in Pageant". A look at the session configuration
confirmed my suspicion: The key was specified in the session. And apparently
Putty ignores all other keys, when told to use a specific one (which is
understandable)

The real "Shooting yourself in the foot" part is: **I had the EXACT SAME PROBLEM**
a day before that. On a different machine. With the same key.

Written down, so *hopefully* I will not have the same problem again. Ever.

[1]: https://www.yubico.com/de/product/yubikey-5-nfc/
[2]: https://developers.yubico.com/PGP/SSH_authentication/Windows.html