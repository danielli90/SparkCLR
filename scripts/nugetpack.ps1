# 
# http://www.codeproject.com/Tips/806257/Automating-NuGet-Package-Creation-using-AppVeyor
$root = (split-path -parent $MyInvocation.MyCommand.Definition) + '\..'
# $version = [System.Reflection.Assembly]::LoadFile("$root\MarkdownLog\bin\Release\MarkdownLog.dll").GetName().Version
# $versionStr = "{0}.{1}.{2}" -f ($version.Major, $version.Minor, $version.Build)
$versionStr = "1.4.{0}" -f ([Environment]::GetEnvironmentVariable("APPVEYOR_BUILD_NUMBER"))
# $versionStr = "{0}.{1}" -f ([Environment]::GetEnvironmentVariable("APPVEYOR_BUILD_VERSION"), [Environment]::GetEnvironmentVariable("APPVEYOR_BUILD_NUMBER"))
#
# Attempting to build package from 'SparkCLR.compiled.nuspec'.
# '1.4.1-SNAPSHOT.29.29' is not a valid version string.
# Parameter name: version
# NuGet package ok for C:\projects\sparkclr\csharp\SparkCLR.sln
# ===== Build succeeded for C:\projects\sparkclr\csharp

Write-Host "Setting .nuspec version tag to $versionStr"

$content = (Get-Content $root\csharp\SparkCLR.nuspec)
$content = $content -replace '\$version\$',$versionStr

$content | Out-File $root\csharp\SparkCLR.compiled.nuspec

& $root\tools\NuGet.exe pack $root\csharp\SparkCLR.compiled.nuspec
