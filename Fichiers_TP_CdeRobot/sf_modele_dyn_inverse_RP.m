function [sys,x0,str,ts] = sf_modele_dyn_inverse_RP(t,x,u,flag,m,gX,gY,F1,F2,H1,H2)
%
% u = [vecteur_q1_q2_dq1_dq2_ddq1_ddq2]
%

% VALEURS PAR DÉFAUT DES PARAMÈTRES
% m = 30; % masse localisée en O3 (kg)
% gX = 0; % champ de potentiel gravitationnel en O3 selon l'axe x (kg.m.s^-2)
% gY = -9.81; % champ de potentiel gravitationnel en O3 selon l'axe y (kg.m.s^-2)
% F1 = 1; % coefficient de frottement visqueux sur la liaison 1
% F2 = 1; % coefficient de frottement visqueux sur la liaison 2
% H1 = 1; % coefficient de frottement solide sur la liaison 1
% H2 = 1; % coefficient de frottement solide sur la liaison 2

switch flag,
  case 0,
    [sys,x0,str,ts] = mdlInitializeSizes;
  case 3,
    sys = mdlOutputs(t,x,u,m,gX,gY,F1,F2,H1,H2);
  case {1,2,4,9}
    sys = [];
  otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end

%=============================================================================

function [sys,x0,str,ts] = mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 2;               % [Gamma1;Gamma2]
sizes.NumInputs      = 6;               % [q1;q2;dq1;dq2;ddq1;ddq2]
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [-1 0];                           % période héritée du bloc père

%=============================================================================

function sys = mdlOutputs(t,x,u,m,gX,gY,F1,F2,H1,H2)
q1 = u(1); q2 = u(2); dq1 = u(3); dq2 = u(4); ddq1 = u(5); ddq2 = u(6);
%
% cf. M Dyn Inverse : Gamma = D(q).ddq+B(q,dq)+G(q)-Fvisqueux-Hsecs-Qext
% cf. M Dyn Direct : ddq = inv(D(q))*[Gamma-B(q,dq)-G(q)+Fvisqueux+Hsecs+Qext]
matD = [m*q2^2 0;0 m];
matB = [2*m*q2*dq1*dq2;-m*q2*dq1^2];
matG = -[m*q2*(-gX*sin(q1)+gY*cos(q1));m*(gX*cos(q1)+gY*sin(q1))];
Fvisqueux = -([F1 0;0 F2]*[dq1;dq2]);
Hsecs = -([H1 0;0 H2]*[sign(dq1);sign(dq2)]);
Qext = [0;0]; % ici
% en général, Qext = [cZ+fY*q2;fX], (fX,fY,fZ) et (cX,cY,cZ) étant les forces
% et couples exercés sur l'OT du robot par l'environnement, exprimés dans R2;
%
vecteur_Gamma1_Gamma2 = matD*[ddq1;ddq2]+matB+matG-Fvisqueux-Hsecs-Qext;
sys = vecteur_Gamma1_Gamma2;

%=============================================================================
