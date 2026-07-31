# 🔴【変更】エラーをPowerShell単体でキャッチする構造にします
$env:AWS_DEFAULT_SIGN_VERSION="s3v4"
$env:AWS_USE_FIPS_ENDPOINT="false"

Write-Output "--- 転送処理を開始します ---"

try {
    # 💡 コマンドの出力を明示的に取得し、エラーも一緒に標準出力へ流します
    $awsCmd = "& 'C:\Program Files\Amazon\AWSCLIV2\aws.exe' s3 cp 's3://20260616-resi/deploy.zip' 's3://20260616-send/deploy.zip' 2>&1"
    $result = Invoke-Expression $awsCmd
    
    # 実行結果をログに強制出力
    Write-Output $result

    if ($LASTEXITCODE -ne 0) {
        throw "AWS CLI が終了コード $LASTEXITCODE で失敗しました。"
    }
    
    Write-Output "--- 転送処理が正常に終了しました ---"
}
catch {
    # 🔴【最重要】エラー内容を文字としてログに絶対残す記述
    Write-Output "🚨【重大エラー発生】スクリプト内部で以下の問題が発生しましたa："
    Write-Output $_.Exception.Message
    Write-Output $_.ScriptStackTrace
    exit 1
}