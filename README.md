# docker
Dockerの設定ファイル  
CentOS7にphp5.6とmysql5.7が入ったコンテナを作成します

## 使用方法
1. .env ファイルを作成して以下の記述を行う
```
MYSQL_USERNAME=<MYSQLユーザー名>
MYSQL_PASSWORD=<MYSQLパスワード>
WWW_DIR=</var/www/htmlにマウントするホストのディレクトリパス>
SHARE_DIR=</fileにマウントするホストのディレクトリパス>
```

2. confフォルダにvhosts.confを作成して以下の記述を行う  
サブドメインを使用したい場合はこのファイルに追記する
```
<VirtualHost *:80>
    ServerName localhost
    DocumentRoot "/var/www/html"
</VirtualHost>
```
