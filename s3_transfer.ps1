# 🔴【最重要】先頭にこの2行を必ず入れます
$env:AWS_DEFAULT_SIGN_VERSION="s3v4"
$env:AWS_USE_FIPS_ENDPOINT="false"
 
# 一時フォルダとzipのパスを定義（GitHub Actionsが書き出す「deploy.zip」に合わせます）
$tmpExtractDir = "C:\ProgramData\Amazon\CodeDeploy\deploy\tmp_extract"
$zipPath = "C:\ProgramData\Amazon\CodeDeploy\deploy\deploy.zip"
 
# 古い一時ファイルがあれば削除
if (Test-Path $tmpExtractDir) { Remove-Item -Recurse -Force $tmpExtractDir }
if (Test-Path $zipPath) { Remove-Item -Force $zipPath }
 
# 1. 💡【仮置き】GitHub Actionsがアップロードした最新の「deploy.zip」をS3（20260616-resi）からダウンロード
& "C:\Program Files\Amazon\AWSCLIV2\aws.exe" s3api get-object --bucket "20260616-resi" --key "deploy.zip" $zipPath
 
# 2. zipを解凍
Expand-Archive -Path $zipPath -DestinationPath $tmpExtractDir -Force
 
# 3. 💡【本命】解凍した中にある「job_script.py」を、目的のS3バケット「hhonbantest」へ格納！
& "C:\Program Files\Amazon\AWSCLIV2\aws.exe" s3 cp "$tmpExtractDir\job_script.py" "s3://hhonbantest/job_script.py"
 
# 後片付け
Remove-Item -Recurse -Force $tmpExtractDir
Remove-Item -Force $zipPath