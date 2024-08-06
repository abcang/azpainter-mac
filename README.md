AzPainter for Mac
====

Original repository: [https://gitlab.com/azelpg/azpainter](https://gitlab.com/azelpg/azpainter)  
Install with homebrew: [https://github.com/abcang/homebrew-azpainter](https://github.com/abcang/homebrew-azpainter)


## Requirement
* brew
* x window system environment(XQuartz etc)

## Install using brew tap
```bash
brew install xquartz
brew tap abcang/azpainter
brew install azpainter
ln -sf $(brew --prefix azpainter)/AzPainter.app /Applications/
```

repository: https://github.com/abcang/homebrew-azpainter

## Install without using brew tap
It will be installed in the `/Applications`

```bash
brew install xquartz
brew install svg2png
make
make install
```

## LICENSE
[MIT](https://github.com/abcang/azpainter-mac/blob/master/LICENSE)


[abcang](https://github.com/abcang)
