# aws-vpc-terraform

開発環境

- terraform: 1.0.1
- IntelliJ IDEA + [HashiCorp Terraform / HCL language support](https://plugins.jetbrains.com/plugin/7808-hashicorp-terraform--hcl-language-support)

## VPCエンドポイントを含むVPCネットワークの構成(./vpc_endpoint)

- マルチAZとし、各AZにprivate/publicサブネットを1つずつ、合計4つのサブネットでVPCを構成した。
- ap-northeast-1a のpublicサブネットにWeb serverのインスタンスを配置した。
  - EC2 Instance ConnectあるいはSession Managerにより、SSH鍵なしで接続できることを確認した。
- ap-northeast-1c のprivateサブネットにInternal serverのインスタンスを配置した。
- Internal serverからインターネットにアクセスする場合、NATゲートウェイを経由する。
- NATゲートウェイを閉じた場合でも、VPCエンドポイントを使用して、他のAWSサービス(S3)にアクセスできることを確認した。

## VPC間にVPCピアリングを設定する(./vpc_peering)

- 2個のVPCを構成した。(main/sub)
- 各VPCにインターネットゲートウェイ、publicルートテーブルを設定した。
- VPCピアリングを設定することで、main/subのVPCに配置したインスタンスが相互に疎通できることを確認した。
