## ESAL - Environment Select for Archlinux

This tool is insipred by Gentoo eselect util for managinig system wide or local user environment, like PAGER, 
VI, BASHCOMP and so on..

Currently supported modules are: 
```
bashcomp
editor
pager
fontconfig
java
news
vi
visual
```

### Usage
E.g to read arhclinux news, first we need to fetch latest news from upstrem:
```
$ esal news fetch
$ esal news read 1
```

Example of setting vi implementation to vim
```
$ esal vi list
Available vi implementations: 
 [1] vim
$ esal vi set 1
```

For explicit module usage type
`esal <module> help`

### Instalation:

Use provided `PKGBUILD` within repo

``` 
$ git clone https://github/pale3/esal
$ cd esal
$ makepkg -si
```

After instalation, there is one more step which you need to take before `esal`
will be succesfuly installed

```
$ sudo touch /etc/env.conf
$ echo "source /etc/env.conf" | sudo tee -a /etc/profile
```

for testing purpose just clone this repo, 
edit ES_DATA_PATH="/usr/lib/esal" to your esal main dir

for more information exec esal.
