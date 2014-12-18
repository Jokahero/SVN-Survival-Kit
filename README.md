SVN Survival Kit
--------------------------------------------------
This tool is here to help people that love Git but are stuck with SVN (at work)

It does not pretend to be the solution (or an alternative to git svn) but just a handful of convenience
commands to tend to make this world better (despite the use of SVN)

# Used softwares

This script uses :
* colordiff (https://github.com/daveewart/colordiff)
* colorsvn 	(http://colorsvn.tigris.org)

_These are not required dependencies, but will be used if installed._

# How to

This script stands for the svn command

The verbs that are not overriden are thrown back to the original svn bin

To enable this script just source it in your favorite shell configuration file

```sh
source ssk.sh
```
# Special commands

## Patch creation

As 'svn diff' uses colordiff (if installed) and produces unreadable patches, patch creation can be done using the command

```sh
svn patch --create file.patch
```

## Stash

Inspired by the Git stash, it allows to store/apply some differences in a repository

Stashes are repository related (they are shared between branches of the same repository)

* **svn stash list** : Lists all the stashes
* **svn stash** :	Stores the current changes as the main stash
* **svn stash pop** : Apply the changes stored in the main stash, and free it
* **svn stash _my_stash_** : Stores the changes under a the name _my_stash_
* **svn apply _my_stash_** : Apply the changes stored in the stash refered by the name _my_stash_ (the stash is not deleted and can be applied later)
* **svn stash delete _my_stash_** : Deletes the stash identified by the name _my_stash_

## Purge

This command deletes ALL the unversionned files in the repository
