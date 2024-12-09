
Function 02_scp_shared_externo_habilitado {

             
               #Listar sites que estão com compartilhamento externo habilitados

             #Todos os sites do SharePoint
             Connect-SPOService -url https://$dominio-admin.sharepoint.com

             Get-SPOSite | Select-object Title, url,Status, Owner, sharingcapability | Export-CSV -LiteralPath $destinoExport_Report_shared_externo_habilitado\tbl_shared_externo_habilitado.csv -NoTypeInformation -Encoding UTF8

             Clear-Host
             menu-sharepoint

             Write-Host " " 
             Write-Host "Um momento estamos gerando seu relatório..." -ForegroundColor Yello
             Write-Host " " 

             Start-Sleep -Seconds 10
			 Write-Host " " 
             animacao_espera

             Clear-Host
             menu-sharepoint

             Write-Host " " 
             Write-Host "Relatório gerado... Ele será exibido em 10 segundos!" -ForegroundColor Yello

             Write-Host " " 
             Start-Sleep -Seconds 10
             Write-Host " " 
             animacao_espera

             02_scp_shared_externo_habilitado

             #Caminho de exportação
             $destinoExport_Report_shared_externo_habilitado = "C:\Users\WandersonSilva\OneDrive - Bravo GRC\Negocios\WeS Operacional\Departamentos\T.I\Projetos interno Wes Tech\Script-Zeus\01 - Dev\ETL\01_crg_sharepoint\02_Report_shared_externo_habilitado"

             start $destinoExport_Report_shared_externo_habilitado\Report_lista_links_compartilhados_extern.xlsm
             menu-sharepoint
             
        }
             