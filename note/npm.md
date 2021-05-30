# NPM镜像使用说明
该镜像处于测试阶段，如有问题，请及时反馈。

## 如何使用
``npm install --registry=https://mirrors.pku.edu.cn/npm``


## 注意事项
1. 该镜像利用nginx进行代理原始地址 https://registry.npmjs.org 并使用cache机制进行加速，故而该镜像安装包有一定延迟，目前缓存失效时间为一天。且初次安装或者缓存失效之后，安装较慢。
2. 使用node-sass的用户请注意：该package依赖从github下载一个文件，当机器无法访问github时会出现安装失败。安装失败输出如下(在第一次报ERROR的地方往前翻一点)：
    ``` bash
    > node-sass@4.14.1 install /home/fzx/dev/node_modules/node-sass
    > node scripts/install.js

    Downloading binary from https://github.com/sass/node-sass/releases/download/v4.14.1/linux-x64-48_binding.node 
    Cannot download "https://github.com/sass/node-sass/releases/download/v4.14.1/linux-x64-48_binding.node": # 注意：该地址每个人不一定一样，故而请实测自己的地址

    ETIMEDOUT

    Timed out attemping to establish a remote connection
    ```
    本文提供一种解决方式：

    0. 首先正常进行安装：``npm install --registry=https://mirrors.pku.edu.cn/npm``，这一步会获得上述报错，目的是获取需要的github下载地址。
    1. 手动下载该文件至任意位置
        - 对于Linux用户设置：``export SASS_BINARY_PATH=文件下载绝对路径（不是文件夹路径）``
        - 对于Windows用户设置(已在powershell验证)：``setx SASS_BINARY_PATH 文件下载绝对路径（不是文件夹路径）``
    2. ``rm node_modules/node-sass``，如果``node_modules/node-sass``存在，需要删除node-sass的缓存，否则存在npm认为node-sass已经安装好并跳过的可能
    3. 重新安装：``npm install --registry=https://mirrors.pku.edu.cn/npm``
3. 附npm缓存地址。如失败，请首先清除并备份缓存
    - Linux ``~/.npm``
    - Windows ``C:\Users\用户名\AppData\Roaming\npm-cache\_cacache``
