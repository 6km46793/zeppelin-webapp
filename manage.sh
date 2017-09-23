if [ $# -lt 1 ]; then
    echo "参数错误，正确的格式：command build|pack"
    echo "build 重新编译并打包；pack 已经编译好生成了 dist 文件夹，将 dist 文件夹打包;deploy 正式环境，将打包结果替换掉默认生成的结果"
    exit 3
fi

pack()
{
    if [ -f "zeppelin-web-0.7.2.war" ]; then
        echo "压缩文件已存在,删除"
        rm zeppelin-web-0.7.2.war
    fi
    if [ ! -d dist ]; then
        echo "dist 文件夹不存在，请先运行 yarn run build 命令 或者直接运行 ./pack.sh pack 命令"
        exit 3
    fi
    cd dist
    jar -cvf zeppelin-web-0.7.2.war *
    mv zeppelin-web-0.7.2.war ../zeppelin-web-0.7.2.war
}

deploy()
{
    # 重启服务
    sudo ../zeppelin-0.7.2-bin-all/bin/zeppelin-daemon.sh restart
    sleep 1
    targetPath="../zeppelin-0.7.2-bin-all/webapps/webapp"
    warFileName="zeppelin-web-0.7.2.war"
    if [ ! -d ${targetPath} ]; then
        echo "请先解压 zeppelin 的 war 压缩包，并进入解压出的目录运行 sudo bin/zeppelin-daemon.sh start 命令"
        exit 3
    else
        echo "已存在 webapp 目录，先删除再解压"
        rm -rf ${targetPath}
        mkdir -p ${targetPath}
    fi
    unzip ${warFileName} -d ${targetPath}
}

case "$1" in
    build)
        yarn run prebuild
        yarn run build
        pack
        ;;
    pack)
        pack
        ;;
    deploy)
        deploy
        ;;
esac
