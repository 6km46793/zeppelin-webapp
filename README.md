# Zeppelin Web Application

本工程在 0.7.2 版本运行<br>
通过修改 zeppelin 的前段项目来实现自己的一些定制，定制内容如下：<br>

- 页面上添加日期、时间、日期选择控件
- 添加下来多选控件并支持全选、全不选功能
- 权限控制。在不需要登录或者需要登录时，developer 分组的用户才能看见 zeppelin 的全貌，别的用户只能看见任务并运行任务，不能进行任何的增删改查等操作
- 页面样式的一些微调
- 页面显示的微调

## 开发调试

1. 下载 zeppelin 并在本地运行起来。sudo zeppelin-deamon.sh start
2. clone 本工程到本地
3. 安装 node.js npm
4. 按下面的步骤云信

```sh
# install required depepdencies and bower packages (only once)
$ npm install -g yarn
$ yarn install

# build zeppelin-web for production
$ yarn run build

# run frontend application only in dev mode (localhost:9000)
# you need to run zeppelin backend instance also
$ yarn run dev

# If you are using a custom port, you must use the 'SERVER_PORT' variable to run the web application development mode
$ SERVER_PORT=8080 yarn run dev

# execute tests
$ yarn run test
```

## zeppelin 设置相关

1. 虚拟机内存设置：zeppelin-env.sh
2. 登录设置：shiro.ini

zeppelin-env.sh:<br>
export ZEPPELIN_MEM="-Xms512m -Xmx1024m -XX:MaxPermSize=1024m"<br>
export ZEPPELIN_INTP_MEM="-Xms512m -Xmx1024m -XX:MaxPermSize=1024m"<br>
export ZEPPELIN_INTERPRETER_OUTPUT_LIMIT=1024000000<br>
shiro.ini:<br>
admin = 123456, developer<br>
user = 123456, user<br>

注意：运行 zeppelin 是默认配置，只有在 conf 目录下，通过 .template 文件来初始化对应文件，然后重启 zeppelin，配置才会生效

# 注意

1. 图例数据排序显示，可以修改 visualization-nvd3chart.js ，也可以修改 nv.d3.js。具体解释见 visualization-nvd3chart.js this.chart.interactiveLayer.tooltip.contentGenerator 这一段的代码
2. developer 角色才能看见。zeppelin 的设置，在 conf 目录下的 shiro.ini 文件中

上面两点很重要。

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
