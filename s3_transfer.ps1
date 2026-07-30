# 🔴【最重要】自動実行時のエラーを防ぐ設定
$env:AWS_DEFAULT_SIGN_VERSION="s3v4"
$env:AWS_USE_FIPS_ENDPOINT="false"

# 💡 失敗時にCodeDeployを確実に「失敗」にしてログを残す設定
$ErrorActionPreference = "Stop"

# 一時フォルダとzipのパス定義
$tmpExtractDir = "C:\ProgramData\Amazon\CodeDeploy\deploy\tmp_extract"
$zipPath = "C:\ProgramData\Amazon\CodeDeploy\deploy\deploy.zip"

# 古い一時ファイルがあれば削除
if (Test-Path $tmpExtractDir) { Remove-Item -Recurse -Force $tmpExtractDir }
if (Test-Path $zipPath) { Remove-Item -Force $zipPath }

Write-Output "--- S3からzipをダウンロードします ---"
# 1. 仮置き用S3からzipをダウンロード
& "C:\Program Files\Amazon\AWSCLIV2\aws.exe" s3api get-object --bucket "20260616-resi" --key "deploy.zip" $zipPath

Write-Output "--- zipを解凍します ---"
# 2. zipを解凍
Expand-Archive -Path $zipPath -DestinationPath $tmpExtractDir -Force

Write-Output "--- 本命のS3（20260616-send）へ .py ファイルを転送します ---"
# 3. 💡【検証】解凍した中にある job_script.py だけを 20260616-send バケットへ格納！
& "C:\Program Files\Amazon\AWSCLIV2\aws.exe" s3 cp "$tmpExtractDir\job_script.py" "s3://20260616-send/job_script.py"

# 後片付け
Remove-Item -Recurse -Force $tmpExtractDir -ErrorAction SilentlyContinue
Remove-Item -Force $zipPath -ErrorAction SilentlyContinue

Write-Output "--- すべての処理が正常に完了しました ---"