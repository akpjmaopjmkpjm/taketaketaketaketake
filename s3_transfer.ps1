# 🔴【最重要】先頭にこの2行を必ず入れます
$env:AWS_DEFAULT_SIGN_VERSION="s3v4"
$env:AWS_USE_FIPS_ENDPOINT="false"
 
# 一時フォルダとzipのパスを定義
$tmpExtractDir = "C:\ProgramData\Amazon\CodeDeploy\deploy\tmp_extract"
$zipPath = "C:\ProgramData\Amazon\CodeDeploy\deploy\deploy.zip" # 💡 GitHub Actionsが作った名前に合わせます
 
# 古い一時ファイルがあれば削除
if (Test-Path $tmpExtractDir) { Remove-Item -Recurse -Force $tmpExtractDir }
if (Test-Path $zipPath) { Remove-Item -Force $zipPath }
 
# GitHub Actionsがアップロードした最新のzipをS3からダウンロード
aws s3api get-object --bucket "20260616-resi" --key "deploy.zip" $zipPath
 
# zipを解凍
Expand-Archive -Path $zipPath -DestinationPath $tmpExtractDir -Force
 
# 💡 解凍した中から「job_script.py」を本命の「C:\hhonbantest」へコピーして上書き配置
if (Test-Path "$tmpExtractDir\job_script.py") {
    if (-not (Test-Path "C:\hhonbantest")) { New-Item -ItemType Directory -Path "C:\hhonbantest" -Force }
    Copy-Item -Path "$tmpExtractDir\job_script.py" -Destination "C:\hhonbantest\job_script.py" -Force
}

# 💡 もし別のS3バケットにもバックアップとして送りたい場合は、下の行のコメントアウト(#)を外してください
# aws s3 cp "$tmpExtractDir\job_script.py" "s3://vc-codedeploy-ceptest/job_script.py"
 
# 後片付け
Remove-Item -Recurse -Force $tmpExtractDir
Remove-Item -Force $zipPath