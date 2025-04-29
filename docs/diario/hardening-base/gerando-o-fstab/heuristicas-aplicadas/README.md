---
icon: '2'
---

# Heurísticas Aplicadas

| **Flag**            | **Função lógica**                                                      | **Comportamento eletrônico / impacto físico**                                  | **Acrônimo / Significado técnico**                          |
| ------------------- | ---------------------------------------------------------------------- | ------------------------------------------------------------------------------ | ----------------------------------------------------------- |
| `defaults`          | Usa configurações padrão para leitura/gravação, execução e permissões  | Mantém compatibilidade e operação padrão                                       | _Default options_: rw, suid, dev, exec, auto, nouser, async |
| `noatime`           | Evita atualizar o tempo de último acesso a cada leitura                | Reduz escritas em SSD, prolonga a vida útil                                    | _No Access Time_                                            |
| `compress=zstd`     | Habilita compressão de arquivos no disco com o algoritmo Zstandard     | Menos dados gravados → menos desgaste físico e uso eficiente de espaço         | _Compression = Zstandard_                                   |
| `commit=XX`         | Define intervalo (segundos) para sincronizar dados com disco           | Intervalo maior = menos I/O, mais performance, risco maior em queda de energia | _Commit interval_                                           |
| `ssd`               | Otimiza acesso e escrita para unidades flash                           | Altera algoritmos para se adequarem ao paralelismo e latência de SSDs          | _Solid State Drive optimization_                            |
| `space_cache=v2`    | Cria cache persistente de metadados do sistema de arquivos             | Montagem mais rápida; menor leitura de disco                                   | _Btrfs Space Cache v2_                                      |
| `autodefrag`        | Fragmentação automática para arquivos frequentemente modificados       | Melhora performance em arquivos pequenos/modificados; usa mais CPU             | _Auto Defragmentation_                                      |
| `uid=0,gid=0`       | Garante que apenas o root tenha acesso ao conteúdo da partição         | Impede leitura por usuários não autorizados                                    | _User ID 0 / Group ID 0 (root)_                             |
| `umask=0077`        | Define permissões restritas (acesso apenas ao dono)                    | Segurança para conteúdo sensível (ex: `/boot/efi`)                             | _User Mask 0077_                                            |
| `shortname=winnt`   | Força nomes de arquivos no estilo 8.3 (Windows antigo)                 | Compatibilidade com sistemas FAT e BIOS                                        | _Windows NT Shortname format_                               |
| `errors=remount-ro` | Em caso de erro, monta a partição como somente leitura                 | Evita danos maiores ao sistema em caso de corrupção                            | _Remount as Read-Only on Errors_                            |
| `ro`                | Monta partição como somente leitura                                    | Protege contra modificações; ideal para `/usr`                                 | _Read-Only_                                                 |
| `data=journal`      | Todos os dados e metadados passam pelo journal antes de serem escritos | Maior integridade e recuperação pós-falha, com mais escrita                    | _Data journaling_                                           |
| `nosuid`            | Ignora bits de setuid e setgid                                         | Impede escalonamento de privilégios via arquivos executáveis                   | _No SetUID_                                                 |
| `nodev`             | Não permite arquivos de dispositivo nessa partição                     | Aumenta segurança, especialmente em `/tmp`                                     | _No Device Files_                                           |
| `sw`                | Indica que a partição deve ser usada como swap                         | Ativa como memória virtual no sistema                                          | _Swap_                                                      |
