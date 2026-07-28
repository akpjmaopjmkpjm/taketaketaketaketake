# 🔴【最重要】先頭にこの2行を必ず入れます
$env:AWS_DEFAULT_SIGN_VERSION="s3v4"
$env:AWS_USE_FIPS_ENDPOINT="false"
 
# 以下、さっき手動で大成功したコードをそのまま並べます
$tmpExtractDir = "C:\ProgramData\Amazon\CodeDeploy\deploy\tmp_extract"
$zipPath = "C:\ProgramData\Amazon\CodeDeploy\deploy\giga2.zip"
 
if (Test-Path $tmpExtractDir) { Remove-Item -Recurse -Force $tmpExtractDir }
if (Test-Path $zipPath) { Remove-Item -Force $zipPath }
 
aws s3api get-object --bucket "d-spider-codedeployvc-test" --key "giga2.zip" $zipPath
Expand-Archive -Path $zipPath -DestinationPath $tmpExtractDir -Force
aws s3 cp "$tmpExtractDir\job_script.py" "s3://vc-codedeploy-ceptest/job_script.py"
Remove-Item -Recurse -Force $tmpExtractDir
Remove-Item -Force $zipPath