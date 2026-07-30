# 🔴【最重要】自動実行時のエラーを防ぐ設定
$env:AWS_DEFAULT_SIGN_VERSION="s3v4"
$env:AWS_USE_FIPS_ENDPOINT="false"

# 💡 失敗時にCodeDeployを強制停止させるための設定
$ErrorActionPreference = "Stop"

Write-Output "--- S3間 zip転送処理を開始します ---"

# 💡 EC2内に落とさず、仮置きS3から本命S3へ直接「バケット間コピー」を敢行します
# ⚠️ 内部エラーが発生した場合、このコマンドが即座にCodeDeployを「失敗」させてエラーログを残します
& "C:\Program Files\Amazon\AWSCLIV2\aws.exe" s3 cp "s3://20260616-resi/deploy.zip" "s3://hhonbantest/deploy.zip"

Write-Output "--- 転送処理が正常に完了しました ---"