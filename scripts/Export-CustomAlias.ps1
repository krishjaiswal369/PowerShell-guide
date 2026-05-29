param(
    [string]$OutputPath = ".\custom_aliases.json"
)

Write-Host "Exporting current session aliases to $OutputPath..." -ForegroundColor Cyan

$aliases = Get-Alias | Select-Object Name, Definition, Source, Description
$aliasData = @()

foreach ($alias in $aliases) {
    $aliasData += [PSCustomObject]@{
        Alias = $alias.Name
        Cmdlet = $alias.Definition
        Source = $alias.Source
        Description = $alias.Description
    }
}

$aliasData | ConvertTo-Json -Depth 2 | Out-File -FilePath $OutputPath -Encoding UTF8

Write-Host "Export complete! Found $($aliasData.Count) aliases." -ForegroundColor Green
