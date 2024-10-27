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

#### 2024/03/20追記
- おそらくのToBe
  - cloud-1環境に単一のALBがあり、複数のサイトにルーティングを行う
  - 1つのサイトがmodule化されており、moduleの宣言を増やすことで複数のサイトをデプロイできる
  - サブドメインを指定することでALBにルーティングが追加される

#### 踏み台経由のansible実行
- TLSの実装でALB経由でパブリックからアクセスされるようになったため、ec2のパブリックIPアドレスは不要
- ansibleの実行にec2のパブリックIPを利用しているため、踏み台としてBastionをデプロイしてBastion経由でAnsibleを実行したい
- AWSには踏み台専用のサービスはないっぽいのでどーするか考える
- https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/session-manager-to-linux.html
- session managerを使うのが今時っぽい

#### session manager経由のssh接続
- https://zenn.dev/zenogawa/articles/ansible_aws_ssm
  - session managerからansible使う解説
- https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-getting-started-enable-ssh-connections.html
  - ansible/.ssh.configにリンクのconfigを配置
  - `ssh -i cloud-1-key-pair.pem -F ../ansible/.ssh.config ubuntu@i-03f9ae5e0a31e7fda`でssh接続できることを確認

### 使用しているツール
- aws cli
- session-manager-plugin
- terraform
- jq
- ansible


#### 参考情報
[aws\_instance | Resources | hashicorp/aws | Terraform Registry](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#ebs_block_device)
[【Terraform入門】AWSのVPCとEC2を構築してみる - ふにノート](https://kacfg.com/terraform-vpc-ec2/#Terraformtf)
[VPC - Terraformで構築するAWS](https://y-ohgi.com/introduction-terraform/handson/vpc/)
[How to Create Key Pair in AWS using Terraform in Right Way - CloudKatha](https://cloudkatha.com/how-to-create-key-pair-in-aws-using-terraform-in-right-way/)
[https化 - Terraformで構築するAWS](https://y-ohgi.com/introduction-terraform/handson/https/)
[インターネットにアクセスせずにプライベート EC2 インスタンスを管理する | AWS re:Post](https://repost.aws/ja/knowledge-center/ec2-systems-manager-vpc-endpoints)