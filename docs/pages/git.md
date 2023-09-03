- [Git settings](#git-settings)
  - [Hooks](#hooks)
    - [post-checkout](#post-checkout)
  - [Git config](#git-config)


# Git settings

## Hooks

### post-checkout

Git doesn't save file change timestamps.<br/>
Since GNU Make use these file meta information for automatic buildings we have to restore this information after clone or checkout.

This hook will manage it automatically.

Add following code in ```.git/hooks/post-checkout```:
```sh
#!/bin/sh

# Import global config
source make/global.cfg

# Only when checkout a branch not a single file or directory
if [ -s "$GIT_CACHE_META_FILE" ] && [ "$3" == '1' ]; then
  # apply change date for all files
  make/scripts/git-cache-meta.sh --apply
fi
```

## Git config

To be able to handle with special characters in file names add the following in ```.git/config```

```sh
[core]
	filemode = true
	logallrefupdates = true
	precomposeunicode = true
	quotepath = false
```