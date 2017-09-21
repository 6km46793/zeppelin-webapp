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
    echo "deploy"
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
