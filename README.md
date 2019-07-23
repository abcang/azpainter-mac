AzPainter for Mac
====
[![Build Status](https://travis-ci.com/abcang/azpainter-mac.svg?branch=master)](https://travis-ci.com/abcang/azpainter-mac)

Convert the AzPainter to run on Mac  
Original is [AzPainter for Linux](http://azsky2.html.xdomain.jp/linux/azpainter.html)  
This repository uses https://github.com/Symbian9/azpainter

## Requirement
* brew
* x window system environment(XQuartz etc)

## Install using brew tap
```bash
brew cask install xquartz
brew tap abcang/azpainter
brew install azpainter
ln -sf $(brew --prefix azpainter)/AzPainter.app /Applications/
```

repository: https://github.com/abcang/homebrew-azpainter

## Install without using brew tap
It will be installed in the `/Applications`

```bash
brew cask install xquartz
brew install jpeg-turbo makeicns
make
make install
```

## LICENSE
[MIT](https://github.com/abcang/azpainter-mac/blob/master/LICENSE)


[abcang](https://github.com/abcang)
