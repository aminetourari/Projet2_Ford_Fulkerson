%% Algorithme de *Ford-Fulkerson* pour les tensions
%
% Application à la recherche d'une solution à un problème d'ordonnancement,
% ie à la recherche du plus long chemin du sommet 1 (b) au sommet 2 (a)
% dans un graphe (X,U) modélisé comme un problème de tension maximale
%
%
% Représentation du graphe
%   - n == nombre de sommets
%   - m == nombre d'arcs
%
%   - X:    Liste des sommets de G
%   - NSUC: Vecteur du nombre de successeurs de chaque sommet
%   - SUC:  Vecteur des successeurs de chaque sommet
%   - theta:Vecteur de tension courante sur chaque arc
%   
%
%% Initialisations
NSUC = uint16([3 0 2 1 1 1 1 1]);
NSUC = uint16([3 0 2 1 2 1 1 1 1]);
NSUC = uint16([2 2 3 2 1 3 1 0]);
n = size(NSUC,2);
X = uint16(1:n); % X contient la liste des sommets de G
m = sum(NSUC);
%
% Vecteur des successeurs de chaque sommet : SUC
SUC = uint16([2 3 4 5 6 6 7 7 8 2]);
SUC = uint16([2 3 4 5 6 6 7 8 8 2 9 2]);
SUC = uint16([2 4 7 3 7 6 5 3 5 8 7 8 5 8]);
%
% Vecteur des longueurs de chaque arc
LONG = [inf 0 0 3 3 6 5 4 8 5];
LONG = [inf 0 0 3 3 7 4 4 6 5 3 2];
LONG = [12 14 24 13 3 7 1 10 16 26 5 21 4 21];
%
% Vecteur de la tension courante theta
theta = zeros(1,m);
%
% MARQUE indique la marque associée à chacun des sommets
MARQUE = zeros(1,n);
%
PLUSLONGCHEMIN = uint16(zeros(1,n)); % Vecteur du plus long chemin de 1 (b) à 2 (a)
PLUSLONGCHEMIN(1) = 1;
%
%% Algorithme de FF
marquage_en_cours = true;
while marquage_en_cours
    marquage_en_cours=false;
    for u=X
        % Parcourir les successeurs du sommet courant et tenter de les marquer
        premSuc = sum(NSUC(1:u-1)) + 1;
        for indArc = premSuc:premSuc+NSUC(u)-1
            v = SUC(indArc); % (u,v) est un arc
            if (MARQUE(v) - MARQUE(u)) < LONG(indArc)
                MARQUE(v) = MARQUE(u) + LONG(indArc);
                marquage_en_cours = true;
            end
        end
    end
end


%% Post-traitement : extraction du plus long chemin
i = 1;
prsuc = 1;
nsom = 1;
while i ~= 2
    for k = prsuc:prsuc+NSUC(i)-1
        j = SUC(k);
        if theta(k) == LONG(k)
            nsom = nsom + 1;
            PLUSLONGCHEMIN(nsom) = j;
            break;
        end
    end
    i=j;
    prsuc = sum(NSUC(1:i-1)) + 1;
end
%
disp (['Plus long chemin : ',num2str(PLUSLONGCHEMIN(1:nsom))]);
disp (['Longueur du long court chemin : ', num2str(theta(1))]);
