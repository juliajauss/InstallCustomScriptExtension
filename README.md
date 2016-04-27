You want to install something on your Windows VM on Azure using a Custom Script Extension via Powershell? Here is how you can do it!

I wanted to install the AzCopy (Windows command-line utility designed for copying data to and from Microsoft Azure Blob, File, and Table storage using simple commands with optimal performance) Tool on my Windows Server VM. To do so, I uploaded a Powershell script to my Storage Account that downloads and installs AzCopy.

This script should be executed on my Windows Server VM using Custom Script Extension. Therefore, I wrote and executed this Powershell script on my local Machine. The most important command is this one, which grabs your VM and sets the CustomScriptExtension by providing the location of your custom script and tells your VM to run this script.

Get-AzureRmVM -Name $myVM.Name -ResourceGroupName $rg.ResourceGroupName |
Set-AzureRmVMCustomScriptExtension -Name "MyCSETest" -VMName $myVM.Name -ResourceGroupName $rg.ResourceGroupName -StorageAccountName $storageAccount.StorageAccountName -StorageAccountKey $storageAccountKey.Key1 -ContainerName $storageContainer -FileName $fileName -Run $fileName

The other lines are just basics, like logging in to Azure and selecting the Subscription you want to work in; selecting the Resource Group of your VM; selecting the VM you want to attach the Custom Script Extension; the Storage Account and Container which contains the custom script and its file name.

After running this script, AzCopy (or any other tool you want to install) is installed on your Windows VM
