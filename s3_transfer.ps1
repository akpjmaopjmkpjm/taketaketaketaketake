$env:AWS_DEFAULT_SIGN_VERSION="s3v4"
$env:AWS_USE_FIPS_ENDPOINT="false"

Write-Output "--- [Start] S3 Transfer Process ---"

# 🔴 `--no-progress` をつけることで、画面のフリーズを完全に防止します
& "C:\Program Files\Amazon\AWSCLIV2\aws.exe" s3 cp "s3://20260616-resi/deploy.zip" "s3://20260616-send/deploy.zip" --no-progress

if ($LASTEXITCODE -ne 0) {
    Write-Output "🚨 AWS CLI failed with exit code: $LASTEXITCODE"
    exit 1
}

Write-Output "--- [End] S3 Transfer Process Success ---11"