# Nginx別コンテナ化の変更内容

## 変更概要
Redmineコンテナ内部で動作していたNginxを、独立したコンテナとして分離しました。

## アーキテクチャ変更

### 変更前
```
[クライアント] → [Redmineコンテナ: Nginx + Puma] → [MySQLコンテナ]
```

### 変更後
```
[クライアント] → [Nginxコンテナ] → [Redmineコンテナ: Puma] → [MySQLコンテナ]
```

## 主な変更点

### 1. 新規追加ファイル
- `nginx/Dockerfile`: Nginx専用コンテナのDockerfile
- `nginx/nginx.conf`: Nginxメイン設定ファイル
- `nginx/redmine.conf`: Redmine用リバースプロキシ設定
- `nginx/docker-entrypoint.sh`: 環境変数展開用エントリーポイント

### 2. docker-compose.yml
- **nginxサービス追加**: 
  - ポート80を公開
  - Redmineコンテナへのリバースプロキシ
  - ヘルスチェック機能
  - ログの永続化 (`./volumes/nginx_logs`)

- **redmineサービス変更**:
  - ポート公開を削除 (内部ポート3000のみexposeに変更)
  - 内部Nginxを無効化 (`DISABLE_NGINX=true`)
  - Nginx関連環境変数を削除
  - ヘルスチェックをポート3000に変更

### 3. redmine/Dockerfile
- `DISABLE_NGINX`ビルド引数を追加
- 内部Nginxを無効化する処理を追加

### 4. 環境変数
- `NGINX_WORKERS`: Nginxワーカープロセス数 (デフォルト: 1)
- `NGINX_MAX_UPLOAD_SIZE`: 最大アップロードサイズ (デフォルト: 20m)

## メリット

1. **スケーラビリティ向上**: NginxとRedmineを個別にスケール可能
2. **保守性向上**: Nginxの設定変更時にRedmineコンテナの再ビルド不要
3. **責任分離**: Webサーバーとアプリケーションサーバーの役割を明確化
4. **柔軟性向上**: Nginx設定のカスタマイズが容易
5. **リソース管理**: 各コンテナのリソース制限を個別に設定可能

## 起動方法

```bash
# 既存のコンテナを停止・削除
docker compose down

# 新しい構成でビルド
docker compose build

# コンテナ起動
docker compose up -d

# 起動確認
docker compose ps
```

## 注意事項

- Nginxのログは `./volumes/nginx_logs` に保存されます
- Redmineコンテナは内部ポート3000でPumaが動作します
- Nginxコンテナ経由でのみアクセス可能です
- CI/CDパイプライン(.github/workflows/ci.yml)も必要に応じて更新してください

## トラブルシューティング

### Nginxコンテナが起動しない
```bash
# Nginxコンテナのログ確認
docker logs docker-redmine-nginx-1

# 設定ファイルの構文チェック
docker exec docker-redmine-nginx-1 nginx -t
```

### Redmineに接続できない
```bash
# Redmineコンテナの起動確認
docker exec docker-redmine-redmine-1 curl http://localhost:3000

# Nginxからの疎通確認
docker exec docker-redmine-nginx-1 wget -O- http://redmine:3000
```
