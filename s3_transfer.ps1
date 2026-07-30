# 🔴【最重要】自動実行時のエラーを防ぐ設定
$env:AWS_DEFAULT_SIGN_VERSION="s3v4"
$env:AWS_USE_FIPS_ENDPOINT="false"

# 💡 失敗時にCodeDeployを確実に「失敗」にしてログを残す設定
$ErrorActionPreference = "Stop"

Write-Output "--- S3間 zip転送処理を開始します（送信先: 20260616-send） ---"

# 💡 仮置き場（20260616-resi）から、新しい最終目的地（20260616-send）へ直接コピー
& "C:\Program Files\Amazon\AWSCLIV2\aws.exe" s3 cp "s3://20260616-resi/deploy.zip" "s3://20260616-send/deploy.zip"

Write-Output "--- 転送処理が正常に完了しました ---"