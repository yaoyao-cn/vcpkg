## 集成到VS开发环境
``` bash
cd <vcpkg-export-dir>
./vcpkg.exe integrate install
```
注意：如果包的位置改变了，只需重复以上操作。本机也可以放多个版本的包，最后一次安装会覆盖之前的安装

## 从VS开发环境卸载
``` bash
cd <vcpkg-export-dir>
./vcpkg.exe integrate remove
```

## 查看已安装的第三库
已安装库信息位于 vcpkg-export-dir\installed\vcpkg\info