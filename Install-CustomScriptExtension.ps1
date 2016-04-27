Login-AzureRmAccount
Select-AzureRmSubscription -SubscriptionID "00dd302a-92a9-4ec6-a501-213b1bb1fad1"

#Select a Resource Group
$rg = (Get-AzureRmResourceGroup) |  Out-GridView -Title "Select a RG" -PassThru

#Select the VM to which the CSE should be added
$myVM = (Get-AzureRmVM -ResourceGroupName $rg.ResourceGroupName) |  Out-GridView -Title "Select a VM" -PassThru

#Get the Storage Account and Container where the CSE File lives
$storageAccount = (Get-AzureRmStorageAccount -ResourceGroupName $rg.ResourceGroupName) | Out-GridView -Title "Select a StorageAccount" -PassThru
$storageAccountKey = Get-AzureRmStorageAccountKey -ResourceGroupName $rg.ResourceGroupName -Name $storageAccount.StorageAccountName
$storageAccountContext = New-AzureStorageContext –StorageAccountName $storageAccount.StorageAccountName -StorageAccountKey $storageAccountKey.Key1
$storageContainer = (Get-AzureStorageContainer -Context $storageAccountContext).CloudBlobContainer.Name | Out-GridView -Title "Select a Container" -PassThru

#Specify the file Name of your CSE, e.g. Install-AzCopy.ps1
$fileName = "Install-AzCopy.ps1"

#Set the Custom Script Extension and run the Script
Get-AzureRmVM -Name $myVM.Name -ResourceGroupName $rg.ResourceGroupName | Set-AzureRmVMCustomScriptExtension -Name "MyCSETest" -VMName $myVM.Name -ResourceGroupName $rg.ResourceGroupName -StorageAccountName $storageAccount.StorageAccountName -StorageAccountKey $storageAccountKey.Key1 -ContainerName $storageContainer -FileName $fileName -Run $fileName #| Update-AzureRmVM

#Finished! Your script should have been executed on your VM :) 