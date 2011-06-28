%% Trabalho de Inteligência Artificial

%% Grupo: Diego Oliveira Martins
%%	      Raphael Duarte Paiva
%%        Rodrigo de Assis Fialho
%%        Vinicius Bastos Bittencourt

%% Fatos
nasceu(mary, eua).
nasceu(john, eua).
nasceu(joao, brasil).

nasceu(katja, alemanha).
nasceu(maria, alemanha).

nasceu(ramon, mexico).
nasceu(monica, brasil).
nasceu(florinda, mexico).
nasceu(conchita, mexico).

mae(mary, joao).
mae(katja, maria).

mae(monica, florinda).

mae(monica, conchita).

pai(john, joao).

pai(joao, maria).

pai(ramon, florinda).

pai(ramon, conchita).

trabalha(mary, alemanha).
trabalha(john, estonia).

trabalha(joao, estonia).
trabalha(katja, brasil).

registro(florinda, brasil).

registro(conchita, mexico).

reside(conchita, brasil).

maior(conchita).

optaNacionalidade(conchita).

%% Cláusulas

%% Caso 1:

%% Pessoa nasceu no Brasil.
%% Pais sao estrangeiros.
%% Pais nao trabalham a servico de seus paises de origem.

nacionalidade(X) :- nasceu(X, brasil),                                        %% Nasceu no brasil
                    pai(Pai, X), mae(Mae, X),                                 %% Pai e mãe
                    nasceu(Pai, PaisPai), nasceu(Mae, PaisMae),               %% são estrangeiros
                    not(PaisPai=brasil), not(PaisMae=brasil),
                    not(trabalha(Pai, PaisPai)), not(trabalha(Mae, PaisMae)). %% Pais não trabalham para seus países de origem.

%% Caso 2:

%% Pessoa nasceu no exterior.
%% Pai ou mae sao Brasileiros.
%% Pai ou mae trabalham a servico do Brasil.

nacionalidade(X) :- not(nasceu(X, brasil)),
                    pai(Pai, X), nasceu(Pai, PaisPai),
                    mae(Mae, X), nasceu(Mae, PaisMae),
                    trabalha(Pai, TPaisPai), trabalha(Mae, TPaisMae),
                    (PaisPai=brasil; PaisMae=brasil),
                    (TPaisPai=brasil; TPaisMae=brasil).

%% Caso 3:

%% Pessoa nasceu no exterior.
%% Pai ou mae da pessoa eh brasileiro(a).
%% Pessoa registrada em reparticao brasileira.

nacionalidade(X) :- not(nasceu(X, brasil)),
                    pai(Pai, X), nasceu(Pai, PaisPai),
                    mae(Mae, X), nasceu(Mae, PaisMae),
                    (PaisPai=brasil; PaisMae=brasil),
                    registro(X, brasil).

%% Caso 4:

%% Pessoa nasceu no exterior.
%% Pai ou mae da pessoa eh brasileiro(a).
%% Pessoa eh maior de idade.
%% Pessoa reside no Brasil e opta pela nacionalidade brasileira.
%% (Maioridade no Brasil eh maior ou igual a 18 anos de idade.)

nacionalidade(X) :- not(nasceu(X, brasil)),
                    pai(Pai, X), nasceu(Pai, PaisPai),
                    mae(Mae, X), nasceu(Mae, PaisMae),
                    (PaisPai=brasil; PaisMae=brasil),
                    maior(X),
                    reside(X, brasil),
                    optaNacionalidade(X).
