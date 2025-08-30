#!/usr/bin/env pwsh

# Test file for PowerShell basics concept
# This file contains comprehensive tests for all functions
# defined in powershell_basics.ps1

# Test counter
$TestsRun = 0
$TestsPassed = 0

# Function to run a test
function Test-Assertion {
    param(
        [string]$TestName,
        [bool]$Condition
    )
    
    $script:TestsRun++
    
    if ($Condition) {
        Write-Host "✓ $TestName" -ForegroundColor Green
        $script:TestsPassed++
    } else {
        Write-Host "✗ $TestName" -ForegroundColor Red
    }
}

# Function to test that a command runs successfully
function Test-CommandSuccess {
    param(
        [string]$TestName,
        [scriptblock]$Command
    )
    
    $script:TestsRun++
    
    try {
        & $Command | Out-Null
        Write-Host "✓ $TestName" -ForegroundColor Green
        $script:TestsPassed++
    } catch {
        Write-Host "✗ $TestName" -ForegroundColor Red
        Write-Host "  Error: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# Import the PowerShell basics script
$ConceptsDir = Join-Path (Split-Path $PSScriptRoot) "concepts"
$PowerShellBasicsPath = Join-Path $ConceptsDir "powershell_basics.ps1"

# Test basic PowerShell functionality
function Test-PowerShellBasics {
    Write-Host "Testing PowerShell basics..."
    
    # Test basic variable operations
    $number = 42
    $string = "Hello PowerShell"
    $array = @(1, 2, 3, 4, 5)
    
    Test-Assertion "Number variable assignment" ($number -eq 42)
    Test-Assertion "String variable assignment" ($string -eq "Hello PowerShell")
    Test-Assertion "Array variable assignment" ($array.Length -eq 5)
    Test-Assertion "Array sum calculation" (($array | Measure-Object -Sum).Sum -eq 15)
    
    # Test string operations
    Test-Assertion "String length" ($string.Length -eq 16)
    Test-Assertion "String to uppercase" ($string.ToUpper() -eq "HELLO POWERSHELL")
    Test-Assertion "String contains" ($string.Contains("PowerShell"))
    
    # Test type checking
    Test-Assertion "Number is Int32" ($number.GetType().Name -eq "Int32")
    Test-Assertion "String is String" ($string.GetType().Name -eq "String")
    Test-Assertion "Array is Object[]" ($array.GetType().Name -eq "Object[]")
}

# Test PowerShell cmdlets
function Test-PowerShellCmdlets {
    Write-Host "Testing PowerShell cmdlets..."
    
    # Test Get-Process
    Test-CommandSuccess "Get-Process cmdlet" { Get-Process -Id $PID }
    
    # Test Get-ChildItem
    Test-CommandSuccess "Get-ChildItem cmdlet" { Get-ChildItem -Path /workspace -File | Select-Object -First 1 }
    
    # Test pipeline operations
    $processInfo = Get-Process -Id $PID
    Test-Assertion "Process name retrieval" ($processInfo.Name -eq "pwsh")
    Test-Assertion "Process ID verification" ($processInfo.Id -eq $PID)
}

# Test PowerShell objects and pipeline
function Test-PowerShellPipeline {
    Write-Host "Testing PowerShell pipeline..."
    
    # Create test data
    $testData = @(
        [PSCustomObject]@{Name="Alice"; Age=30; City="New York"}
        [PSCustomObject]@{Name="Bob"; Age=25; City="London"}
        [PSCustomObject]@{Name="Charlie"; Age=35; City="Tokyo"}
    )
    
    # Test filtering
    $adults = $testData | Where-Object {$_.Age -gt 25}
    Test-Assertion "Pipeline filtering" ($adults.Count -eq 2)
    Test-Assertion "Filtered data contains Alice" ($null -ne ($adults | Where-Object {$_.Name -eq "Alice"}))
    Test-Assertion "Filtered data contains Charlie" ($null -ne ($adults | Where-Object {$_.Name -eq "Charlie"}))
    
    # Test object properties
    $alice = $testData | Where-Object {$_.Name -eq "Alice"}
    Test-Assertion "Object property access - Name" ($alice.Name -eq "Alice")
    Test-Assertion "Object property access - Age" ($alice.Age -eq 30)
    Test-Assertion "Object property access - City" ($alice.City -eq "New York")
}

# Test file operations
function Test-FileOperations {
    Write-Host "Testing file operations..."
    
    # Test that the PowerShell basics script exists
    Test-Assertion "PowerShell basics script exists" (Test-Path $PowerShellBasicsPath)
    
    # Test current script exists
    Test-Assertion "Current test script exists" (Test-Path $PSCommandPath)
    
    # Test workspace directory exists
    Test-Assertion "Workspace directory exists" (Test-Path "/workspace")
}

# Main test function
function Main {
    Write-Host "=== Running PowerShell Basics Tests ===" -ForegroundColor Cyan
    Write-Host ""
    
    Test-PowerShellBasics
    Write-Host ""
    
    Test-PowerShellCmdlets
    Write-Host ""
    
    Test-PowerShellPipeline
    Write-Host ""
    
    Test-FileOperations
    Write-Host ""
    
    Write-Host "=== Test Summary ===" -ForegroundColor Cyan
    Write-Host "Tests run: $TestsRun"
    Write-Host "Tests passed: $TestsPassed"
    Write-Host "Tests failed: $($TestsRun - $TestsPassed)"
    
    if ($TestsPassed -eq $TestsRun) {
        Write-Host "All tests passed!" -ForegroundColor Green
        exit 0
    } else {
        Write-Host "Some tests failed!" -ForegroundColor Red
        exit 1
    }
}

# Run main function
Main
