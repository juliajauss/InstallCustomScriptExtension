$url = "http://aka.ms/downloadazcopy"
$output = "D:\MicrosoftAzureStorageTools.msi"
Invoke-WebRequest -Uri $url -OutFile $output

Start-Process "D:\MicrosoftAzureStorageTools.msi"