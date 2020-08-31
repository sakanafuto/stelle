# Stelle
現在もポートフォリオとして制作中の画像共有SNSです。
日本の名所から隠れた絶景までみんなで共有しようというコンセプトで、Stelle(シュテーレ）とはドイツ語で「場所」、「スポット」を意味します。

<img width="1252" alt="スクリーンショット 2020-07-16 21 38 17" src="https://user-images.githubusercontent.com/61341108/87671825-fa8bf500-c7ac-11ea-9360-12c29c468979.png">


# 制作背景
学生時代に漁村の地域活性化活動を行った際に、「この村や地域の良さををもっと他の人に知ってほしい」と思ったことがきっかけでした。丁度その頃にプログラミングと出会い何か一つWebアプリを作ろうと考えていたところだったので、これを機に「観光所紹介」をコンセプトとして制作することにしました。

## AWS構成図
<img width="1080" alt="スクリーンショット 2020-08-30 17 01 11" src="https://user-images.githubusercontent.com/61341108/91654292-7b474c00-eae2-11ea-84f2-492c3212c54f.png">


## フロントエンド
- 柔軟なグリッドシステム
- jQueryを用いたちょっとしたアニメーション

## バックエンド
- 認証周り、投稿機能周り
  - 簡単ログイン機能によるゲストユーザーでのログイン
  - RememberMe機能
  - 名前やメールアドレス、プロフィール画像の編集
  - carrierwave + minimagick + S3を用いた画像の投稿、リサイズ
  - Ajaxを用いた投稿のいいね / いいねの取り消し
  - いいねした人一覧 / いいねした投稿一覧
  - フォロー・フォロワー機能 / フォロー・フォロワー一覧
- テスト
  - RSpecを用いた単体テスト
- その他
  - 都道府県での検索機能
  
## インフラ
- 開発環境にDocker-composeの導入
- Capistranoを用いたEC2へのコマンド一つでの自動デプロイ

ホーム画面では投稿画像の比率に合わせて柔軟にグリッドを組み、Ajaxを用いて投稿一覧画面から簡単にいいねが押せるようにしました。

git管理としてはmaster, topicの２つのブランチで運用をする方法をとり、GitHubではプルリクエストやレビューを用いて疑似チーム開発についても学びました。

# URL
https://stelle-app.com

# 使用技術
- Ruby 2.6.5
- Rails 6.0.3.2
- RSpec
- MySQL 8.0.19
- Capistrano
- Nginx / Unicorn
- AWS (VPC, EC2, RDS, S3, ALB, ACM, Route53)
- Docker
- jQuery / Sass / Bootstrap

# 今後の課題
- 機能数の増加(コメント機能、マップ表示etc)
- テストを充実させる（不具合をなくす）
- コードの整理
