# System Files

List of files used by both Linux and Mac systems

## .bash_profile

User specific session environment and startup programs

```
$> cp .bash_profile ~/
```

## .gitconfig

Global git config rules

## clean_memory.sh

Handy utility that will clear Linux caches

```
$> chmod +x clean_memory.sh
$> sudo clean_memory.sh
```

Copy to remote host:

```
$> scp clean_memory.sh user@host:~/
```

## git-completion.bash

Is this for zch?

## git_log_before.sh

Add global git alias' for output of commits from today and yesterday

```
$> ./git_log_before.sh
```

## id_rsa.pub

SSH public key, used for connecting to remote servers
