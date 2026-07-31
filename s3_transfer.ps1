$env:AWS_DEFAULT_SIGN_VERSION="s3v4"
$env:AWS_USE_FIPS_ENDPOINT="false"
$ErrorActionPreference = "Stop"

Write-Output "--- 20260616-send への運び出し処理を開始します ---"

# 💡 仮置き場（resi）から本命（send）へ直接コピーして運びます
& "C:\Program Files\Amazon\AWSCLIV2\aws.exe" s3 cp "s3://20260616-resi/deploy.zip" "s3://20260616-send/deploy.zip" 2>&1

Write-Output "--- 運び出しが正常に完了しました ---"