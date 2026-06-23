# Como instalar/configurar/usar o `postfix` no `Linux Ubuntu`

## Resumo

Neste documento estão contidos os principais comandos e configurações para instalar/configurar/usar o `postfix` no `Linux Ubuntu`.

## _Abstract_

_This document contains the main commands and settings to install/configure/use the `postfix` on `Linux Ubuntu`._

## Descrição [2]

### `postfix`

O `Postfix` é um popular servidor de _e-mail_ de código aberto projetado para ser rápido, fácil de configurar e altamente seguro. Ele é amplamente utilizado em servidores `Unix-like`, incluindo `Linux`. O `Postfix` gerencia o envio, recebimento e encaminhamento de _emails_, suportando protocolos como SMTP, SMTPS e TLS para comunicações seguras. Sua arquitetura modular e configuração flexível o tornam uma escolha confiável para hospedar serviços de _e-mail_ em ambientes corporativos e de servidor.


## 1. Configurar/Instalar/Usar o `postfix` no `Linux Ubuntu` [1]

Para configurar/instalar/usar o `postfix` no `Linux Ubuntu`, você pode usar o gerenciador de pacotes apt. Siga os passos abaixo:

1. Abrir o `Terminal Emulator`. Você pode fazer isso pressionando:

    ```bash
    Ctrl + Alt + T
    ```


2. Certifique-se de que seu sistema esteja limpo e atualizado.

    2.1 Limpar o `cache` do gerenciador de pacotes `apt`. Especificamente, ele remove todos os arquivos de pacotes (`.deb`) baixados pelo `apt` e armazenados em `/var/cache/apt/archives/`. Digite o seguinte comando:
    ```bash
    sudo apt clean
    ```

    2.2 Remover pacotes `.deb` antigos ou duplicados do `cache` local. É útil para liberar espaço, pois remove apenas os pacotes que não podem mais ser baixados (ou seja, versões antigas de pacotes que foram atualizados). Digite o seguinte comando:
    ```bash
    sudo apt autoclean
    ```

    2.3 Remover pacotes que foram automaticamente instalados para satisfazer as dependências de outros pacotes e que não são mais necessários. Digite o seguinte comando:
    ```bash
    sudo apt autoremove -y
    ```

    2.4 Buscar as atualizações disponíveis para os pacotes que estão instalados em seu sistema. Digite o seguinte comando e pressione `Enter`:
    ```bash
    sudo apt update
    ```

    2.5 **Corrigir pacotes quebrados**: Isso atualizará a lista de pacotes disponíveis e tentará corrigir pacotes quebrados ou com dependências ausentes:
    ```bash
    sudo apt --fix-broken install
    ```

    2.6 Limpar o `cache` do gerenciador de pacotes `apt` novamente:
    ```bash
    sudo apt clean
    ```

    2.7 Para ver a lista de pacotes a serem atualizados, digite o seguinte comando e pressione `Enter`:
    ```bash
    sudo apt list --upgradable
    ```

    2.8 Realmente atualizar os pacotes instalados para as suas versões mais recentes, com base na última vez que você executou `sudo apt update`. Digite o seguinte comando e pressione `Enter`:
    ```bash
    sudo apt full-upgrade -y
    ```

3. **Instalar o `postfix`**: Execute o seguinte comando para instalar o `postfix`:

    ```bash
    sudo apt install postfix -y
    ```

4. **Configuração durante a instalação**: Durante o processo de instalação, será solicitado que você configure o `postfix`. Você verá uma tela com algumas opções. As opções mais comuns são:

    - **Internet site**: Esta é a escolha mais comum. O `postfix` será configurado para enviar e receber e-mails diretamente na internet.

    - **Smarthost**: Escolha essa opção se você deseja encaminhar todos os e-mails para um servidor SMTP externo.

    Selecione a opção que melhor se adequa às suas necessidades e continue com a configuração.

5. **Configure o nome do sistema de e-mail**: Você também será solicitado a definir o `"mail name"` do sistema, que é o nome de domínio que será anexado ao final de cada endereço de e-mail local. Por exemplo, se você digitar `"meuservidor.com"`, e-mails enviados para `"usuario"` serão tratados como:

    ```bash
    "usuario@meuservidor.com"
    ```

6. **Verifique o _status_ do `postfix`**: Após a instalação, você pode verificar se o postfix está rodando corretamente com o comando:

    ```bash
    sudo systemctl status postfix
    ```

7. **Reinicie o `postfix` (se necessário)**: Se você fizer qualquer alteração no arquivo de configuração do `postfix`, lembre-se de reiniciar o serviço para que as mudanças tenham efeito:

    ```bash
    sudo systemctl restart postfix
    ```

Seguindo esses passos, o `postfix` deverá estar instalado e configurado no seu sistema `Linux Ubuntu`.

## 1.1 Código completo para configurar/instalar/usar

Para configurar/instalar/usar o `postfix` no `Linux Ubuntu` sem precisar digitar linha por linha, você pode seguir estas etapas:

1. Abrir o `Terminal Emulator. Você pode fazer isso pressionando:

    ```bash
    Ctrl + Alt + T
    ```

2. Digite o seguinte comando e pressione `Enter`:

    ```bash
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


## 2. Configurar relay do `Gmail` para envio externo

Em computadores pessoais, o `Postfix` não deve tentar entregar mensagens diretamente para o Gmail
pela porta `25`. Esse envio direto costuma ser recusado por falta de `PTR`, `SPF`, `DKIM` e
reputação de servidor. O caminho validado nesta máquina é usar o `Postfix` como cliente SMTP e
encaminhar tudo para o relay autenticado do `Gmail` em `[smtp.gmail.com]:587`.

Este fluxo foi usado para que o `howdy` envie fotos de tentativas falhas de autenticação para
`edendenis@gmail.com`.

1. Gerar uma senha de app na Conta Google. Use uma senha de app, não a senha normal da conta.

2. Executar o script deste repositório pelo `Terminal Emulator`:

    ```bash
    cd /home/edenedfsls/Documents/Downloads/unix/ubuntu/postfix
    bash scripts/configure_gmail_relay.sh
    ```

   O script pede a conta e a senha de app em modo oculto. A saída do script é em inglês para
   facilitar leitura de logs e depuração em terminal.

3. Testar o envio:

    ```bash
    echo "Postfix Gmail relay test" | mail -s "Postfix Gmail relay test" edendenis@gmail.com
    sleep 8
    tail -n 50 /var/log/mail.log
    ```

4. Confirmar que o Gmail aceitou a mensagem. O trecho esperado no _log_ é:

    ```text
    relay=smtp.gmail.com[...]:587
    status=sent
    ```

5. Se aparecer `535-5.7.8 Username and Password not accepted`, gere uma nova senha de app e execute
   o script novamente. Remova espaços da senha se for digitar manualmente; o script já faz essa
   limpeza automaticamente.


## 3. Arquivos de configuração versionados

Este repositório guarda cópias restauráveis dos arquivos não secretos usados na configuração:

- `scripts/postfix/main.cf`: cópia de `/etc/postfix/main.cf`
- `scripts/postfix/generic`: cópia de `/etc/postfix/generic`
- `scripts/sasl_passwd.example`: modelo de `/etc/postfix/sasl_passwd`
- `scripts/configure_gmail_relay.sh`: script para recriar `/etc/postfix/sasl_passwd`, executar
  `postmap` e reiniciar o `postfix`

O arquivo real `/etc/postfix/sasl_passwd` contém a senha de app do `Gmail` e não deve ser
versionado.


## 4. Restaurar após formatação

1. Clonar este repositório e entrar na pasta:

    ```bash
    cd /home/edenedfsls/Documents/Downloads/unix/ubuntu/postfix
    ```

2. Restaurar os arquivos não secretos:

    ```bash
    sudo cp scripts/postfix/main.cf /etc/postfix/main.cf
    sudo cp scripts/postfix/generic /etc/postfix/generic
    sudo postmap /etc/postfix/generic
    ```

3. Recriar a senha de app no Google e aplicar o relay:

    ```bash
    bash scripts/configure_gmail_relay.sh
    ```

4. Validar:

    ```bash
    postconf -n | sed -n '/^relayhost/p;/^smtp_sasl/p;/^smtp_tls/p;/^smtp_generic/p'
    echo "Postfix Gmail relay test" | mail -s "Postfix Gmail relay test" edendenis@gmail.com
    sleep 8
    tail -n 50 /var/log/mail.log
    ```

## Referências

[1] OPENAI. ***Instalar o `postfix` no `linux ubuntu` pelo `terminal emulator`.*** Disponível em: <https://chatgpt.com/c/8e2db019-bece-4843-80d3-12a1f109fa77> (texto adaptado). ChatGPT. Acessado em: 17/08/2024 10:24.

[2] OPENAI. ***Vs code: editor popular.*** Disponível em: <https://chat.openai.com/c/b640a25d-f8e3-4922-8a3b-ed74a2657e42> (texto adaptado). ChatGPT. Acessado em: 17/08/2024 10:06.
