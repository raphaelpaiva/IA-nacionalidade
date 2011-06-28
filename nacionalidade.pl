%% Trabalho de Inteligência Artificial

%% Grupo: Diego Oliveira Martins
%%	      Raphael Duarte Paiva
%%        Rodrigo de Assis Fialho
%%        Vinicius Bastos Bittencourt

%% Fatos
%% Caso 1:
nasceu(mary, eua).
nasceu(john, eua).
nasceu(joao, brasil).

mae(mary, joao).
pai(john, joao).

trabalha(mary, alemanha).
trabalha(john, estonia).

%% Cláusulas

%% Caso 1:
%% Pessoa nasceu no Brasil.
%% Pais sao estrangeiros.
%% Pais nao trabalham a servico de seus paises de origem.

nacionalidade(X) :- nasceu(X, brasil), %% Nasceu no brasil
                    pai(Pai, X), mae(Mae, X), %% Pai e mãe são estrangeiros
                    nasceu(Pai, PaisPai), nasceu(Mae, PaisMae),
                    not(PaisPai=brasil), not(PaisMae=brasil),
                    not(trabalha(Pai, PaisPai)), not(trabalha(Mae, PaisMae)). %% Pais não trabalham para seus países de origem.
                   
