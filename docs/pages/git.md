- [GIT settings](#git-settings)
  - [Hooks](#hooks)
    - [post-checkout](#post-checkout)


# GIT settings

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

if [ -s "$GIT_CACHE_META_FILE" ]; then
  # apply change date for all files
  make/scripts/git-cache-meta.sh --apply
fi
```

## GIT config

To be able to handle with special characters in file names add the following in ```.git/config```

```sh
[core]
	filemode = true
	logallrefupdates = true
	precomposeunicode = true
	quotepath = false
```