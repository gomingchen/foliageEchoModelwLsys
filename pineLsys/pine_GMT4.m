% GMT1 method ~ Botanical Tree Image Generation
% Created by Ming, Chen on 11/5/16

%%% Generate strings according to L-system
function  [BR, lfin, Gtip_vs_Bun] = pine_GMT4(nReps, Rb)

%starting seed

axiom = 'g';

%number of repititions
%nReps = 12;
%load(sprintf('ax%d',nReps));
%Rules--
rule(1).before = 'g';
rule(1).after = 'd[g]g';

rule(2).before = 'd';
rule(2).after = 'd' ;
nRules = length(rule);


for i=1:nReps
    
    %one character/cell, with indexes the same as original axiom string
    axiomINcells = cellstr(axiom');
    
    for j=1:nRules
        %the indexes of each 'before' string
        hit = strfind(axiom, rule(j).before);
        if (length(hit)>=1)
            for k=hit
                axiomINcells{k} = rule(j).after;
            end
        end
    end
    %now convert individual cells back to a string
    axiom=[];
    for j=1:length(axiomINcells)
        axiom = [axiom, axiomINcells{j}];
    end
end

stkPtr = 1;
% figure(1)
% clf
% hold on

%vertex counter
vNd = 1; 
%vNg = 1;
angle = 45;
h = [0 -angle 0]; % [Right Left First_branch] branching angle (degrees) 
%H = [0 angle  0];
R = [.9 .7 1];  % Contract ratio of [Main Other First_branch] branches
%Rb = 1.5; % Hight of first branch

%Init the turtle
xT = 0;
yT = 0;
zT = 0;
u = 0;
v = 0;
w = 1;


newu = 0;
newv = 0;
neww = 0;

II = 3;
NN = 0;

alpha = 0; % in degrees, is the angle that one axis should rotate around main axis
ns1 = 0;
R0 = 0.08*Rb; % The radius of first d branch
Rdiam = 0.7; % contraction ratio of radius
% Uniform deviation
dx = 0*Rb; % in x-direction
dy = 0*Rb; % in y-direction
dz = 0.03*Rb; % in z-direction

angleB = 90;
angleT = 20;
K = (angleB - angleT)/(nReps - 1);
C = K + angleB;

lfin = [];
Gtip_vs_Bun = [];
vNg = 0;

load(sprintf('nReps%d', nReps));
load(sprintf('GMT4_nReps%d', nReps));

for i=1:length(axiom)
   
    cmdT = axiom(i);
    switch cmdT
        case 'd'
            if u == 0 && v == 0
                Rb = R(II)*Rb;
                u = 0 + dx;
                v = Rb*sind(h(II)) + dy;
                w = Rb*cosd(h(II)) + dz;
                newUVW = rotz(alpha)*[u;v;w]; % 
                
                u = newUVW(1);
                v = newUVW(2);
                w = newUVW(3);
                newxT = xT + u;
                newyT = yT + v;
                newzT = zT + w;

                %vertsF{vNd} = [true(1) xT yT zT  newxT newyT newzT R0];
                BR(vNd,:) = [true(1) xT yT zT  newxT newyT newzT R0];
                vNd = vNd +1;
                %cylinder2P(R0, 10, [xT yT zT], [newxT newyT newzT])
                xT = newxT;
                yT = newyT;
                zT = newzT;
                
            else
            S = 1/sqrt(u^2 + v^2);
            T = sqrt(u^2 + v^2 + w^2);
            U = R(II)*(u*cosd(h(II)) - S*T*v*sind(h(II))) + dx;
            V = R(II)*(v*cosd(h(II)) + S*T*u*sind(h(II))) + dy;
            W = R(II)*w*cosd(h(II)) + dz;
            
            newxT = xT + U;
            newyT = yT + V;
            newzT = zT + W;
 
            u = U;
            v = V;
            w = W;
            
      
            BR(vNd,:) = [true(1) xT yT zT  newxT newyT newzT R0];
            vNd = vNd +1;
            
            xT = newxT;
            yT = newyT;
            zT = newzT;
            end
        case 'g'
            if u == 0 && v == 0
            Rb = R(II)*Rb;
            u = 0;
            v = Rb*sind(h(II));
            w = Rb*cosd(h(II));
            newxT = xT + u;
            newyT = yT + v;
            newzT = zT + w;
           
            
            vNg = vNg + 1;
            BR(vNd,:) = [false(1) xT yT zT  newxT newyT newzT R0];
            lfvec = PineNeedle2_nofig(30, 75, 15E-2, [u v w], [newxT newyT newzT]);
            Gtip_vs_Bun = [Gtip_vs_Bun ; ones(30,1)*vNg];
            lfin = [lfin;lfvec];
            vNd = vNd +1;
            
            
            xT = newxT;
            yT = newyT;
            zT = newzT;
            else
            S = 1/sqrt(u^2 + v^2);
            T = sqrt(u^2 + v^2 + w^2);
            U = R(II)*(u*cosd(h(II)) - S*T*v*sind(h(II))) + dx;
            V = R(II)*(v*cosd(h(II)) + S*T*u*sind(h(II))) + dy;
            W = R(II)*w*cosd(h(II)) + dz;
            
            newxT = xT + U;
            newyT = yT + V;
            newzT = zT + W;
 
            u = U;
            v = V;
            w = W;
            
            
            vNg = vNg + 1;
            BR(vNd,:) = [false(1) xT yT zT  newxT newyT newzT R0];
            lfvec = PineNeedle2_nofig(30, 75, 15E-2, [u v w], [newxT newyT newzT]);
            Gtip_vs_Bun = [Gtip_vs_Bun ; ones(30,1)*vNg];
            lfin = [lfin;lfvec];
            vNd = vNd +1;
            
            xT = newxT;
            yT = newyT;
            zT = newzT;
            end
        case '[' % push the stack and turn left
            
            NN = NN + 1;
            
            R0 = R0*Rdiam;
            stack(stkPtr).xT = xT ;
            stack(stkPtr).yT = yT ;
            stack(stkPtr).zT = zT ;
            stack(stkPtr).u = u ;
            stack(stkPtr).v = v ;
            stack(stkPtr).w = w ;
            stack(stkPtr).R0 = R0;
            stack(stkPtr).Rb = Rb;
            
            if stkPtr == 1
                alpha = 40*ns1;
                ns1 = ns1 + 1;
            end
            
            h = [0 index(NN)*(-K*IND(NN)+C) 0];

            stack(stkPtr).h = h;
            stkPtr = stkPtr +1 ;
            II = 2;

        case ']' % pop the stack and turn right
            %%% Should retrieve positions and uvw
            stkPtr = stkPtr -1 ;
            xT = stack(stkPtr).xT ;
            yT = stack(stkPtr).yT ;
            zT = stack(stkPtr).zT ;
            u = stack(stkPtr).u ;
            v = stack(stkPtr).v ;
            w = stack(stkPtr).w ;
            h = stack(stkPtr).h ;
            R0 = stack(stkPtr).R0;
            Rb = stack(stkPtr).Rb;
            II = 1;
            alpha = 0;
    end
          
end

% view(100,20);
% axis equal
% xlabel('x(m)');
% ylabel('y(m)')
% zlabel('z(m)');
