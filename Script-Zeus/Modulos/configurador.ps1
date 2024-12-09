

#Importes



# Funções



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

$Versao = "V1.0.0 - Beta"

#IMagemArtsZeus

# NOTICE: This project has been moved to its own repository https://github.com/ConnerWill/Convert-ImageToASCIIArt

function Convert-ImageToAsciiArt {  
<#
  .SYNOPSIS
     Function to convert an image to ascii art.
     
  .DESCRIPTION
     The function Convert-ImageToAsciiArt takes an image file path and converts the image to ASCII art.
     The ASCII art is created by replacing each pixel in the image with an ASCII character based on the brightness of the pixel.
     The ASCII characters used are specified in the $chars variable, and their brightness is determined by the grayscale value of the original pixel.
     
  .EXAMPLE
       #Convert-ImageToAsciiArt -ImagePath ".\Imagens\Zeus5.jpg" -MaxWidth 106 -Contrast 50 "
      
  .EXAMPLE
      Convert-ImageToAsciiArt -ImagePath "C:\path\to\image.jpg" -MaxWidth 80 -Contrast 75
#>
    param (
        [Parameter(Mandatory=$true)]
        [ValidateScript({Test-Path $_ -PathType 'Leaf'})]
        [string]$ImagePath,
        
        [Parameter()]
        [int]$MaxWidth = 120,
        
        [Parameter()]
        [ValidateRange(0,100)]
        [int]$Contrast = 50
    )
    
    # Load the image and resize it to a maximum width of $MaxWidth.
    $image = [System.Drawing.Image]::FromFile($ImagePath)
    $ratio = $MaxWidth / $image.Width
    $newWidth = [int]($image.Width * $ratio)
    $newHeight = [int]($image.Height * $ratio)
    $resizedImage = $image.GetThumbnailImage($newWidth, $newHeight, $null, [System.IntPtr]::Zero)
    
    # Create a list of ASCII characters to use for the output.
    $chars = @(' ', '.', ',', ':', ';', 'o', 'x', '%', '#', '@')
    
    # Convert each pixel in the image to an ASCII character based on its brightness.
    $asciiChars = for ($y = 0; $y -lt $resizedImage.Height; $y++) {
        $line = for ($x = 0; $x -lt $resizedImage.Width; $x++) {
            $pixel = $resizedImage.GetPixel($x, $y)
            $brightness = ([int]$pixel.R * 0.299 + [int]$pixel.G * 0.587 + [int]$pixel.B * 0.114) / 255
            $charIndex = [int]($brightness * ($chars.Count - 1))
            $chars[$charIndex]
        }
        [string]::Join('', $line)
    }
    
    # Apply the contrast parameter by replacing the ASCII characters with different
    # characters based on their brightness.
    $minCharIndex = 0
    $maxCharIndex = $chars.Count - 1
    $midCharIndex = [int](($minCharIndex + $maxCharIndex) / 2)
    $contrastChars = for ($i = 0; $i -lt $chars.Count; $i++) {
        $brightness = $i / ($chars.Count - 1)
        if ($brightness -lt $Contrast / 200) {
            $minCharIndex
        }
        elseif ($brightness -gt ($Contrast + 100) / 200) {
            $maxCharIndex
        }
        else {
            $midCharIndex
        }
    }
    $asciiChars = $asciiChars -replace "[{0}-{1}]" -f $minCharIndex, $maxCharIndex, $contrastChars
    
    # Output the ASCII art.
    Write-Output $asciiChars
}




function Show-Menu {
    Clear-Host
    Write-Host "==========================================================================================================" -ForegroundColor Cyan
    Write-Host "                                ZEUS 365 | MENU PRINCIPAL                                   $Versao       "                                          
    Write-Host "==========================================================================================================" -ForegroundColor Cyan
    Write-Host " " 
    Write-Host "1 - RELATÓRIOS DO SHAREPOINT         " -ForegroundColor Gree    
    Write-Host "2 - RELATÓRIOS DO EXCHANGE ON-LINE   " -ForegroundColor Red   
    Write-Host "3 - RELATÓRIOS DO MS365/Entra ID     " -ForegroundColor Red 
    Write-Host "4 - RELATÓRIOS DO TEAMS              " -ForegroundColor Red 
    Write-Host "5 - RELATÓRIOS GERAIS                " -ForegroundColor Red 
    Write-Host "6 - AUDITORIAS                       " -ForegroundColor Red 
    Write-Host "7 - ULTILITÁRIOS                     " -ForegroundColor Red 
    Write-Host "8 - RELATÓRIO INTEGRADO | FULL       " -ForegroundColor Red 
    Write-Host 
    Write-Host "20 - SAIR                    21 - AJUDA                      22 -  EULA                         23 - SOBRE"  -ForegroundColor yELLOW
    Write-Host  
    Write-Host "===========================================================================================================" -ForegroundColor Cyan
    Write-Host
  
}



# Menu relatório do SharePoint
function menu-sharepoint {

    Clear-Host
    Write-Host "==========================================================================================================" -ForegroundColor Cyan
    Write-Host "                                ZEUS 365 | RELATÓRIOS DO SHAREPOINT " -ForegroundColor Cyan
    Write-Host "==========================================================================================================" -ForegroundColor Cyan
    Write-Host " " 
    Write-Host "1 - Todos os sites do SharePoint"        -ForegroundColor Gree
    Write-Host "2 - Sites com acesso externo habilitado" -ForegroundColor Gree
    Write-Host "3 - Liks compartilhado externamente"     -ForegroundColor Gree
    Write-Host "4 - LIstar usuários externo "            -ForegroundColor Gree
    Write-Host "5 - Lista de links anonimos"             -ForegroundColor Red
    Write-Host
    Write-Host
    Write-Host "20 - SAIR                                   21 - MENU PRINCIPAL" -ForegroundColor Yellow
    Write-Host  
    Write-Host "==========================================================================================================" -ForegroundColor Cyan
    Write-Host
    

}

function baner-meu-sharepoint {

Write-Host "==========================================================================================================" -ForegroundColor Cyan
Write-Host "                                      ZEUS | RELATÓRIOS DO SHAREPOINT " -ForegroundColor Cyan
Write-Host "==========================================================================================================" -ForegroundColor Cyan
Write-Host " " 
}


function menu-zeus-sobre {

Clear-Host
Write-Host "==========================================================================================================" -ForegroundColor Cyan
Write-Host "                                      ZEUS 366 | SOBRE" -ForegroundColor Cyan
Write-Host "==========================================================================================================" -ForegroundColor Cyan
Write-Host 
Write-Host 
Write-Host " > Nome: Script Zeus 365"                                   -ForegroundColor Gree
Write-Host " > Nome abreviado: Zeus"                                    -ForegroundColor Gree
Write-Host " > Versão: 1.0.0 - Beta"                                    -ForegroundColor Gree
Write-Host " > Criador: Wanderson Silva"                                -ForegroundColor Gree
Write-Host " > Contato: wanderson.silva@contactpoint.com.br"            -ForegroundColor Gree            
Write-Host 
Write-Host " 20 - SAIR                                   21 - MENU PRINCIPAL" -ForegroundColor Yellow
Write-Host 
Write-Host "==========================================================================================================" -ForegroundColor Cyan
           
            Write-Host
            Write-Host "Créditos"
            Write-Host

            Write-Host 
            Write-Host "90% desse script é uma coleção de Script pre-prontos de sites de comunidadee e Githb"
            Write-Host "Abaixo a lista dos sites que colaboraram indiretamente"
            Write-Host 

            Write-Host "Nome: Office Report "
            Write-Host "Site: www.o365reports.com"
            Write-Host 

            Write-Host "Nome: AdminDroid "
            Write-Host "Site: www.admindroid.com"
            Write-Host 

            Write-Host "Nome: Salaudeen Rajack "
            Write-Host "Site: www.sharepointdiary.com"

            Write-Host 
            Write-Host 

            $Sair_do_sobre =  Read-Host "Escolha um número em seguida aperte Enter" 
            Write-Host 

            Switch  ($Sair_do_sobre){
                21{
                    Clear-host
                    Show-Menu
                    
                }

                20{
                    Clear-host
                    exit
                    Stop-Process -Name "powershell" -Force 
                }
                default{
                        Clear-Host
                        meu-zeus-sobre 

                        Write-Host " " 
                        Write-Host "Opção inválida! Você precisa digitar o número 1 ou 2." -ForegroundColor Red
                        Write-Host "Recaregando Menu " -ForegroundColor Yello
                        Write-Host " " 
                        animacao_espera
                        meu-zeus-sobre

                }
            }
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
    Write-Host "Você autoriza ajustarmos a propriedade Set-ExecutionPolicy para Bypass ? "
    
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


 #Funcção estatos de opções

 #Habilitada
 function opc_habilitada {
          Write-Host "O"  -ForegroundColor Green
 }

 #Desabilitada
  function opc_desabilitada {
          Write-Host "O"  -ForegroundColor Red
 }

 #Aviso de modulo em desenvolvimento

 function mod_em_construcao {
             clear-host
             menu-zeus
             Write-Host 
             Write-Host 
             Write-Host "Descupe! Esse modulo ainda está em desenvolvimento!!"                            -ForegroundColor Red
             Write-Host "Acompanhe o Github desse projeto para você não perder as atualizaçõe futuras"    -ForegroundColor Red
             Write-Host
             Write-Host "Um momento, vou abrir o Github desse projeto em seu navegador!"                  -ForegroundColor Yellow
             Write-Host "Em seguida vou recarregar o menu principal para você!"                           -ForegroundColor Yellow

             Start-Sleep -Seconds 15

             start https://github.com/Wanderson304/Script-Zeus-365/wiki

             Write-Host
             animacao_espera

             Write-Host
             Clear-Host
             Show-Menu
             
             #start powershell {..\App\Home.ps1} 
             #exit
    }


#Função ajuda

function ajuda {

            import-Module ..\Modulos\configurador.ps1
            
            clear-host
            Clear-Host
            Write-Host "==========================================================================================================" -ForegroundColor Cyan
            Write-Host "                                ZEUS 365 | AJUDA " -ForegroundColor Cyan
            Write-Host "==========================================================================================================" -ForegroundColor Cyan
            Write-Host " " 
            Write-Host "1 - Abrir página do projeto ZEUS 365 no Github" -ForegroundColor Green
            Write-Host "2 - Abrir página de ajuda no Github"            -ForegroundColor Green
            Write-Host "3 - Abrir PLaylist de treinamento no Youtube"   -ForegroundColor Green
            Write-Host "4 - Créditos e Desenvolvimento"                 -ForegroundColor Green
            Write-Host
            Write-Host "20 - SAIR                                   21 - MENU PRINCIPAL" -ForegroundColor Yellow
            Write-Host  
            Write-Host "==========================================================================================================" -ForegroundColor Cyan
            Write-Host

            $choice = Read-Host "Escolha um número em seguida aperte Enter"

             Write-Host

            switch ($choice) {
                1 {
                   
                    Write-Host "Nessa página você vai entender o que é o Script Zeus 365 ...."  -ForegroundColor Yellow
                    Start-Sleep -Seconds 8
                    Write-Host ""
                    Write-Host "Um momento abrindo a página em seu navegador ...."              -ForegroundColor Yellow
                    Start-Sleep -Seconds 8
                    Write-Host ""
                    animacao_espera
                    start https://github.com/Wanderson304/Script-Zeus-365/wiki     
                    ajuda

                   
            
                }
                2 {
                    Write-Host "Nessa página você poderá compartilhar seu problema com outros usuários do Zeus 365 ...."  -ForegroundColor Yellow
                    Write-Host "Clique no botão verde "New issus" para criar uma discução sobre seu problema ...."  -ForegroundColor Yellow
                    Start-Sleep -Seconds 8
                    Write-Host ""
                    Write-Host "Um momento estamos abrindo a página em seu navegador ...."                                -ForegroundColor Yellow
                    Start-Sleep -Seconds 8
                    Write-Host ""
                    animacao_espera
                    start https://github.com/Wanderson304/Script-Zeus-365/issues     
                    ajuda
            
                }

                3 {
                    Write-Host "Nessa Playlist você vai aprender alguns recuros do Zeus 365 ...."                          -ForegroundColor Yellow
                    Start-Sleep -Seconds 8
                    Write-Host ""
                    Write-Host "Um momento estamos abrindo a Playlist em seu navegador ...."                                -ForegroundColor Yellow
                    Start-Sleep -Seconds 8
                    Write-Host ""
                    animacao_espera
                    start https://github.com/Wanderson304/Script-Zeus-365/wiki     
                    ajuda
            
                }
                4 {
                    Write-Host "Nessa página você terá informações sobre a criação do Zeus 365 ...."                          -ForegroundColor Yellow
                    Start-Sleep -Seconds 8
                    Write-Host ""
                    Write-Host "Um momento estamos abrindo a página de crédito em seu navegador ...."                          -ForegroundColor Yellow
                    Start-Sleep -Seconds 8
                    Write-Host ""
                    animacao_espera
                    start https://github.com/Wanderson304/Script-Zeus-365/wiki/Cr%C3%A9ditos     
                    ajuda
            
                }
                 20 {

                    clear-Host
                    exit
                    Stop-Process -Name "powershell" -Force 
                }
                    

                21 {
                   
                    clear-Host
                    Show-Menu

                    #start powershell {..\App\Home.ps1}
                    #exit
                    
                     
                }

	            }
                Default {
                     $choice = Read-Host "Escolha um número em seguida aperte Enter"  -ForegroundColor Red
                }

}