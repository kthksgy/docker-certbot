# docker-certbot
Let's Encryptクライアント「Certbot」での認証と自動更新を行うDockerイメージです。

## 警告
**このイメージは正常に動作しないので利用は非推奨です。**  
Docker Hubからは削除を行いましたが、GitHubの本リポジトリは暫くこのままにしておきます。

## イメージ内容
|ベースイメージ|alpine:3.11|
|:-:|:-:|
|エントリポイント|`crond -f`|
|コマンド|`-l 2`|


## ビルド
`git clone`した後に`docker build`してください。`--build-arg`で自動実行のタイミングを指定できます。デフォルトでは日本時間で毎週水曜日の午前5時25分です。

```shell
$ git clone https://github.com/kthksgy/docker-certbot.git
$ docker build --build-arg CRON_SCHEDULE="25 5 * * 3" -t kthksgy/certbot:latest docker-certbot
```

## 実行
`--rm`で実行すると実行後にコンテナが破棄されて便利です。

`--restart=always`で実行するとコンテナがDockerの再起動等に合わせて自動的に起動するようになります。

実行すると`crond`がフォアグラウンドモードで起動して`certbot renew`の自動実行待機をします。

```shell
$ docker run -v ./letsencrypt:/etc/letsencrypt --restart=always --rm kthksgy/certbot:latest
```

### 認証の方法
`docker exec`でコンテナ内に入って、認証を行ってください。

```shell
$ docker exec -it [container_id] ash

# 内部でcertbotコマンドを実行して認証を行う
$ certbot
```

## 参考文献
- [Certbot](https://certbot.eff.org/)
