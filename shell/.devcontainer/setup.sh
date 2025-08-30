#!/bin/bash

# Post-create setup script for shell scripting practice environment

set -e

echo "🚀 Setting up Shell Scripting Practice Environment..."

# Make all scripts executable
find /workspace -name "*.sh" -exec chmod +x {} \;
find /workspace -name "*.zsh" -exec chmod +x {} \;
find /workspace -name "*.ps1" -exec chmod +x {} \; 2>/dev/null || true

# Install additional shell utilities
echo "📦 Installing additional utilities..."

# Install bats-core for better testing
if ! command -v bats &> /dev/null; then
    echo "Installing bats-core..."
    git clone https://github.com/bats-core/bats-core.git /tmp/bats-core
    cd /tmp/bats-core
    sudo ./install.sh /usr/local
    rm -rf /tmp/bats-core
fi

# Set up shell-specific configurations
echo "🔧 Configuring shells..."

# Zsh configuration
cat >> ~/.zshrc << 'EOF'

# Shell Practice Environment Configuration
export SHELL_PRACTICE_HOME="/workspace"
export PATH="$SHELL_PRACTICE_HOME/scripts:$PATH"

# Useful aliases for shell scripting
alias sp="cd $SHELL_PRACTICE_HOME"
alias spt="cd $SHELL_PRACTICE_HOME && ./scripts/build-and-test.sh"
alias spc="cd $SHELL_PRACTICE_HOME/concepts"
alias sptest="cd $SHELL_PRACTICE_HOME/tests"

# Shell-specific prompt indicator
export PS1="%F{green}[zsh]%f $PS1"
EOF

# Bash configuration
cat >> ~/.bashrc << 'EOF'

# Shell Practice Environment Configuration
export SHELL_PRACTICE_HOME="/workspace"
export PATH="$SHELL_PRACTICE_HOME/scripts:$PATH"

# Useful aliases for shell scripting
alias sp="cd $SHELL_PRACTICE_HOME"
alias spt="cd $SHELL_PRACTICE_HOME && ./scripts/build-and-test.sh"
alias spc="cd $SHELL_PRACTICE_HOME/concepts"
alias sptest="cd $SHELL_PRACTICE_HOME/tests"

# Shell-specific prompt indicator
export PS1="[bash] $PS1"
EOF

# Create shell environment testing script
cat > /workspace/scripts/test-shells.sh << 'EOF'
#!/bin/bash

# Test script to verify all shell environments work

echo "=== Testing Shell Environments ==="

# Test bash
echo "Testing bash..."
bash -c 'echo "✓ Bash version: $BASH_VERSION"'

# Test zsh
echo "Testing zsh..."
zsh -c 'echo "✓ Zsh version: $ZSH_VERSION"'

# Test dash
echo "Testing dash..."
dash -c 'echo "✓ Dash available"'

# Test PowerShell (if available)
if command -v pwsh &> /dev/null; then
    echo "Testing PowerShell..."
    pwsh -c 'Write-Host "✓ PowerShell version: $($PSVersionTable.PSVersion)"'
else
    echo "⚠️  PowerShell not available"
fi

# Test shellcheck
if command -v shellcheck &> /dev/null; then
    echo "✓ ShellCheck available: $(shellcheck --version | head -1)"
else
    echo "⚠️  ShellCheck not available"
fi

# Test bats
if command -v bats &> /dev/null; then
    echo "✓ Bats available: $(bats --version)"
else
    echo "⚠️  Bats not available"
fi

echo "=== Shell Environment Test Complete ==="
EOF

chmod +x /workspace/scripts/test-shells.sh

# Create shell-specific example scripts
echo "📝 Creating shell-specific examples..."

# Create a zsh-specific concept
cat > /workspace/concepts/zsh_features.zsh << 'EOF'
#!/bin/zsh

# Zsh-specific features demonstration
# This script showcases features unique to zsh

# Zsh array features
demonstrate_zsh_arrays() {
    echo "=== Zsh Array Features ==="
    
    # Zsh arrays are 1-indexed by default
    local -a fruits=(apple banana cherry)
    
    echo "Array contents: ${fruits[*]}"
    echo "First element: ${fruits[1]}"  # Note: 1-indexed!
    echo "Last element: ${fruits[-1]}"
    echo "Array length: ${#fruits}"
    
    # Zsh supports associative arrays
    typeset -A colors
    colors[red]="#FF0000"
    colors[green]="#00FF00"
    colors[blue]="#0000FF"
    
    echo "Colors:"
    for color in ${(k)colors}; do
        echo "  $color: ${colors[$color]}"
    done
}

# Zsh parameter expansion features
demonstrate_zsh_expansions() {
    echo "=== Zsh Parameter Expansions ==="
    
    local text="Hello World"
    
    echo "Original: $text"
    echo "Uppercase: ${(U)text}"
    echo "Lowercase: ${(L)text}"
    echo "Length: ${#text}"
    echo "Words: ${(w)text}"
}

# Zsh globbing features
demonstrate_zsh_globbing() {
    echo "=== Zsh Globbing Features ==="
    
    # Create some test files
    mkdir -p /tmp/zsh-test
    touch /tmp/zsh-test/{file1.txt,file2.log,script.sh,readme.md}
    
    echo "All files in /tmp/zsh-test:"
    echo ${~"/tmp/zsh-test/*"}
    
    echo "Only .txt files:"
    echo /tmp/zsh-test/*.txt(N)  # (N) prevents error if no matches
    
    # Cleanup
    rm -rf /tmp/zsh-test
}

# Main function
main() {
    echo "Zsh version: $ZSH_VERSION"
    echo
    
    demonstrate_zsh_arrays
    echo
    
    demonstrate_zsh_expansions
    echo
    
    demonstrate_zsh_globbing
}

# Only run main if script is executed directly
if [[ "${ZSH_EVAL_CONTEXT}" == "toplevel" ]]; then
    main "$@"
fi
EOF

chmod +x /workspace/concepts/zsh_features.zsh

# Create a PowerShell concept
cat > /workspace/concepts/powershell_basics.ps1 << 'EOF'
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
EOF

chmod +x /workspace/concepts/powershell_basics.ps1

echo "✅ Shell Scripting Practice Environment setup complete!"
echo ""
echo "Available commands:"
echo "  sp      - Change to practice directory"
echo "  spt     - Run build and test script"
echo "  spc     - Change to concepts directory" 
echo "  sptest  - Change to tests directory"
echo ""
echo "Test your environment with: ./scripts/test-shells.sh"
