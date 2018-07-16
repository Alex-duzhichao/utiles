# **Install software**

## Windows powershell cmd
	USERHOME = C:\Users\alexzcdu
    refreshenv
    echo $env:tmp

## [Install choco](https://chocolatey.org/docs/installation#installing-chocolatey)
1. Run **powershell** with admin priviledge
2. Run **Get-ExecutionPolicy**. If it returns **Restricted**, then run **Set-ExecutionPolicy AllSigned -Force**. And then run **Get-ExecutionPolicy**, it should output **AllSigned**.
3. Run the following command:
	Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
4. Restart the **powershell**, and then run **choco -h**

## [Install cygwin](https://chocolatey.org/packages/Cygwin)
	choco install -y cygwin
	choco install -y cyg-get

### set cygwin env variable
	CYGBIN = C:\tools\cygwin\bin\

### set cygwin http(s) proxy
	export http_proxy="http://web-proxy.tencent.com:8080"
	export https_proxy="http://web-proxy.tencent.com:8080"

## cygwin install package
	cyg-get.bat unzip
	cyg-get.bat zip
	cyg-get.bat wget
	cyg-get.bat curl
	cyg-get.bat nc
	cyg-get.bat chere
    chere -i -t mintty

## [Install vs build tools](https://chocolatey.org/packages/visualstudio2017buildtools)
	choco install -y visualstudio2017buildtools
	choco install -y visualstudio2017-workload-vctools

添加 C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin\; 到系统path

## [Install chrome](https://chocolatey.org/search?q=chrome)
	choco install -y googlechrome

## [Install qdir](https://chocolatey.org/search?q=qdir)
	choco install -y --ignore-checksums qdir

###### 选择语言
1. 选择栏第一项
2. 倒数第三行画有国旗的选项

###### 窗口排列
1. 选项
2. Q-Dir 界面
3. 启动视图 -> 使用最近视图

###### 设置打开
1. 选项
2. 打开所有
3. 在已有实例新标签中打开

###### 设置显示隐藏文件 
1. 选项
2. 系统
3. 显示隐藏文件 


## [Install everything](https://chocolatey.org/packages?q=everything)
	choco install -y everything

###### 设置点击打开路径
1. 工具
2. 选项
3. 视图
4. 高亮光标经过行  

###### 设置高亮 
1. 工具
2. 选项
3. 结果
4. 双击路径打开目录 

###### 设置历史搜索 
1. 工具
2. 选项
3. 历史
4. 启用搜索历史

## [Install sublime](https://chocolatey.org/packages?q=sublime)
	choco install -y sublimetext3

## [Install 7zip](https://chocolatey.org/packages/7zip)
	choco install -y 7zip

## [Install winrar](https://chocolatey.org/packages/winrar)
	choco install -y winrar

## [Install git](https://chocolatey.org/packages/git)
	choco install -y git
	choco install -y tortoisegit

### 配置github, 在 cygwin  和  Gitshell 分别执行
	git config --global user.name "Alex-duzhichao"
	git config --global user.email "duzhichaomail@gmail.com"


## [Install foxitreader](https://chocolatey.org/packages/FoxitReader)
	choco install -y foxitreader

## [Install python2](https://chocolatey.org/packages/python2)
*最好不要同时安装python2 和python3，可能出现冲突，优先安装python3
*May be need restart the system first*

	choco install -y python2

## [Install python3](https://chocolatey.org/packages/python)
*vim 要求python3 版本为 3.5*	
	choco install -y python -version 3.5.4

	choco uninstall -y python
	choco uninstall -y python3

*确认 PYTHONHOME="C:\\Python35"*	

## [Install pip](https://chocolatey.org/packages/pip)
	curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
	python get-pip.py
	rm -f get-pip.py
	
	curl -x web-proxy.tencent.com:8080  -k https://bootstrap.pypa.io/get-pip.py | python
	-x proxy address
	-k insecure, withou certs

	pip install requests
	pip install pgen
	pip install cython #依赖vs build tools
	
	pip install pyyaml
	pip install Cheetah3

如果失败则尝试：
1. 在 https://www.lfd.uci.edu/~gohlke/pythonlibs/#lxml 下载 lxml-4.2.3-cp37-cp37m-win_amd64.whl
2. pip install C:\Users\alexzcdu\Downloads\lxml-4.2.3-cp37-cp37m-win_amd64.whl
3. 如果报错*is not a supported wheel on this platform*， https://www.cnblogs.com/nice-forever/p/5371906.html

## [Install golang](https://chocolatey.org/packages?q=golang)
	choco install -y golang

## [Install cmake](https://chocolatey.org/packages?q=cmake)
	choco install -y cmake

	添加 C:\Program Files\CMake\bin\ 到系统PATH

## [Install sogou-pinyin](https://pinyin.sogou.com/)
*依赖python*
	
	python installSoftware.py sogou_pinyin

## [Install env_editor](http://eveditor.com/download/)
	python installSoftware.py env_editor

## [Install ditto](https://chocolatey.org/packages?q=ditto)
	choco install -y ditto

- 选择 At Previous Position
- 设置 1 - 10 的快捷键

## [Install autohotkey](https://chocolatey.org/packages?q=autohotkey)
	choco install -y autohotkey

## [Install lua](https://chocolatey.org/packages?q=lua)
	choco install -y lua

## [Install xshell](http://www.softpedia.com/get/Network-Tools/Telnet-SSH-Clients/Xshell-Free.shtml)
	python installSoftware.py xshell

- 配色方案 -> New black
- 字体名 -> Consolas
- 字体大小 -> 14

## [Install ag(the silver searcher)](https://chocolatey.org/packages?q=ag)
	choco install -y ag


## [Install nodejs](https://chocolatey.org/search?q=nodejs)
	choco install -y nodejs
	
	npm config set proxy "http://web-proxy.tencent.com:8080"
	npm config set https-proxy "http://web-proxy.tencent.com:8080"
	npm install -g typescript


## [Install vim](https://chocolatey.org/packages?q=vim)
	choco install -y vim

	VIMPATH = %USERHOME%.vim

#### 安装ctags 和 cscope
	python installSoftware.py ctags
	python installSoftware.py cscope

*运行gvim并执行*
	PlugInstall
	//gvim +PlugInstall +qall

#### youcomplete
	 cd $VIMPATH/plugged/YouCompleteMe/ 
	 git submodule update --init --recursive

	 python install.py --go-completer --js-completer --clang-completer


如果安装报**hash not match**，则说明下载libclang失败，检查是否设置了http代理，也可以手动下载"http://llvm.org/releases/3.6.2/clang+llvm-3.6.2-x86_64-linux-gnu-ubuntu-14.04.tar.xz", 到 $VIMPATH/plugged/YouCompleteMe/third_party/ycmd/clang_archives/ 目录

	YcmRestartServer
	YcmDiags
	YcmDebugInfo
	YcmToggleLogs

## [Install qq](http://im.qq.com/pcqq/)
	python installSoftware.py qq

## [Install wechat](http://weixin.qq.com/cgi-bin/readtemplate?t=win_weixin&lang=zh_TW)
	python installSoftware.py wechat

## [Install fiddler](https://chocolatey.org/search?q=fiddler)
	choco install -y fiddler

### chrome 设置fiddler 代理
1. 打开 proxy-switchysharp 插件
2. 添加 http/https 代理为 127.0.0.1:8888
