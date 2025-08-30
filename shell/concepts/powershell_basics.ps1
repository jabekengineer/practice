#!/usr/bin/env pwsh

# PowerShell basics demonstration
# This script showcases fundamental PowerShell concepts

# Function to demonstrate PowerShell objects
function Show-PowerShellObjects {
    Write-Host "=== PowerShell Object Features ===" -ForegroundColor Green
    
    # Everything in PowerShell is an object
    $number = 42
    $string = "Hello PowerShell"
    $array = @(1, 2, 3, 4, 5)
    
    Write-Host "Number type: $($number.GetType().Name)"
    Write-Host "String type: $($string.GetType().Name)"
    Write-Host "Array type: $($array.GetType().Name)"
    
    # Object methods
    Write-Host "String length: $($string.Length)"
    Write-Host "String uppercase: $($string.ToUpper())"
    Write-Host "Array sum: $(($array | Measure-Object -Sum).Sum)"
}

# Function to demonstrate PowerShell cmdlets
function Show-PowerShellCmdlets {
    Write-Host "=== PowerShell Cmdlets ===" -ForegroundColor Green
    
    # Get current process info
    $currentProcess = Get-Process -Id $PID
    Write-Host "Current process: $($currentProcess.Name)"
    Write-Host "Process ID: $($currentProcess.Id)"
    
    # Work with files and directories
    $files = Get-ChildItem -Path /workspace -File | Select-Object -First 5
    Write-Host "First 5 files in workspace:"
    $files | ForEach-Object { Write-Host "  $($_.Name)" }
}

# Function to demonstrate PowerShell pipeline
function Show-PowerShellPipeline {
    Write-Host "=== PowerShell Pipeline ===" -ForegroundColor Green
    
    # Create sample data
    $data = @(
        [PSCustomObject]@{Name="Alice"; Age=30; City="New York"}
        [PSCustomObject]@{Name="Bob"; Age=25; City="London"}
        [PSCustomObject]@{Name="Charlie"; Age=35; City="Tokyo"}
    )
    
    Write-Host "People over 25:"
    $data | Where-Object {$_.Age -gt 25} | ForEach-Object {
        Write-Host "  $($_.Name) ($($_.Age)) from $($_.City)"
    }
}

# Main execution
function Main {
    Write-Host "PowerShell version: $($PSVersionTable.PSVersion)" -ForegroundColor Cyan
    Write-Host ""
    
    Show-PowerShellObjects
    Write-Host ""
    
    Show-PowerShellCmdlets
    Write-Host ""
    
    Show-PowerShellPipeline
}

# Run main function
Main
