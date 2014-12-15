SVN Survival Kit
--------------------------------------------------
This tool is here to help people that love Git but are stuck with SVN (at work)

It does not pretend to be the solution (or an alternative to git svn) but juste a handful of convenience
commands to tend to a better world despite SVN

# Used softwares

This script uses :
* colordiff (https://github.com/daveewart/colordiff)
* colorsvn 	(http://colorsvn.tigris.org)

_These are not required dependencies, but will be used if installed._

# How to

This script stands for the svn command
The verbs that are not overriden are thrown back to original svn bin

To enable it juste source it in your favorite shell configuration file

```sh
source ssk.sh
```
# Special commands

* Patch creation

As 'svn diff' uses colordiff if installed, patch creation can be done using the command

```sh
svn patch --create file.patch
```

* Stash
Inspired by the Git stash, it allows to store/apply some differences in a repository
Stashes are repository related (they are shared through branches of the sae repository)
    * **svn stash list** : Lists all the stashes
	* **svn stash** :	Stashes the current changes as the main stash
	* **svn stash pop** : Apply the changes stored in the main stash, and free it
	* **svn stash _my_stash_** : Stashes the changes under a the name _my_stash_
	* **svn apply _my_stash_** : Apply the changes stored in the stash refered by the name _my_stash_ (he stash is not deleted and can be applied later)
	* **svn stash delete _my_stash_** : Deletes the stash identified by the name _my_stash_
