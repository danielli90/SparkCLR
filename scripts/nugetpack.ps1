# 
# http://www.codeproject.com/Tips/806257/Automating-NuGet-Package-Creation-using-AppVeyor
$root = (split-path -parent $MyInvocation.MyCommand.Definition) + '\..'
# $version = [System.Reflection.Assembly]::LoadFile("$root\MarkdownLog\bin\Release\MarkdownLog.dll").GetName().Version
# $versionStr = "{0}.{1}.{2}" -f ($version.Major, $version.Minor, $version.Build)
$versionStr = "1.0.{0}" -f ([Environment]::GetEnvironmentVariable("APPVEYOR_BUILD_NUMBER"))

Write-Host "Setting .nuspec version tag to $versionStr"

$content = (Get-Content $root\csharp\SparkCLR.nuspec)
$content = $content -replace '\$version\$',$versionStr

$content | Out-File $root\csharp\SparkCLR.compiled.nuspec

& $root\tools\NuGet.exe pack $root\csharp\SparkCLR.compiled.nuspec
