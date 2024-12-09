
#Read more: https://www.sharepointdiary.com/2017/11/sharepoint-online-find-all-external-users-using-powershell.html#ixzz8tnV4gzbB


function report_todos_usuarios_externos {


#Template

#Import SharePoint Online Management Shell
Import-Module Microsoft.Online.Sharepoint.PowerShell -DisableNameChecking


$UrlLogin = "https://$dominio-admin.sharepoint.com" 

#Dominio em letras maiusculas
$DiminioUpper = $dominio.ToUpper()
 
#Config Parameters
$AdminSiteURL=$UrlLogin
$ReportOutput ="$destinoExport_Report_todos_usuarios_externos\tbl_todos_usuarios_externos.csv"
 
#Get Credentials to connect
#$Cred = Get-Credential
 
#Connect to SharePoint Online Tenant Admin
Connect-SPOService -URL $AdminSiteURL 
 
#Get All Site Collections
$SiteCollections  = Get-SPOSite -Limit All
 
#Iterate through each site collection and get external users

Write-host
Write-host "Um momento vamos iniciar a varredura de usuários externos no dominio" $DiminioUpper -ForegroundColor Yello
Write-host "Porem, isso pode demorar até 25 minutos" -ForegroundColor Yello
Write-host
Start-Sleep -Seconds 8

Foreach ($Site in $SiteCollections)

{   
    Clear-Host
    baner-meu-sharepoint
    mostarDominio
    Write-host

    Write-host "Pesquisando por usuários externos no dominio $DiminioUpper :" -ForegroundColor Yello

    Write-host
    animacao_espera
    Write-host

    #Write-host -f Green "Checking Site Collection:"$Site.URL
    Try {
        For ($x=0;;$x+=50) {
            $ExternalUsers += Get-SPOExternalUser -SiteUrl $Site.Url -Position $x -PageSize 50 -ErrorAction Stop | Select DisplayName,EMail,InvitedBy,AcceptedAs,WhenCreated,@{Name = "SiteUrl" ; Expression = {$Site.url}
        }
    }
}
catch {}
}
 
#Export the Data to CSV file
$ExternalUsers | Export-Csv -Path $ReportOutput -NoTypeInformation

}


