# Zeppelin Web Application

本工程在 0.7.2 版本运行<br>
通过修改 zeppelin 的前端项目来实现自己的一些定制，定制内容如下：<br>

- 页面上添加日期、时间、日期选择控件；
- 添加下拉多选控件并支持全选、全不选功能；
- 权限控制。在不需要登录或者需要登录时，developer 分组的用户才能看见 zeppelin 的全貌，别的用户只能看见任务并运行任务，不能进行任何的增删改查等操作。具体限制了哪些权限见后面介绍；
- 页面样式的一些微调；
- 页面显示的微调；
- 运行任务时添加加载动画；

## 开发调试

1. 下载 zeppelin 0.7.2 版本: `wget https://mirrors.tuna.tsinghua.edu.cn/apache/zeppelin/zeppelin-0.7.2/zeppelin-0.7.2-bin-all.tgz`
2. 在本地运行: `zeppelin: sudo zeppelin-deamon.sh start`
3. clone 本工程到本地: `get clone git@github.com:zhifuliu/zeppelin-webapp.git`
4. 安装 node.js npm
5. 安装 `yarn: npm install -g yarn --verbose`
6. 安装项目依赖: `yarn run install`
7. 运行前端代码: `yarn run predev` `yarn run dev`

如果运行成功的话，会在浏览器打开 localhost:9000 ，并且监听了文件的修改，只要文件有修改，页面能立即作出相应，但是在我的 Mac 上，zeppelin 貌似运行很慢，每次都要等几十秒。如果过程中提示需要安装别的依赖，使用 npm 安装就好了。关于 zeppelin 的安装运行，这里不做介绍。

> 版本号牵扯到最终的代码部署，后面讲解

## zeppelin 设置相关

```
虚拟机内存设置：zeppelin-env.sh:
export ZEPPELIN_MEM="-Xms512m -Xmx1024m -XX:MaxPermSize=1024m"
export ZEPPELIN_INTP_MEM="-Xms512m -Xmx1024m -XX:MaxPermSize=1024m"
export ZEPPELIN_INTERPRETER_OUTPUT_LIMIT=1024000000
```

```
登录设置：shiro.ini:
# [user]
admin = 123456, developer
user = 123456, user

# [role]
developer = *
user = *
```

> 用户设置是为了配合权限的使用，在具体的任务组页面，设置为私有模式，指定owner、writer、reader（这三种角色都可以按照用户或者分组来设置）。owner 拥有所有权限，我们设置为 developer 组，这个组在前端也是最高权限；writer 组可以修改、运行代码，但是前端做了限制，所以最普通的设置，和 reader 一样，reader 只有查看结果权限

> 注意：运行 zeppelin 是默认配置，只有在 conf 目录下，通过 .template 文件来初始化对应文件，然后重启 zeppelin，配置才会生效

## manage.sh 讲解

1. 本地运行 pack 或者 build 命令，生成最新的压缩包
2. 服务器上运行 deploy，这个命令是将最新的打包结果替换zeppelin 默认的 webapps/webapp 下的所有文件。需要注意的是：zeppelin-webapp 工程必须和 zeppelin-0.7.2-bin-all 在同级目录；zeppelin 在每次 stop 的时候，会删除 webapps 目录，每次 start 的时候，会从根目录解压

# 非 developer 组用户不可操作的部分：

| 位置
| ---------------------------
| 首页：倒入 note、新建note
| 首页：note 后面的：清空输出、重命名、删除note
| 首页：点击notebook 不出现新建
| 首页：notebook 旁边的 job 按钮
| 首页：关于 zeppelin 的介绍
| 下面的是 notebook 页面的权限控制：
| 总控制按钮列表的 克隆按钮
| 总控制按钮列表的 切换私有状态按钮
| 总控制按钮列表的 下载按钮
| 总控制按钮列表的 版本控制按钮组
| 总控制按钮列表的 删除、恢复 note 按钮
| 总控制按钮列表的 设置按钮组
| 下面是具体一个 note 的权限控制：
| 设置
| 代码查看按钮
| 点击空白处新建一条笔记
| 右上角控制：除推出登录外，都去掉
| 不让修改笔记名字，笔记名字一直可见

## 注意

1. 图例数据排序显示，可以修改 visualization-nvd3chart.js ，也可以修改 nv.d3.js。具体解释见 visualization-nvd3chart.js this.chart.interactiveLayer.tooltip.contentGenerator 这一段的代码
2. developer 角色才能看见。zeppelin 的设置，在 conf 目录下的 shiro.ini 文件中

> 上面两点很重要。

## 各个修改的实现

修改项                 | 实现
------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
页面上添加日期、时间、日期选择控件   | 原有的 input 控件;控件名字添加额外信息，表示新控件类型; 在控件渲染页面对"新控件"做支持; 使用了 bootstrap 的样式; 时间控件使用了angular-bootstrap-datetimepicker;
添加下拉多选控件并支持全选、全不选功能 | 原有的checkbox 控件拓展了下拉多选;下拉的实现是直接修改了样式；多选的实现是在control.js 里面修改了 onchange 事件的逻辑，添加了全选的判断
权限控制                | 权限起作用的前提是需要登录;如果需要登录，登录成功后，后端返回用户组信息;在 app.controller.js 里面添加函数，参数是用户登录信息，判断是否是 developer 用户;然后在所有需要添加权限的地方添加 ng-if 判断
页面样式的一些微调           | 直接修改样式代码和html代码,有些变量在 app.controller.js 中定义
页面显示的微调             | 直接修改样式代码和html代码,有些变量在 app.controller.js 中定义
运行任务时添加加载动画         | 直接在全局添加一个弹出框，并用 ng-show 控制是否显示(index.html 和 app.controller.js);使用了第三方的加载动画库 loadders.css;查看这个库的实现，指导，在页面初始化的时候需要运行 loadders.css.js ，所以把这段代码直接加在了 index.html 文件中运行，剩下的就是引用 loadders.css 文件，并在页面上添加class;点击运行设置显示;websocketEvent.factory.js 中定义了一个函数，zeppelin-web 项目的所有数据请求都会有这个回调，websocketCalls.ws.onMessage, 可以查看页面的 console，任务运行完毕的标识为 PARAGRAPH_UPDATE_OUTPUT,在这个里面设置不显示;
