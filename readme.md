## 介绍

在OS X下安装Safari插件时，大多数插件的安装包索取root权限，并将插件安装到`/Library/Internet Plug-Ins/`下。但这并不是必须的，事实上，几乎所有插件都可以用user权限安装到`~/Library/Internet Plug-Ins/`下，并且不会产生任何问题。不少插件的安装包会利用root权限安装一些其他的程序、启动项等到系统当中，这或许是出于用户利益的考虑，但这也会使部分人产生警惕与忧虑。

本项目提供了一系列脚本，用于将特定的Safari插件以user权限安装到`~/Library/Internet Plug-Ins/`下，并且只安装插件本身，而不安装其他任何非必须的部分。

## 使用

1. 安装Flash插件：

```
$ bash flash.sh
```

2. 安装支付宝插件：

```
$ bash alipay.sh
```

3. 安装工商银行插件：

```
$ bash icbc.sh
```

若要更新上述插件，再次执行以上命令即可。

## LICENSE

The MIT License

Copyright (c) 2015 Daniel

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
