AzPainter for Mac
====

Convert the AzPainter to run on Mac  
Original is [AzPainter for Linux](http://azsky2.html.xdomain.jp/linux/azpainter.html)

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

## Author

[ABCanG](https://github.com/abcang)
