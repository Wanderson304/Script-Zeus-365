


Import-Module C:\Script-Zeus\Modulos\configurador.ps1

#Home

   menu-zeus 
   Write-Host "                                                                                            $Versao " -ForegroundColor Yellow             
   Write-Host 
   Write-Host "Olá $Env:UserName, Bem-vindo ao Script Zeus 365 !!!" -ForegroundColor Yellow
   Write-Host 
   Write-Host "Um momento, logo o menu será exibido ! " -ForegroundColor Yellow
   Write-Host 

   #Animação espera
   animacao_espera

   Start-Sleep -Seconds 10
   clear-host


   #Menu principal
   Show-Menu



function escolha-menu-principal {
    param (
        [int]$choice
    )

    switch ($choice) {
        1 {
           
            #menu-sharepoint
            #modulo_sharepoint
            
            start powershell {..\Modulos\menu_sharepoint.ps1} 
            exit
            
        }
        2 {
            #menu-exchange-on-line
            mod_em_construcao

        }
        3 {
            #Aviso de modulo em desenvolvimento
            mod_em_construcao 
            
        }
        4 {
            #Aviso de modulo em desenvolvimento
            mod_em_construcao 
            
        }
        5 {
            #Aviso de modulo em desenvolvimento
            mod_em_construcao 
            
        }
        6 {
            #Aviso de modulo em desenvolvimento
            mod_em_construcao 
            
        }
        7 {
            #Aviso de modulo em desenvolvimento
            mod_em_construcao 
            
        }
        8 {
            #Aviso de modulo em desenvolvimento
            mod_em_construcao 
            
        }

        23 {
            #Sobre
            Clear-Host
            Write-Host 
            menu-zeus-sobre

  
        }

        22 {
            #Eula
            Clear-Host
            Show-Menu 
            Write-Host 
            Write-Host 
            Write-Host "Um momento, estamos abrindo a eula em seu navegador ..."
            Start-Sleep -Seconds 10

            Start https://www.termsfeed.com/live/5829c50d-30e0-4eed-ac0b-bcc3d5f23d91
            Clear-Host
            Show-Menu 
            
        }
        21 {
            
            #Ajuda no github
            Clear-Host
            ajuda
            
        }

        20 {
            #opção sair
            Clear-Host
            exit
            Stop-Process -Name "powershell" -Force 
        }
        Default {
            Write-Host "`nOpção inválida. Tente novamente." -ForegroundColor Red
        }
    }
}

# Loop para o menu
do {
    Show-Menu
    Write-Host " " 
    $choice = Read-Host "Escolha um número em seguida aperte Enter" 
    escolha-menu-principal -choice $choice

    Clear-Host

    Show-Menu
    Write-Host " " 

    Write-Host "`Você precisar escolha uma opção..." -ForegroundColor Yello
    Write-Host "`Aperte enter para recarregar menu..." -ForegroundColor Yello
    Write-Host " "
   

    Read-Host
} while ($true)




