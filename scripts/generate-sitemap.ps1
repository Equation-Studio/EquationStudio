$ErrorActionPreference = "Stop"

$configPath = Join-Path $PSScriptRoot "sitemap.config.json"
$repoRoot = Split-Path $PSScriptRoot -Parent
$outputPath = Join-Path $repoRoot "sitemap.xml"

if (-not (Test-Path $configPath)) {
  throw "Missing config file: $configPath"
}

$config = Get-Content -Raw -Path $configPath | ConvertFrom-Json
$baseUrl = ($config.baseUrl).TrimEnd('/')
$lastmod = (Get-Date).ToString("yyyy-MM-dd")

$lines = @()
$lines += '<?xml version="1.0" encoding="UTF-8"?>'
$lines += '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">'

foreach ($page in $config.pages) {
  $path = [string]$page.path
  if ([string]::IsNullOrWhiteSpace($path)) {
    $loc = "$baseUrl/"
  }
  else {
    $loc = "$baseUrl/$($path.TrimStart('/'))"
  }

  $changefreq = [string]$page.changefreq
  $priority = [string]$page.priority

  $lines += '  <url>'
  $lines += "    <loc>$loc</loc>"
  $lines += "    <lastmod>$lastmod</lastmod>"
  $lines += "    <changefreq>$changefreq</changefreq>"
  $lines += "    <priority>$priority</priority>"
  $lines += '  </url>'
}

$lines += '</urlset>'

Set-Content -Path $outputPath -Value $lines -Encoding UTF8
Write-Host "sitemap.xml generated at $outputPath"
