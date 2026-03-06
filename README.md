# Como instalar/configurar/usar o `postfix` no `Linux Ubuntu`

## Resumo

Neste documento estão contidos os principais comandos e configurações para instalar/configurar/usar o `postfix` no `Linux Ubuntu`.

## _Abstract_

_This document contains the main commands and settings to install/configure/use the `inkscape` on `Linux Ubuntu`._

## Descrição [2]

### `postfix`

O `Postfix` é um popular servidor de email de código aberto projetado para ser rápido, fácil de configurar e altamente seguro. Ele é amplamente utilizado em servidores `Unix-like`, incluindo `Linux`. O `Postfix` gerencia o envio, recebimento e encaminhamento de emails, suportando protocolos como SMTP, SMTPS e TLS para comunicações seguras. Sua arquitetura modular e configuração flexível o tornam uma escolha confiável para hospedar serviços de email em ambientes corporativos e de servidor.


## 1. Configurar/Instalar/Usar o `postfix` no `Linux Ubuntu` [1]

Para configurar/instalar/usar o `postfix` no `Linux Ubuntu`, você pode usar o gerenciador de pacotes apt. Siga os passos abaixo:

1. Abrir o `Terminal Emulator`. Você pode fazer isso pressionando: `Ctrl + Alt + T`


2. Certifique-se de que seu sistema esteja limpo e atualizado.

    2.1 Limpar o `cache` do gerenciador de pacotes `apt`. Especificamente, ele remove todos os arquivos de pacotes (`.deb`) baixados pelo `apt` e armazenados em `/var/cache/apt/archives/`. Digite o seguinte comando: `sudo apt clean` 
    
    2.2 Remover pacotes `.deb` antigos ou duplicados do cache local. É útil para liberar espaço, pois remove apenas os pacotes que não podem mais ser baixados (ou seja, versões antigas de pacotes que foram atualizados). Digite o seguinte comando: `sudo apt autoclean`

    2.3 Remover pacotes que foram automaticamente instalados para satisfazer as dependências de outros pacotes e que não são mais necessários. Digite o seguinte comando: `sudo apt autoremove -y`

    2.4 Buscar as atualizações disponíveis para os pacotes que estão instalados em seu sistema. Digite o seguinte comando e pressione `Enter`: `sudo apt update`

    2.5 **Corrigir pacotes quebrados**: Isso atualizará a lista de pacotes disponíveis e tentará corrigir pacotes quebrados ou com dependências ausentes: `sudo apt --fix-broken install`

    2.6 Limpar o `cache` do gerenciador de pacotes `apt`. Especificamente, ele remove todos os arquivos de pacotes (`.deb`) baixados pelo `apt` e armazenados em `/var/cache/apt/archives/`. Digite o seguinte comando: `sudo apt clean` 
    
    2.7 Para ver a lista de pacotes a serem atualizados, digite o seguinte comando e pressione `Enter`:  `sudo apt list --upgradable`

    2.8 Realmente atualizar os pacotes instalados para as suas versões mais recentes, com base na última vez que você executou `sudo apt update`. Digite o seguinte comando e pressione `Enter`: `sudo apt full-upgrade -y`
    

3. **Instale o `postfix`**: Execute o seguinte comando para instalar o `postfix`: `sudo apt install postfix -y`

4. **Configuração durante a instalação**: Durante o processo de instalação, será solicitado que você configure o `postfix`. Você verá uma tela com algumas opções. As opções mais comuns são:

    - **Internet site**: Esta é a escolha mais comum. O `postfix` será configurado para enviar e receber e-mails diretamente na internet.

    - **Smarthost**: Escolha essa opção se você deseja encaminhar todos os e-mails para um servidor SMTP externo.

    Selecione a opção que melhor se adequa às suas necessidades e continue com a configuração.

5. **Configure o nome do sistema de e-mail**: Você também será solicitado a definir o `"mail name"` do sistema, que é o nome de domínio que será anexado ao final de cada endereço de e-mail local. Por exemplo, se você digitar `"meuservidor.com"`, e-mails enviados para `"usuario"` serão tratados como `"usuario@meuservidor.com"`.

6. **Verifique o _status_ do `postfix`**: Após a instalação, você pode verificar se o postfix está rodando corretamente com o comando: `sudo systemctl status postfix`

7. **Reinicie o `postfix` (se necessário)**: Se você fizer qualquer alteração no arquivo de configuração do `postfix`, lembre-se de reiniciar o serviço para que as mudanças tenham efeito: `sudo systemctl restart postfix`

Seguindo esses passos, o `postfix` deverá estar instalado e configurado no seu sistema `Linux Ubuntu`.

## 1.1 Código completo para configurar/instalar/usar

Para configurar/instalar/usar o `postfix` no `Linux Ubuntu` sem precisar digitar linha por linha, você pode seguir estas etapas:

1. Abra o `Terminal Emulator. Você pode fazer isso pressionando: `Ctrl + Alt + T`

2. Digite o seguinte comando e pressione `Enter`:

    ```
    sudo apt clean
    sudo apt autoclean
    sudo apt autoremove
    sudo apt update -y
    sudo apt autoremove
    sudo apt autoclean
    sudo apt list --upgradable
    sudo apt full-upgrade -y
    sudo apt install postfix -y
    inkscape --version
    ```

## Referências

[1] OPENAI. ***Instalação do postfix ubuntu.*** Disponível em: <https://chatgpt.com/c/8e2db019-bece-4843-80d3-12a1f109fa77> (texto adaptado). ChatGPT. Acessado em: 17/08/2024 10:24.

[2] OPENAI. ***Vs code: editor popular.*** Disponível em: <https://chat.openai.com/c/b640a25d-f8e3-4922-8a3b-ed74a2657e42> (texto adaptado). ChatGPT. Acessado em: 17/08/2024 10:06.

