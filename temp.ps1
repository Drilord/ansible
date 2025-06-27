# Define Tailscale MSI URL and output path
$tailscale_msi_url = "https://pkgs.tailscale.com/stable/tailscale-setup-1.84.0-amd64.msi"
$output_directory = "C:\Temp"
$output_filename = "tailscale-setup-1.84.0-amd64.msi"
$output_path = Join-Path -Path $output_directory -ChildPath $output_filename

# Create the Temp directory if it doesn't exist
if (-not (Test-Path $output_directory)) {
    New-Item -ItemType Directory -Force -Path $output_directory
}

# Download Tailscale MSI
try {
    Write-Host "Downloading Tailscale from $tailscale_msi_url to $output_path"
    Invoke-WebRequest -Uri $tailscale_msi_url -OutFile $output_path -UseBasicParsing
    Write-Host "Download complete."
}
catch {
    Write-Error "Failed to download Tailscale MSI. Error: $($_.Exception.Message)"
    exit 1
}

# Install Tailscale silently
try {
    Write-Host "Installing Tailscale..."
    Start-Process msiexec.exe -ArgumentList "/i `"$output_path`" /qn /norestart" -Wait
    Write-Host "Tailscale installation command executed."
}
catch {
    Write-Error "Failed to start Tailscale installation. Error: $($_.Exception.Message)"
    exit 1
}

Write-Host "Tailscale installed. Please RDP in and run 'tailscale up' manually to authenticate."