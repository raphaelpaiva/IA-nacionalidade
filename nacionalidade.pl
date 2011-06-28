%% Trabalho de Inteligência Artificial

%% Grupo: Diego Oliveira Martins
%%	      Raphael Duarte Paiva
%%        Rodrigo de Assis Fialho
%%        Vinicius Bastos Bittencourt

%% Fatos
nasceu(josefino, brasil).
nasceu(rosicleia, brasil).
nasceu(setembriano, brasil).

nasceu(mary, eua).
nasceu(john, eua).
nasceu(joao, brasil).

nasceu(katja, alemanha).
nasceu(maria, alemanha).

nasceu(ramon, mexico).
nasceu(monica, brasil).
nasceu(florinda, mexico).
nasceu(conchita, mexico).

nasceu(ezio, italia).

nasceu(adriano, portugal).

mae(rosicleia, setembriano).

mae(mary, joao).
mae(katja, maria).

mae(monica, florinda).

mae(monica, conchita).

pai(josefino, setembriano).

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

reside(adriano, brasil).

resideHa(ezio, 16, brasil).

resideHa(adriano, 1, brasil).

maior(conchita).

optaNacionalidade(conchita).

condenacaoPenal(ezio, 0).

linguaOrigem(adriano, portugues).


naoNasceuNoBrasil(X) :- nasceu(X, PaisNascimento),
			not(PaisNascimento=brasil).
%% Cláusulas

%% Caso 0:

%% Pessoa nasceu no Brasil.
%% Pais nasceram no Brasil.

nacionalidade(X) :- nasceu(X, brasil),
                    pai(Pai, X), mae(Mae, X),
                    nasceu(Pai, brasil), nasceu(Mae, brasil).

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

nacionalidade(X) :- naoNasceuNoBrasil(X),
                    pai(Pai, X), nasceu(Pai, PaisPai),
                    mae(Mae, X), nasceu(Mae, PaisMae),
                    trabalha(Pai, TPaisPai), trabalha(Mae, TPaisMae),
                    (PaisPai=brasil; PaisMae=brasil),
                    (TPaisPai=brasil; TPaisMae=brasil).

%% Caso 3:

%% Pessoa nasceu no exterior.
%% Pai ou mae da pessoa eh brasileiro(a).
%% Pessoa registrada em reparticao brasileira.

nacionalidade(X) :- naoNasceuNoBrasil(X),
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

nacionalidade(X) :- naoNasceuNoBrasil(X),
                    pai(Pai, X), nasceu(Pai, PaisPai),
                    mae(Mae, X), nasceu(Mae, PaisMae),
                    (PaisPai=brasil; PaisMae=brasil),
                    maior(X),
                    reside(X, brasil),
                    optaNacionalidade(X).
                    
%% Caso 5:
%% Pessoa nasceu no exterior.
%% Pessoa nasceu em pais de lingua portuguesa.
%% Residencia no Brasil por um ano ininterrupto.

nacionalidade(X) :- naoNasceuNoBrasil(X),
                    linguaOrigem(X, portugues),
                    reside(X, brasil),
                    resideHa(X, Tempo, brasil),
                    Tempo > 0.
                    
%% Caso 6:

%% Pessoa nao nasceu no Brasil.
%% Pessoa reside no Brasil ha mais de 15 anos ininterruptos.
%% Pessoa nao teve nenhuma condenacao penal.

nacionalidade(X) :- naoNasceuNoBrasil(X),
                    resideHa(X, Tempo, brasil),
                    condenacaoPenal(X, 0),
                    Tempo > 15.
