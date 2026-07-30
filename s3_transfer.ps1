# 🔴【最重要】自動実行時のエラーを防ぐ設定
$env:AWS_DEFAULT_SIGN_VERSION="s3v4"
$env:AWS_USE_FIPS_ENDPOINT="false"
 
# zipを一時的に保存するローカルのパス定義
$zipPath = "C:\ProgramData\Amazon\CodeDeploy\deploy\deploy.zip"
 
# 古い一時ファイルが残っていれば削除
if (Test-Path $zipPath) { Remove-Item -Force $zipPath }
 
# 1. 💡【仮置き】GitHub Actionsがアップロードした最新の「deploy.zip」をS3からダウンロード
& "C:\Program Files\Amazon\AWSCLIV2\aws.exe" s3api get-object --bucket "20260616-resi" --key "deploy.zip" $zipPath
 
# 2. 💡【本命】ダウンロードした「deploy.zip」を、そのまま目的のS3バケット「hhonbantest」へ格納！
& "C:\Program Files\Amazon\AWSCLIV2\aws.exe" s3 cp $zipPath "s3://hhonbantest/deploy.zip"
 
# 後片付け（ローカルに残ったzipを消去）
Remove-Item -Force $zipPath