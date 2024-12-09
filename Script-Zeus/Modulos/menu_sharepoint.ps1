

        Import-Module C:\Script-Zeus\Modulos\configurador.ps1
        Import-Module ..\Scripts\Sharepoint\03_scp_lista_links_compartilhados_externo.ps1
        Import-Module ..\Scripts\Sharepoint\04_scp_todos_usuarios_externos.ps1 

        #==================================================================================

        function mostarDominio {

                $DiminioDisplay = $dominio.ToUpper()
                Write-Host  "Doinio logado: $DiminioDisplay" -ForegroundColor Gree
                Write-Host  "Usuário logado: $Env:UserName"   -ForegroundColor Gree
                Write-Host  "Versão do módulo: VS.1.0"   -ForegroundColor Gree


                }

        #==================================================================================
                        

        #Conexão

        clear-Host

        baner-meu-sharepoint

        Write-Host "Um momento! Vamos conectar você ao SharePoint" -ForegroundColor Yello 
        Write-Host " " 
        Write-Host "ATENÇÃO: Você precisa de uma das funções abaixo, para ter permissão de extrair os relatórios!" -ForegroundColor Yello 
        Write-Host " " 
        Write-Host " - Administrador Global do Microsoft 365" -ForegroundColor Red
        Write-Host " - Administrador do Microsoft SharePoint" -ForegroundColor Red
        Write-Host " " 

        #Animação espera
        animacao_espera
        Clear-Host

        baner-meu-sharepoint

        Write-Host " " 
        Write-Host "Digite o dominio da sua organização sem o sufixo .com, .br ou qualque outro sufixo " -ForegroundColor Yello
        Write-Host "Exemplo: se o seu dominio é bradesco.com então digite apenas bradesco" -ForegroundColor Yello
        Write-Host " " 

        Write-Host "Para cada relatório escolhido será exibida uma tela de login" -ForegroundColor Yello
        Write-Host "Faça a entrada com seu e-mail e senha ou selecione sua conta caso já esteja conectado" -ForegroundColor Yello
        Write-Host " " 
        Write-Host "ATENÇÃO: Se você digitar um dominio que não exiete o relatório não será gerado !!!" -ForegroundColor Red
        Write-Host " " 

        $dominio = Read-Host "Digite o dominio da sua organização"
        $UrlLogin = "https://$dominio-admin.sharepoint.com" 

        Clear-Host

        #menu sharepoint
        menu-sharepoint

        function escolha-menu-sharepoint{
  
          param (
                [int]$choice
            )

            switch ($choice) {
                1 {
                     #Exportar para CSV todos os sites do SharePoint

                     #Caminho de exportação
                     $destinoExport_Report_todos_os_sites = "C:\Script-Zeus\ETL\01_crg_sharepoint\01_Report_todos_os_sites"

                     #Remove o antigo arquivo
                     Remove-Item $destinoExport_Report_todos_os_sites\tbl_sharepoint_todos_os_sites.csv -Force
      
                     Clear-Host
                     baner-meu-sharepoint
                     mostarDominio

                     #Todos os sites do SharePoint
                     Connect-SPOService -url https://$dominio-admin.sharepoint.com
                     Get-SPOSite -Detailed | Export-CSV -LiteralPath $destinoExport_Report_todos_os_sites\tbl_sharepoint_todos_os_sites.csv -NoTypeInformation -Encoding UTF8 
             
                     Clear-Host
                     menu-sharepoint
                     mostarDominio
                     Write-Host " " 

                     Write-Host " " 
                     Write-Host "Um momento estamos gerando seu relatório..." -ForegroundColor Yello
                     Write-Host " " 

                     Start-Sleep -Seconds 10
			         Write-Host " " 
                     animacao_espera

                     Clear-Host
                     menu-sharepoint
                     mostarDominio

                     Write-Host " " 
                     Write-Host "Relatório gerado... Ele será exibido em 10 segundos!" -ForegroundColor Yello

                     Write-Host " " 
                     Start-Sleep -Seconds 10
                     Write-Host " " 
                     animacao_espera

                     start $destinoExport_Report_todos_os_sites\Report_todos_os_sites.xlsm
                     menu-sharepoint

            
                }
                2 {

                     #Listar sites que estão com compartilhamento externo habilitados

                     #Caminho de exportação
                     $destinoExport_Report_shared_externo_habilitado = "C:\Script-Zeus\ETL\01_crg_sharepoint\02_Report_shared_externo_habilitado"

                     #Remove o antigo arquivo
                     Remove-Item $destinoExport_Report_shared_externo_habilitado\tbl_shared_externo_habilitado.csv -Force
                     
                     Clear-Host
                     baner-meu-sharepoint
                     mostarDominio

                     #Todos os sites do SharePoint
                     Connect-SPOService -url https://$dominio-admin.sharepoint.com

                     Get-SPOSite | Select-object Title, url,Status, Owner, sharingcapability | Export-CSV -LiteralPath $destinoExport_Report_shared_externo_habilitado\tbl_shared_externo_habilitado.csv -NoTypeInformation -Encoding UTF8

                     Clear-Host
                     menu-sharepoint
                     mostarDominio
                     Write-Host " " 

                     Write-Host " " 
                     Write-Host "Um momento estamos gerando seu relatório..." -ForegroundColor Yello
                     Write-Host " " 

                     Start-Sleep -Seconds 10
			         Write-Host " " 
                     animacao_espera

                     Clear-Host
                     menu-sharepoint
                     mostarDominio

                     Write-Host " " 
                     Write-Host "Relatório gerado... Ele será exibido em 10 segundos!" -ForegroundColor Yello

                     Write-Host " " 
                     Start-Sleep -Seconds 10
                     Write-Host " " 
                     animacao_espera


                     start $destinoExport_Report_shared_externo_habilitado\Report_shared_externo_habilitado.xlsm
                     menu-sharepoint
                     mostarDominio
                     Write-Host " " 
             
            
                }
        
                3 {
                     #Lista Link compartilhado - com pessoas externas

                     #O Script que executa esse relatório está localizado em 
                     #C:\Users\WandersonSilva\OneDrive - Bravo GRC\Negocios\WeS Operacional\Departamentos\T.I\Projetos interno Wes Tech\Script-Zeus\01 - Dev\Scripts\Sharepoint\03_scp_lista_links_compartilhados_externo.ps1
             

                     Clear-Host
                     baner-meu-sharepoint
                     mostarDominio

                     Write-Host " " 
                     Write-Host "Essa opção gera um relatório dos últimos 180 dias com todos os links compartilhados do Sharepoint com pessoas externas." -ForegroundColor Yello
                     Write-Host "A geração desse relatório pode demorar até 1 (Uma)  hora. Evite fechar essa janela" -ForegroundColor Yello
                     Write-Host "Se janela for fechada, o relatório será gerado propocinal ao tempo de execução ou telvez não seja gerado." -ForegroundColor Yello
                     Write-Host " "


                     Write-Host "1 - Continuar" -ForegroundColor Green
                     Write-Host "2 - Cancelar"  -ForegroundColor Red
                     Write-Host " " 

                     $escolha_gerar_report_3 =  Read-Host "Escolha um número em seguida aperte Ente"

                     Switch ($escolha_gerar_report_3) {
             

                        1 {

                                 Clear-Host
                                 baner-meu-sharepoint
                                 mostarDominio

                                 #Caminho do relatório
                                 $lista_links_compartilhados_extern = "C:\Script-Zeus\ETL\01_crg_sharepoint\03_Report_lista_links_compartilhados_externo"

                                 cd $lista_links_compartilhados_extern

                                 #Copia o arquivo para Stage e reescreve
                                 Copy-Item .\tbl_lista_links_compartilhados_externo.csv -Destination .\Stage -Recurse
                         
                                 #Remove o antigo arquivo
                                 Remove-Item $lista_links_compartilhados_extern\tbl_lista_links_compartilhados_externo.csv -Force

                                 Report_03_scp_lista_links_compartilhados_externo
                         

                                 Write-Host " " 
                                 Write-Host "Um momento estamos gerando seu relatório..." -ForegroundColor Yello
                                 Write-Host " " 

                                 Start-Sleep -Seconds 10
			                     Write-Host " " 
                                 animacao_espera

                                 Clear-Host
                                 baner-meu-sharepoint
                                 mostarDominio

                                 Write-Host " " 
                                 Write-Host "Relatório gerado... Ele será exibido em 20 segundos!" -ForegroundColor Yello

                                 Write-Host " " 
                                 Start-Sleep -Seconds 10
                                 Write-Host " " 
                                 animacao_espera

                         
                                 start $lista_links_compartilhados_extern\Report_lista_links_compartilhados_extern.xlsm

                                 cle
                                 menu-sharepoint
                                 mostarDominio
                
                        }

                        2 {
                                Clear-Host
                                baner-meu-sharepoint 
                                mostarDominio

                                Write-Host " " 
                                Write-Host "Operação cancelada pelo usuário!" -ForegroundColor Red
                                Write-Host " " 
                                Write-Host "Recaregando Menu " -ForegroundColor Yello
                                Write-Host " " 
                                animacao_espera
                                menu-sharepoint
                                mostarDominio
                    
                        }

                            Default {
                                Clear-Host
                                baner-meu-sharepoint 
                                mostarDominio

                                Write-Host " " 
                                Write-Host "Opção inválida! Você precisa digitar o número 1 ou 2." -ForegroundColor Red
                                Write-Host "Recaregando Menu " -ForegroundColor Yello
                                Write-Host " " 
                                animacao_espera
                                menu-sharepoint
                                mostarDominio

                        }
             
             
             
                     }


            

                }
                4 {
                                #Todos os usuários do Sharepoint
                                
                                 Clear-Host
                                 baner-meu-sharepoint
                                 mostarDominio

                                 #Caminho do relatório
                                 $destinoExport_Report_todos_usuarios_externos  = "C:\Script-Zeus\ETL\01_crg_sharepoint\04_Report_todos_usuarios_externos"
                         
                                 #Remove o antigo arquivo
                                 Remove-Item $destinoExport_Report_todos_usuarios_externos\tbl_todos_usuarios_externos.csv -Force

                                 Clear-Host
                                 baner-meu-sharepoint
                                 mostarDominio

                                 report_todos_usuarios_externos

                                 Write-Host " " 
                                 Write-Host "Um momento estamos gerando seu relatório..." -ForegroundColor Yello
                                 Write-Host " " 

                                 Start-Sleep -Seconds 10
			                     Write-Host " " 
                                 animacao_espera

                                 Clear-Host
                                 baner-meu-sharepoint
                                 mostarDominio

                                 Write-Host " " 
                                 Write-Host "Relatório gerado... Ele será exibido em 20 segundos!" -ForegroundColor Yello

                                 Write-Host " " 
                                 Start-Sleep -Seconds 10
                                 Write-Host " " 
                                 animacao_espera

                         
                                 start $destinoExport_Report_todos_usuarios_externos\Report_todos_usuarios_externos.xlsm

                                 Clear-Host
                                 menu-sharepoint                 
                                 mostarDominio

                }
                5 {
                    #Aviso de modulo em desenvolvimento
                    mod_em_construcao 
            
            
                }
                20 {
                    #opção sair
                    Clear-Host
                    exit
                    Stop-Process -Name "powershell" -Force 
                }
                 21 {
                    #Menu principal
                    start powershell {..\App\Home.ps1}
                    #Start-Sleep -Seconds 4
                    exit
                }
  

                Default {
                    Write-Host "`nOpção inválida. Tente novamente." -ForegroundColor Red
                }
            }
        }

        # Loop para o menu
        do {
            menu-sharepoint
            mostarDominio
            Write-Host " " 
            $choice = Read-Host "Escolha um número em seguida aperte Enter"
            escolha-menu-sharepoint -choice $choice
            Write-Host " "
            Write-Host "`Aperte Enter para recarregar o Menu..." -ForegroundColor Cyan
            Read-Host
        } while ($true)

