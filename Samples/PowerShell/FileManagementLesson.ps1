#using out-file to create files from cmdlet output


Get-Process | Format-Table Name, Description | Out-File Proc1.txt
Get-Content Proc1.txt 

"Systems Checklist" | Out-File List.txt 
Get-Content List.txt

#Adding content to a file using Add-Content
Add-Content -Path Date.txt -Value (Get-Date)
Get-Content Date.txt

Add-Content -Path Private.txt -Value "Personal and Confidential"
Get-Content Private.txt

#adding file content using Set-Content
Set-Content -Path NewFile.txt -Value "This is a new file."
Get-Content NewFile.txt

#appending to a file
Get-Date | Out-File Date1.txt
"Above is the date information." | Out-File Date1.txt -Append
Get-Content Date1.txt

Add-Content -Path Date2.txt -Value (Get-Date)
"End of File" | Add-Content -path Date2.txt
Get-Content Date2.txt

"Some text" | Out-File text.txt
"Some more text" | Add-Content text.txt 
Get-Content text.txt

#encoding parameter
"ASCII encoding" | Out-File text.txt -Encoding ASCII 
"Unicode encoding" | Add-Content text.txt -Encoding Unicode
Get-Content text.txt

"ASCII encoding" | Out-File text.txt -Encoding ASCII
Get-Date | add-content text.txt 
Get-Content text.txt

Get-Date | Out-File text.txt -Append -Encoding ASCII
Get-Content text.txt

#Displaying content and files
Get-ChildItem

Get-ChildItem C:\

Get-ChildItem C:\ -Recurse

Get-ChildItem C:\w*

Get-Item C:\Windows

Get-Item 

#clearing file content

Set-Content -Path Budget.txt -Value "Budget file"
Get-Content Budget.txt

Clear-Content -Path Budget.txt
Get-Content -Path Budget.txt

Get-Item -Path Budget.txt
Get-Childitem Budget.txt

#deleting files
Set-Content -Path OldFile.txt -Value "This is an old file."
Get-ChildItem OldFile.txt

Remove-Item OldFile.txt
Get-ChildItem OldFile.txt

#using wildcards 
Set-Content -Path Blue.org -Value "This is the first file."
Set-Content -Path Yellow.net -Value "This is the second file."
Set-Content -Path Brown.net -Value "This is the third file."
Set-Content -Path Black.org -Value "This is the fourth file."

Get-ChildItem

Remove-Item B*.org

Get-ChildItem

#creating directories
New-Item -ItemType Directory -Path C:\Subdir1
Get-ChildItem C:\

#relative path
New-Item -ItemType Directory -Path Subdir2
Get-ChildItem

#copy, rename and move files
New-Item -ItemType Directory -Path C:\NewDir

"This is the file to be copied." | Out-File File2Copy.txt

Copy-Item -Path File2Copy.txt -Destination C:\NewDir
Get-ChildItem C:\NewDir

##
New-Item -ItemType Directory -Path C:\Test
"File to be copied and renamed." | Out-File Original.txt

Copy-Item -Path Original.txt -Destination C:\Test\NewVersion.txt
Get-ChildItem C:\Test

##
New-Item -ItemType Directory -Path C:\LogsBackup
Copy-Item -Path C:\Windows\*.log -Destination C:\LogsBackup

Get-ChildItem C:\LogsBackup

#moving files
New-Item -ItemType Directory -Path C:\NewLocation
"This is the file to be moved." | Out-File File2Move.txt
Get-ChildItem

Move-Item -Path File2Move.txt -Destination C:\NewLocation

Get-ChildItem
Get-ChildItem C:\NewLocation

#moving directories
New-Item -ItemType Directory -Path C:\MovedLogs
New-Item -ItemType Directory -Path C:\TempLogs
Copy-Item C:\Windows\*.log -Destination C:\TempLogs

Get-ChildItem C:\TempLogs
Get-ChildItem C:\MovedLogs

Move-Item -Path C:\TempLogs -Destination C:\MovedLogs

Get-ChildItem C:\TempLogs
Get-ChildItem C:\MovedLogs
Get-ChildItem C:\MovedLogs\TempLogs

#NTFS Alernative Data Streams
#Use a Web Browser to download this file
# https://download.sysinternals.com/files/SysinternalsSuite.zip

Get-Item $env:UserProfile\Downloads\SysinternalsSuite.zip	
Get-Item -stream * $env:UserProfile\Downloads\SysinternalsSuite.zip 

Invoke-WebRequest -Uri "https://download.sysinternals.com/files/SysinternalsSuite.zip" -OutFile $env:\UserProfile\Downloads\outfile.zip 

Get-Item -stream * $env:UserProfile\Downloads\outfile.zip

#reading stream content
Get-Content -Stream Zone.Identifier $env:UserProfile\Downloads\SysinternalsSuite.zip
 
#creating alternate data streams
$StreamData=Get-Content -Stream Zone.Identifier $Env:UserProfile\Downlaods\SysinternalsSuite.zip

Add-Content -Stream Zone.Identifier $Env:UserProfile\Downloads\outfile.zip -Value $StreamData

Get-Item -stream * $Env:UserProfile\Downloads\outfile.zip

Get-Content -Stream Zone.Identifier $Env:UserProfile\Downloads\outfile.zip

#deleting alternate data streams
Remove-Item -Stream Zone.Identifier $Env:Userprofile\Downloads\outfile.zip

Get-Item -stream * $Env:UserProfile\Downloads\outfile.zip

##String searching using Select-String
Get-Service | Out-File CurrentServices.txt
Get-Content CurrentServices.txt | select-string Windows

Get-Service | Out-File NewServices.txt
Get-Content NewServices.txt | select-string windows
Get-ChildItem NewServices.txt | select-string windows

Get-Service | Out-File ServiceUpdate.txt
Get-Content ServiceUpdate.txt | select-string Windows -CaseSensitive
Get-Content ServiceUpdate.txt | select-string windows -CaseSensitive

#working with csv files
Get-Service | Export-CSV Services.csv

Get-WMIObject Win32_SystemDriver | Select-Object -Property DisplayName, Status, PathName | Export-CSV Drivers.csv -NoTypeInformation

Import-Csv ServerInfo.csv

$ServerData = Import-Csv ServerInfo.csv
$ServerData | Get-Member
$ServerData | Select-Object "Server Name"