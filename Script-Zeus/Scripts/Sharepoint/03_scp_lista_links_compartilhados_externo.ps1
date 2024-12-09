
#Relatório de links externos

Function Report_03_scp_lista_links_compartilhados_externo {


Param
(
    [Parameter(Mandatory = $false)]
    [Nullable[DateTime]]$StartDate,
    [Nullable[DateTime]]$EndDate,
    [switch]$SharePointOnline,
    [switch]$OneDrive,
    [string]$Organization,
    [string]$ClientId,
    [string]$CertificateThumbprint,
    [string]$AdminName,
    [string]$Password
)

$MaxStartDate=((Get-Date).AddDays(-180)).Date


#Retrive audit log for the past 90 days
if(($StartDate -eq $null) -and ($EndDate -eq $null))
{
 $EndDate=(Get-Date).Date
 $StartDate=$MaxStartDate
}
#Getting start date to audit export report
While($true)
{
 if ($StartDate -eq $null)
 {
  $StartDate=Read-Host Insira a data de início para geração do relatório '(Eg:12/15/2023)'
 }
 Try
 {
  $Date=[DateTime]$StartDate
  if($Date -ge $MaxStartDate)
  { 
   break
  }
  else
  {
   Write-Host `A auditoria só pode ser recuperada dos últimos 90 dias. Selecione uma data depois $MaxStartDate -ForegroundColor Red
   return
  }
 }
 Catch
 {
  Write-Host `Não é uma data válida -ForegroundColor Red
 }
}


#Getting end date to export audit report
While($true)
{
 if ($EndDate -eq $null)
 {
  $EndDate=Read-Host Insira o horário de término da geração do relatório '(Eg: 12/15/2023)'
 }
 Try
 {
  $Date=[DateTime]$EndDate
  if($EndDate -lt ($StartDate))
  {
   Write-Host O horário de término deve ser posterior ao horário de início -ForegroundColor Red
   return
  }
  break
 }
 Catch
 {
  Write-Host `Não é uma data válida -ForegroundColor Red
 }
}


Function Connect_Exo
{
 #Check for EXO module inatallation
 $Module = Get-Module ExchangeOnlineManagement -ListAvailable
 if($Module.count -eq 0) 
 { 
  Write-Host O módulo PowerShell do Exchange Online não está disponível  -ForegroundColor yellow  
  $Confirm= Read-Host Tem certeza de que deseja instalar o módulo? [S] Sim [N] Não
  if($Confirm -match "[yY]") 
  { 
   Write-host "Instalando o módulo PowerShell do Exchange Online"
   Install-Module ExchangeOnlineManagement -Repository PSGallery -AllowClobber -Force
  } 
  else 
  { 
   Write-Host O módulo EXO é necessário para conectar o Exchange Online. Instale o módulo usando o cmdlet Install-Module ExchangeOnlineManagement. 
   Exit
  }
 } 

 Write-Host " "
 Write-Host " "

 baner-meu-sharepoint
 Write-Host " " 
 Write-Host Faça login no SharePoint ou escolha sua conta caso já esteja conectado!
 Write-Host " " 
 Write-Host "Aguardando usuário fazer Login... " -ForegroundColor Yello

 Clear-Host
 baner-meu-sharepoint

 #Storing credential in script for scheduling purpose/ Passing credential as parameter - Authentication using non-MFA account
 if(($UserName -ne "") -and ($Password -ne ""))
 {
  $SecuredPassword = ConvertTo-SecureString -AsPlainText $Password -Force
  $Credential  = New-Object System.Management.Automation.PSCredential $UserName,$SecuredPassword
  Connect-ExchangeOnline -Credential $Credential -ShowBanner:$false
 }
 elseif($Organization -ne "" -and $ClientId -ne "" -and $CertificateThumbprint -ne "")
 {
   Connect-ExchangeOnline -AppId $ClientId -CertificateThumbprint $CertificateThumbprint  -Organization $Organization -ShowBanner:$false
 }
 else
 {
  Connect-ExchangeOnline -ShowBanner:$false
 }
}

$destinoExport_Report_links_shared_externo = "C:\Script-Zeus\ETL\01_crg_sharepoint\03_Report_lista_links_compartilhados_externo"


$Location=$destinoExport_Report_links_shared_externo
$OutputCSV="$Location\tbl_lista_links_compartilhados_externo.csv" 
$IntervalTimeInMinutes=1440    #$IntervalTimeInMinutes=Read-Host Enter interval time period '(in minutes)'
$CurrentStart=$StartDate
$CurrentEnd=$CurrentStart.AddMinutes($IntervalTimeInMinutes)

#Check whether CurrentEnd exceeds EndDate
if($CurrentEnd -gt $EndDate)
{
 $CurrentEnd=$EndDate
}

if($CurrentStart -eq $CurrentEnd)
{
 Write-Host Os horários de início e término são iguais. Insira um intervalo de tempo diferente -ForegroundColor Red
 Exit
}

Connect_EXO
$AggregateResults = @()
$CurrentResult= @()
$CurrentResultCount=0
$AggregateResultCount=0


Write-Host
Write-Host `Pesquisando links compartilhados externamente de $StartDate até $EndDate... -ForegroundColor Cyan
Write-Host

Write-Host "Isso pode demorar até 20 minutos..." -ForegroundColor Yello
Write-Host
Write-Host "ATENÇÃO: Evite fechar essa janela..." -ForegroundColor Red
Write-Host

animacao_espera

$ProcessedAuditCount=0
$OutputEvents=0
$ExportResult=""   
$ExportResults=@()  

while($true)
{ 
 #Getting exteranl sharing audit data for given time range
 $Results=Search-UnifiedAuditLog -StartDate $CurrentStart -EndDate $CurrentEnd -Operations "Sharinginvitationcreated,AnonymousLinkcreated,AddedToSecureLink" -SessionId s -SessionCommand ReturnLargeSet -ResultSize 5000
 $ResultCount=($Results | Measure-Object).count
 foreach($Result in $Results)
 {
  $ProcessedAuditCount++
  $MoreInfo=$Result.auditdata
  $Operation=$Result.Operations
  $AuditData=$Result.auditdata | ConvertFrom-Json
  $Workload=$AuditData.Workload

  #Filter for SharePointOnline external Sharing events
  If($SharePointOnline.IsPresent -and ($Workload -eq "OneDrive"))
  {
   continue
  }

  If($OneDrive.IsPresent -and ($Workload -eq "SharePoint"))
  {
   continue
  }
  
  #Check for Guest sharing
  if($Operation -ne "AnonymousLinkcreated")
  {
   If($AuditData.TargetUserOrGroupType -ne "Guest")
   {
    continue
   }
   $SharedWith=$AuditData.TargetUserOrGroupName
  }
  else
  {
   $SharedWith="Anyone with the link can access"
  }

  $ActivityTime=Get-Date($AuditData.CreationTime) -format g
  $SharedBy=$AuditData.userId
  $SharedResourceType=$AuditData.ItemType
  $sharedResource=$AuditData.ObjectId
  $SiteURL=$AuditData.SiteURL
  

  #Export result to csv
  $OutputEvents++
  $ExportResult=@{'Shared Time'=$ActivityTime;'Sharing Type'=$Operation;'Shared By'=$SharedBy;'Shared With'=$SharedWith;'Shared Resource Type'=$SharedResourceType;'Shared Resource'=$SharedResource;'Site url'=$Siteurl;'Workload'=$Workload;'More Info'=$MoreInfo}
  $ExportResults= New-Object PSObject -Property $ExportResult  
  $ExportResults | Select-Object 'Shared Time','Shared By','Shared With','Shared Resource Type','Shared Resource','Site URL','Sharing Type','Workload','More Info' | Export-Csv -Path $OutputCSV -Notype -Append 
 }

 #Write-Progress -Activity "`n     Retrieving external sharing events from $CurrentStart to $CurrentEnd.."`n" Processed audit record count: $ProcessedAuditCount"
 $currentResultCount=$CurrentResultCount+$ResultCount
 if($CurrentResultCount -ge 50000)
 {
  Write-Host Registro máximo recuperado para o intervalo atual. Prosseguir pode causar perda de dados ou executar novamente o script com intervalo de tempo reduzido. -ForegroundColor Red
  $Confirm=Read-Host Tem certeza de que deseja continuar? [S] Sim [N] Não
  if($Confirm -match "[Y]")
  {
   Write-Host Continuando a coleta de log de auditoria com perda de dados
   [DateTime]$CurrentStart=$CurrentEnd
   [DateTime]$CurrentEnd=$CurrentStart.AddMinutes($IntervalTimeInMinutes)
   $CurrentResultCount=0
   $CurrentResult = @()
   if($CurrentEnd -gt $EndDate)
   {
    $CurrentEnd=$EndDate
   }
  }
  else
  {
   Write-Host Execute novamente o script com intervalo de tempo reduzido -ForegroundColor Red
   Exit
  }
 }

 
 if($Results.count -lt 5000)
 {
  #$AggregateResultCount +=$CurrentResultCount
  if($CurrentEnd -eq $EndDate)
  {
   break
  }
  $CurrentStart=$CurrentEnd 
  if($CurrentStart -gt (Get-Date))
  {
   break
  }
  $CurrentEnd=$CurrentStart.AddMinutes($IntervalTimeInMinutes)
  $CurrentResultCount=0
  $CurrentResult = @()
  if($CurrentEnd -gt $EndDate)
  {
   $CurrentEnd=$EndDate
  }
 }
}

If($OutputEvents -eq 0)
{

 Write-Host "Não encotramos links externos em seu ambipat !!! "

 #Tratamento de erro quando o script não encontrar dados na nova pesquisa.
 cd "$destinoExport_Report_links_shared_externo"

 #Copia o arquivo para Stage e reescreve
 Copy-Item Stage\tbl_lista_links_compartilhados_externo.csv -Destination $lista_links_compartilhados_externo -Recurse
                         
 #Remove o antigo arquivo
 Remove-Item $lista_links_compartilhados_extern\Stage\tbl_lista_links_compartilhados_externo.csv -Force


}
else
{                        
                         Clear-Host
                         baner-meu-sharepoint
                         Write-Host " " 
                         Write-Host "Econtramos $OutputEvents links externos..." -ForegroundColor Yello
                         Write-Host " " 
}

#Disconnect Exchange Online session
#Disconnect-ExchangeOnline -Confirm:$false -InformationAction Ignore -ErrorAction SilentlyContinue

}