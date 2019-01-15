function [sys,x0,str,ts] = sf_retour_linearisant_RP(t,x,u,flag)
% NE PAS MODIFIER CI-DESSOUS ; CF. SEULEMENT mdlOutputs PLUS BAS
%
switch flag,
  case 0,
    [sys,x0,str,ts] = mdlInitializeSizes;
  case 3,
    sys = mdlOutputs(t,x,u);
  case {1,2,4,9}
    sys = [];
  otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
%=============================================================================
function [sys,x0,str,ts] = mdlInitializeSizes
% NE PAS MODIFIER CI-DESSOUS ; CF. SEULEMENT mdlOutputs PLUS BAS
%
sizes = simsizes;
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 2;               % [d1;d2]
sizes.NumInputs      = 6;               % [q1;q2;dq1;dq2;ddq1;ddq2]
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [-1 0];                           % période héritée du bloc père
%=============================================================================
function sys = mdlOutputs(t,x,u)
%
ddq1_star = u(1); ddq2_star = u(2);
q1 = u(3); q2 = u(4); dq1 = u(5); dq2 = u(6);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% À COMPLÉTER À PARTIR D'ICI %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sys DOIT ÊTRE INTIALISÉ AVEC LE CONTENU DU VECTEUR DE SORTIE DU BLOC
% e.g.
sys = [0;0];
%=============================================================================
