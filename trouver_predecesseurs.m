%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fonction qui retourne les prédecesseurs du sommet u dans un
% graphe, sous la forme : [prédecesseurs; n° arcs; longueur arcs]

function pred = trouver_predecesseurs(u, SUC, NSUC, LONG)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Paramètres
%   - MARQUES : Matrice des sommets marqués avec sens de marquage
%   - NSUC: Vecteur du nombre de successeurs de chaque sommet
%   - SUC:  Vecteur des successeurs de chaque sommet
%%Type retour : WAY : Matrice de taille 2*(size(MARQUES(1,:) != 0)-1)
%indiquant les arcs suivis et les sens ( WAY(1,:)= Sens, WAY(2,:)= Arc
%Le sommet 2 est toujours sommet de départ, et 1 sommet d'arrivé
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Trouver les indices de représentation de u dans les successeurs
indicesU = find(SUC == u);

% Si u a des prédecesseurs, les trouver
if (size(indicesU, 2) ~= 0)
    % Trouver le prédecesseur associé à chacun des indices trouvés
    pred = [];
    for predecesseur=1:size(NSUC,1)
        if NSUC(predecesseur) ~= 0
            nbSucAv = sum(NSUC(1:predecesseur));
            nbSucAp = sum(NSUC(1:predecesseur+1));
            for i=find(nbSucAv <= indicesU && indicesU < nbSucAp)
                num_arc = indicesU(i); % Représente l'indice de l'arc retenu
                pred = [pred [predecesseur; num_arc]];
            end
        end
    end
end

