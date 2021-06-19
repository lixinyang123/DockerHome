# DockerHome
Deploy CoreHome in Docker

DockerHome是为了方便部署CoreHome而产生的项目，主要是为了方便使用，避免搭建博客时从源码构建，降低使用CoreHome的学习成本。镜像已经上传到了DockerHub和阿里云，所以此项目中只包含了docker-compose文件和一些脚本，方便一键搭建博客，下面是介绍怎样使用DockerHome来搭建CoreHome。

### 使用DockerHome快速搭建CoreHome

![build](https://github.com/lixinyang123/CoreHome/workflows/build/badge.svg?branch=main)

CoreHome是一个基于 .NET 5 和阿里云OSS的博客系统（依赖于 Aliyun.OSS.SDK.NetCore），包含了个人信息管理，主页项目管理，主题管理（主页背景，亮暗主题，BGM），博客管理、分类、标签、归档，评论及反馈提醒，服务器网络状态检测等功能。

[![ReadMe Card](https://github-readme-stats.vercel.app/api/pin/?username=lixinyang123&repo=CoreHome)](https://github.com/lixinyang123/CoreHome)

DockerHome是为了方便部署CoreHome而产生的项目，主要是为了方便使用，避免搭建博客时从源码构建，降低使用CoreHome的学习成本。

[![ReadMe Card](https://github-readme-stats.vercel.app/api/pin/?username=lixinyang123&repo=DockerHome)](https://github.com/lixinyang123/DockerHome)

### 首先确保你有一台阿里云的Linux服务器，并且开通了OSS服务。

> 注意：必须是阿里云，因为项目依赖于阿里云OSS服务（项目依赖于 Aliyun.OSS.SDK.NetCore）

- 问：什么是OSS？
答：OSS是阿里云的对象存储服务，可以用来存储对象（图片，音频，视频，等等...）

- 问：为什么要使用OSS？
答：大部分人搭建博客购买的服务器带宽都不大，所以网站上的图片，音频，视频的加载速度会很慢，所以CoreHome借助于OSS来加快网站访问速度。

- 问：OSS的价格如何？
答：很便宜，每天100M流量也就几分钱，冲10块钱用很久。

- 问：如何开通OSS
答：阿里云产品列表点进去点开通就行了，这里放个[链接](https://oss.console.aliyun.com/ "链接")。

### 创建Bucket

首先访问OSS管理控制台，如下图，这里再放个[链接](https://oss.console.aliyun.com/overview "链接")

![oss overview](https://corehome.oss-accelerate.aliyuncs.com/blogs/aliyunoss.jpg "oss overview")

在控制台中点击左侧Bucket列表

![](https://corehome.oss-accelerate.aliyuncs.com/blogs/%E5%B1%8F%E5%B9%95%E6%88%AA%E5%9B%BE%202020-08-20%20022513.jpg)

接下来点击创建Bucket，输入Bucket名称并选择区域，并将读写权限改为公共读

![CreateBucket](https://corehome.oss-accelerate.aliyuncs.com/blogs/%E5%B1%8F%E5%B9%95%E6%88%AA%E5%9B%BE%202020-08-20%20023046.jpg "CreateBucket")

最后进入Bucket中，点击文件管理，创建三个文件夹**（注意：全部小写）**
- blogs 博客中的插图默认上传文件夹
- images 个人头像以及个人项目封面默认上传文件夹
- musics 主页BGM默认文件夹**（主页会从此文件夹中随机选取音乐播放）**

![](https://corehome.oss-accelerate.aliyuncs.com/blogs/%E5%B1%8F%E5%B9%95%E6%88%AA%E5%9B%BE%202020-08-20%20023652.jpg)

### 记录Bucket信息

从Bucket列表点击刚刚创建好的Bucket，下来点击左侧的概览，记录如图的信息

![](https://corehome.oss-accelerate.aliyuncs.com/blogs/%E5%B1%8F%E5%B9%95%E6%88%AA%E5%9B%BE%202020-08-20%20032029.jpg)

- EndPoint：绿色圈的
- BucketDomainName：蓝色圈的**（如果开启了传输加速域名，可以记录黄色圈的）**
- BucketName：红色圈的

### 创建阿里云 AccessKeyId 和 AccessKeySecret

在阿里云的网页上右上角头像中点击 **AccessKey管理**

![](https://corehome.oss-accelerate.aliyuncs.com/blogs/%E5%B1%8F%E5%B9%95%E6%88%AA%E5%9B%BE%202020-08-20%20032729.png)

点击创建 AccessKey 并记录 **AccessKeyId** 和 **AccessKeySecret**

![](https://corehome.oss-accelerate.aliyuncs.com/blogs/%E5%B1%8F%E5%B9%95%E6%88%AA%E5%9B%BE%202020-08-20%20033230.jpg)

### 注册Server酱（ServerChan）

此博客使用Server酱来给你的微信发送各种通知（动态登陆密码，评论通知，反馈中心，等...）

这里放上[Server酱官网](http://sc.ftqq.com/3.version "Server酱官网")

使用你的Github账户登录Server酱，接下来点击微信推送，并使用你的微信扫码绑定Server酱。

> 如果你没有Github账户，点击[这里](https://github.com/join "这里")注册

![](https://corehome.oss-accelerate.aliyuncs.com/blogs/%E5%B1%8F%E5%B9%95%E6%88%AA%E5%9B%BE%202020-08-20%20031014.jpg)

最后点击发送消息，记录下SCKEY

![](https://corehome.oss-accelerate.aliyuncs.com/blogs/%E5%B1%8F%E5%B9%95%E6%88%AA%E5%9B%BE%202020-08-20%20031415.jpg)

### 部署CoreHome

首先克隆DockerHome项目到服务器
```shell
git clone https://github.com/lixinyang123/DockerHome.git
```

项目结构如下
- DockerHome（根目录）
	- config（用户配置文件夹）
		- SiteMap.txt（站点地图）
		- appsettings.json（项目配置）
		- favicon.ico（网站图标）
	- scripts
		- pull-images.sh（从阿里云拉取镜像脚本）
	- README.md（自述文件）
	- docker-compose.yml（docker-compose配置）

> 注意：用户需要配置的内容全部在config文件夹下，其他文件不要修改

- 如果你的服务器已经安装过 Docker 和 Docker-Compose，那么可以开始修改配置文件了。

```json
{
  "Logging": {
    "LogLevel": {
      "Default": "Information",
      "Microsoft": "Warning",
      "Microsoft.Hosting.Lifetime": "Information"
    }
  },
  "AllowedHosts": "*",
  "ConnectionStrings": {
    "CoreHome": "server=database;user id=root;password=password;database=corehome"
  },
  "PageSize": 10,
  "ServerChanSckey": "",
  "BaiduLinkSubmit": "",
  "OssConfig": {
    "AccessKeyId": "",
    "AccessKeySecret": "",
    "EndPoint": "",
    "BucketDomainName": "",
    "BucketName": ""
  }
}
```

- ServerChanSckey 填入Server酱的SCKEY，详情见上方 **注册Server酱** 部分
- BaiduLinkSubmit 百度资源搜索平台主动推送 API
- AccessKeyId 和 AccessKeySecret 填入阿里云 AccessKeyId 和 AccessKeySecret，详情见上方 **创建阿里云 AccessKeyId 和 AccessKeySecret** 部分
- EndPoint，BucketDomainName，BucketName 填入 OSS 的 Bucket 信息，详情见上方 **记录Bucket信息**

完成之后效果如下

```json
{
  "Logging": {
    "LogLevel": {
      "Default": "Information",
      "Microsoft": "Warning",
      "Microsoft.Hosting.Lifetime": "Information"
    }
  },
  "AllowedHosts": "*",
  "ConnectionStrings": {
    "CoreHome": "server=database;user id=root;password=password;database=corehome"
  },
  "PageSize": 10,
  "ServerChanSckey": "SCU53487T3f2*****************5d0463b66ac44",
  "BaiduLinkSubmit": "http://data.zz.baidu.com/urls?site=******************",
  "OssConfig": {
    "AccessKeyId": "LT*******************Nx",
    "AccessKeySecret": "xS*******************kHk",
    "EndPoint": "https://oss-cn-shenzhen.aliyuncs.com/",
    "BucketDomainName": "https://corehome.oss-accelerate.aliyuncs.com/",
    "BucketName": "corehome"
  }
}
```

> 注意：EndPoint 和 BucketDomainName 的前面加上 https:// 并在结尾加上 / 

到此，最主要的配置已经完成

接下来修改SiteMap.txt中的链接，改为你的域名即可

```html
https://www.example.com/
https://www.example.com/Blog
https://www.example.com/Tags
https://www.example.com/Archive
https://www.example.com/FeedBack
```

将 www.example.com 改为你的域名，改后的效果如下

```html
https://www.lllxy.net/
https://www.lllxy.net/Blog
https://www.lllxy.net/Tags
https://www.lllxy.net/Archive
https://www.lllxy.net/FeedBack
```

最后将你的头像重命名为favicon.ico，并替换config中的favicon.ico即可

### 启动CoreHome

进入DockerHome项目根目录，执行

```shell
docker-compose up
```

默认会从DockerHub拉取需要的镜像并启动

拉取的镜像：
- lixinyang/corehomehomepage:latest
- lixinyang/corehomeadmin:latest
- mysql:latest
- nginx:latest

如果拉取速度很慢，可以从阿里云拉取镜像，只需执行 **scripts/aliyun.sh** ，并重新执行 **docker-compose up** 即可。

```shell
bash ./scripts/pull-image.sh.sh
docker-compose up
```

网站默认在8080端口启动（ http://localhost:8080 ） ，启动时请注意端口是否被占用

如果端口被占用，可以修改 docker-compose.yml 中 reverse-proxy 的 ports

改为 **你要启动的端口:80** 即可

### 首次启动

>注意：首次启动后，访问 / （ **内网中的localhost:8080** ） 会出错

因为此时未创建数据库，所以首先需要创建数据库

首先访问 /Admin 并登录（首次登录只能使用Server酱动态密码进行登录）

访问 /Admin/Database 会看到提示**连接失败**

此时访问 /Admin/DataBase/Create 创建数据库（创建成功时会提示**创建成功**）

再次访问 /Admin/Database 会看到提示**连接成功**

接下来点击侧边栏 Profile 配置个人信息即可

最后访问 / 会看到网站成功跑起来了
