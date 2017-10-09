# Zeppelin Web Application

This is Zeppelin's frontend project.

## Development Guide

### Packaging

If you want to package the zeppelin-web only, simply run this command in this folder.<br>
This will download all the dependencies including node (the binaries in the folder `zeppelin-web/node`)

```
$ mvn package
```

### Local Development

It is recommended to install node 6.0.0+ since Zeppelin uses 6.9.1+ (see [creationix/nvm](https://github.com/creationix/nvm))

All build commands are described in [package.json](./package.json)

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

## Troubleshooting

### Git error

In case of the error `ECMDERR Failed to execute "git ls-remote --tags --heads git://xxxxx", exit code of #128`

change your git config with `git config --global url."https://".insteadOf git://`

### Proxy issues

Try to add to the `.bowerrc` file the following content:

```
  "proxy" : "http://<host>:<port>",
  "https-proxy" : "http://<host>:<port>"
```

also try to add proxy info to yarn install command:

```xml
<execution>
    <id>yarn install</id>
    <goals>
        <goal>yarn</goal>
    </goals>
    <configuration>
        <arguments>--proxy=http://<host>:<port> --https-proxy=http://<host>:<port></arguments>
    </configuration>
</execution>
```

and retry to build again.

## Contribute on Zeppelin Web

If you wish to help us and contribute to Zeppelin WebApplication, please look at the overall project [contribution guidelines](https://zeppelin.apache.org/contribution/contributions.html) and the more focused [Zeppelin WebApplication's documentation](https://zeppelin.apache.org/contribution/webapplication.html).

# 介绍

# 注意

1. 图例数据排序显示，可以修改 visualization-nvd3chart.js ，也可以修改 nv.d3.js。具体解释见 visualization-nvd3chart.js this.chart.interactiveLayer.tooltip.contentGenerator 这一段的代码
2. developer 角色才能看见。zeppelin 的设置，在 conf 目录下的 shiro.ini 文件中

# 非 developer 组用户不可操作的部分：

| 位置
| ---------------------------
| 首页：倒入 note、新建note
| 首页：note 后面的：清空输出、重命名、删除note
| 首页：点击notebook 不出现新建
| 首页：notebook 旁边的 job 按钮
| 下面的是 notebook 页面的权限控制
| 总控制按钮列表的 克隆按钮
| 总控制按钮列表的 切换私有状态按钮
| 总控制按钮列表的 下载按钮
| 总控制按钮列表的 版本控制按钮组
| 总控制按钮列表的 删除、恢复 note 按钮
| 总控制按钮列表的 设置按钮组

- 查看源代码
- 新建笔记本
- 删除笔记本
- 私人模式开启关闭
