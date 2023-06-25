#### 動作確認
1. terraform, aws cliをインストールする
2. `aws configure`でAWS Consoleから発行した必要な権限を持ったアクセスキーを設定する
3. `terraform init`を実行
4. `make`実行、各リソースがawsにデプロイされる
5. `make ssh`でデプロイしたec2インスタンスにアクセスできることを確認

#### TODO
- (bonus)ec2を停止してもIPアドレスが変わらないようにelastic IPを使うように変更
- (bonus)作成したelastic IPへドメインが向くようにDNSを設定

#### 参考情報
[aws\_instance | Resources | hashicorp/aws | Terraform Registry](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#ebs_block_device)
[【Terraform入門】AWSのVPCとEC2を構築してみる - ふにノート](https://kacfg.com/terraform-vpc-ec2/#Terraformtf)
[VPC - Terraformで構築するAWS](https://y-ohgi.com/introduction-terraform/handson/vpc/)
[How to Create Key Pair in AWS using Terraform in Right Way - CloudKatha](https://cloudkatha.com/how-to-create-key-pair-in-aws-using-terraform-in-right-way/)