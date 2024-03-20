#### 動作確認
1. terraform, aws cliをインストールする
2. `aws configure`でAWS Consoleから発行した必要な権限を持ったアクセスキーを設定する
3. `terraform init`を実行
4. `make`実行、各リソースがawsにデプロイされる
5. `make ssh`でデプロイしたec2インスタンスにアクセスできることを確認

#### TODO
- ホストへのterraform、aws cliのインストール
- (bonus)ec2を停止してもIPアドレスが変わらないようにelastic IPを使うように変更
- (bonus)作成したelastic IPへドメインが向くようにDNSを設定
- (bonus)ACMを使った証明書の管理

#### 9/9追記 -> feature/tlsで実現したいこと
何も覚えてないので、やりたかったであろうことを再整理する
- [x] Route53でドメインを管理する
  - 予め取得したドメインのホストゾーンを構成する
    - Google Domainsのカスタムネームサーバーの登録は予めやっちゃう？
    - TODO: 余裕があったらimportする
- [x] ACMで証明書を管理する
  - ワイルドカード証明書
- [x] デプロイされるアプリインスタンスにALBでパブリックアクセスをルーティングする
  - ALBは登録されたドメインのサブドメインをそれぞれのサイトの識別子として利用する

#### TODO:
- プロビジョニングのためのSSH接続をどう用意するか要検討
  - AWS Bastion的な踏み台を設置して、そこから作業を行う（妥当、課題要件を満たせるか不明
  - 全てのEC2インスタンスにパブリックIPを用意しローカルからSSH接続する（妥当でない、おそらく課題要件的には問題なし

#### 2024/03/20追記
- おそらくのToBe
  - cloud-1環境に単一のALBがあり、複数のサイトにルーティングを行う
  - 1つのサイトがmodule化されており、moduleの宣言を増やすことで複数のサイトをデプロイできる
  - サブドメインを指定することでALBにルーティングが追加される

#### 参考情報
[aws\_instance | Resources | hashicorp/aws | Terraform Registry](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#ebs_block_device)
[【Terraform入門】AWSのVPCとEC2を構築してみる - ふにノート](https://kacfg.com/terraform-vpc-ec2/#Terraformtf)
[VPC - Terraformで構築するAWS](https://y-ohgi.com/introduction-terraform/handson/vpc/)
[How to Create Key Pair in AWS using Terraform in Right Way - CloudKatha](https://cloudkatha.com/how-to-create-key-pair-in-aws-using-terraform-in-right-way/)