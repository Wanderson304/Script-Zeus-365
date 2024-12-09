

   #Instalação dos modulos
   #Este aquivo deve ser executado em modo administrador 
 
   
   Import-Module C:\Script-Zeus\Modulos\configurador.ps1
   #Recurso de animação 8bits
   Install-Module WriteAscii

   Clear-host

   function animacao_espera {

    $Symbols = [string[]]('||','||','||','||','||','||','||','||','||','||','||','||','||','||')
    $SymbolIndex = [byte] 0
    $Job = Start-Job -ScriptBlock { Start-Sleep -Seconds 2 }
    while ($Job.'JobStateInfo'.'State' -eq 'Running') {
    if ($SymbolIndex -ge $Symbols.'Count') {$SymbolIndex = [byte] 0}
    Write-Host -NoNewline -Object ("{0}`b" -f $Symbols[$SymbolIndex++])
    Start-Sleep -Milliseconds 100
     }
}

    function menu-modulos {

    Write-Host "==========================================================================================================" -ForegroundColor Cyan
    Write-Host "                            SCRIPT ZEUS 365 | INSTALAÇÃO DOS MODULOS DE GERENCIAMENTO" 
    Write-Host "==========================================================================================================" -ForegroundColor Cyan
    Write-Host 

}

    function menu-zeus {

    Clear-Host
    Write-Host "==========================================================================================================" -ForegroundColor Cyan
    Write-Ascii -InputObject '   SCRIPT ZEUS 365!' -ForegroundColor Yellow                                
    Write-Host "==========================================================================================================" -ForegroundColor Cyan
    Write-Host " " 
}

function decisaoUsuario {

    Write-Host "                                   ATENÇÃO!" -ForegroundColor Red
    Write-Host 

    #Habilitar apenas em produção
    #start https://www.termsfeed.com/live/0a04a902-ae30-419f-a232-876a4daeea3c
    Start https://learn.microsoft.com/pt-br/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7.4

    Write-Host "   $Env:UserName, esse Script não esta assinado. Devido a  protenção contra script maliciosos o POweshell"
    Write-Host "Não vai permitir a execução desse escript. Escolhendo a opção SIM vamos modificar a propriedade do "
    Write-Host "Set-ExecutionPolicy para Bypass. Após o uso do script você pode reativar as politicas padrão "
    Write-Host "Basta abrir o PowerShell em modo Administrador e executar o comando "Set-ExecutionPolicy Unrestricted" "
    Write-Host "Para saber mais sobre Execution_Policies veja o link que abrimos   em seu navegador"
   
    Write-Host ""
    Write-Host ""
    Write-Host "Você autoriza ajustarmos a propriedade ExecutionPolicy para Bypass ? "
    
    Write-Host ""
   
    Write-Host " 1 - Sim "  -ForegroundColor Yellow
    Write-Host " 2 - Não "  -ForegroundColor Yellow

    Write-Host ""
    Write-Host ""
    }


    function menu-modulos {

    Write-Host "==========================================================================================================" -ForegroundColor Cyan
    Write-Host "                            SCRIPT ZEUS 365 | INSTALAÇÃO DOS MODULOS DE GERENCIAMENTO" 
    Write-Host "==========================================================================================================" -ForegroundColor Cyan
    Write-Host 

}


    menu-zeus
    
    Write-Host "Olá $Env:UserName, Bem-vindo a tela de configuração do Script Zeus 365 !!!"
    Write-Host 
    Start-Sleep -Seconds 8
    clear-Host

    #Liberação de permissão do usuário - inicio

    menu-modulos

    decisaoUsuario

    function permitir{
    param (
        [int]$choice
    )

    switch ($choice) {
        1 {
                       
                        clear-Host
                        menu-zeus

                        Write-Host ""
                        #Desativar o Bypass:
                        Set-ExecutionPolicy  Bypass


                        Write-Host ""
                        Write-Host "Um momento, vamos instalar alguns modulos do Microsoft 365..." -ForegroundColor Yellow
                        Start-Sleep -Seconds 6
                        Write-Host ""

                        clear-Host
                        menu-zeus

                        Write-Host "Alterando a Set-ExecutionPolicy para Bypass..." -ForegroundColor Yellow
                        Start-Sleep -Seconds 6
                        Write-Host ""

                        clear-Host
                        menu-zeus

                        Write-Host ""
                        Write-Host "Instalando modulo MSOnline no perfil do usuário atual ( $Env:UserName ) ..." -ForegroundColor Yellow
                        Write-Host ""

                        #Botao Notificacao
                        Install-Module -Name BurntToast
                        Write-Host ""

                        #PowerShell mais atual:
                        #winget install --id Microsoft.PowerShell --source winget


                        #Animação espera
                        Write-Host ""
                        animacao_espera
                        Start-Sleep -Seconds 6
                        Write-Host " " 

                        #Instalação modulo MSOnline
                        Install-Module -Name MSOnline -Scope CurrentUser 
                        Import-Module -Name MSOnline 
                        clear-Host
                         
                        menu-modulos
                        Write-Host ""
                        Write-Host "Instalando modulo ExchangeOnlineManagement no perfil do usuário atual ( $Env:UserName ) ..." -ForegroundColor Yellow
   
                        #Animação espera
                        Write-Host ""
                        animacao_espera
                        Start-Sleep -Seconds 6
                        Write-Host " " 

                        #Instalação modulo AzureAD
                        Install-Module -Name AzureAD -Scope CurrentUser
                        Import-Module -Name AzureAD 
                        clear-Host	
			
			            menu-modulos
                        Write-Host ""
                        Write-Host "Instalando modulo AzureAD no perfil do usuário atual ( $Env:UserName ) ..." -ForegroundColor Yellow
			
			            #Animação espera
                        Write-Host ""
                        animacao_espera
                        Start-Sleep -Seconds 6
                        Write-Host " " 

                        #Instalação modulo ExchangeOnline
                        Install-Module -Name ExchangeOnlineManagement -Scope CurrentUser 
                        Import-Module ExchangeOnlineManagement 
                        #Update-Module -Name ExchangeOnlineManagement 
                        clear-Host

                        menu-modulos
                        Write-Host ""
                        Write-Host "Instalando modulo SharePoint no perfil do usuário atual ( $Env:UserName ) ..." -ForegroundColor Yellow
    
                        #Animação espera
                        Write-Host ""
                        animacao_espera
                        Start-Sleep -Seconds 6
                        Write-Host " " 

                        #Instalação do modulo SharePointOnline
                        Install-Module -Name Microsoft.Online.SharePoint.PowerShell -Scope CurrentUser -Force
                        Import-Module Microsoft.Online.Sharepoint.PowerShell
                        
                        Install-Module PnP.PowerShell -Force -AllowClobber -Scope CurrentUser -Force
                        Import-Module -Name PnP.PowerShell -Force

                        clear-Host
                        

                        menu-modulos
                        Write-Host ""
                        Write-Host "Instalando modulo Teams no perfil do usuário atual ( $Env:UserName ) ..." -ForegroundColor Yellow
    
                        #Animação espera
                        Write-Host ""
                        animacao_espera
                        Start-Sleep -Seconds 6
                        Write-Host ""
                        Write-Host ""

                        #Instalação do modulo do MIcrosoft Teams
                        Install-Module -Name PowerShellGet -Force -AllowClobber
                        Import-Module MicrosoftTeams
                        clear-Host

                        #Recurso de animação
                        Install-Module WriteAscii

                        clear-Host

                        Write-Host "==========================================================================================================" -ForegroundColor Cyan
                        Write-Host "                            SCRIPT ZEUS 365 | INSTALAÇÃO DE MODULOS DE GERENCIAMENTO" 
                        Write-Host "==========================================================================================================" -ForegroundColor Cyan
                        Write-Host 
                        Write-Host 

                        Write-Host "Ok! Deu tudo certo! O Script Zeus 365 foi Configurado com sucesso !" -ForegroundColor Yellow
                        Start-Sleep -Seconds 5


                        #Notificação
                        New-BurntToastNotification  -Text "O Script Zeus 365 foi configurado com sucesso !" -AppLogo .\Imagens\Zeus6.jpg
                        Start-Sleep -Seconds 3

                        clear-Host
                        menu-zeus
                        Write-Host

                        Write-Host
                        Write-Host "Para usar o Script Zeus 365 execute o arquivo Home.ps1 Ele estar na pasta C:/Script-Zeus/App" -ForegroundColor Yellow
                        Write-Host "ATENÇÃO: execute o arquivo Home.ps1 no modo normal. Use em modo administrador apenas se necessário !!!" -ForegroundColor Yellow
                        Write-Host

                        Write-Host
                        
                        Read-Host "Aperte qualquer tecla para [ SAIR ] da tela de configuração e iniciar o Zeus 365"

                        clear-Host
                        menu-zeus
                        Write-Host

                        Write-Host "Um momento vamos abrir o Menu principal para você...."
                        Write-Host

                        Start-Sleep -Seconds 8

                        clear-Host
                        menu-zeus
                        Write-Host
                        animacao_espera

                        start powershell {.\App\Home.ps1}
                        clear-Host
                        exit

                        #Stop-Process -Name "powershell" -Force 
                        
                            
            
        }

        2 {

            
            clear-Host
            menu-zeus

            Write-Host ""
            Write-Host "`CONFIGURAÇÃO CANCELADA" -ForegroundColor Yellow
            Write-Host ""
            Write-Host "`Essa tela será fechada em 10 segundos ...!" -ForegroundColor Yellow
            Write-Host ""

            Write-Host "`ATé logo ...!" -ForegroundColor Yellow
            Write-Host " " 
            Start-Sleep -Seconds 10

            exit
            Stop-Process -Name "powershell" -Force 
        }
       
        Default {
            menu-modulos
        }
    }
}

# Loop para o menu
do {

    $choice = Read-Host "Escolha um número em seguida aperte Enter" 
    permitir -choice $choice
    Clear-Host

    menu-modulos

    Write-Host " "

    Write-Host "`Você precisa escolher a opção 1 ou 2" -ForegroundColor Yello
    Write-Host "`Aperte Enter para recarregar o Menu ..." -ForegroundColor Yello

    Read-Host

    #Animação espera
    animacao_espera

    Clear-host
    menu-modulos
    decisaoUsuario
    

} while ($true)



 #Liberação de permissão do usuário - fim




