% GMT3-Ternary Branching Model
% Created by Ming, Chen on 11/5/16

%%% Generate strings according to L-system
function [BR, lf, ntip, Itip] = GMT3(nReps, bRatio, angle, binit, lfnode)
% Inputs: nReps: growth level
%         bRatio: the ratio of child branch to mother branch
%         angle: the branching angle
%         binit: the length of the initial branch
%         lfnode: the number of leaf nodes per branch, not the tip branch,
%         the number of leaf nodes in tip branch is lfnode - 1
% Outputs: BR: vector includes the starting and ending point of each
%         branch, 'g' branch is flagged as false (0), 'd' branch is flagged
%         as true (1)
%         lf: center positions of each leaf and their normal vectors
%         Ntip, the coordinates of each leaf node
%         Itip, index of each leaf node. It could be '1', '2', '3', '4', if
%         the number of total leaf nodes on any branch is 4.
axiom = 'g';
%number of repititions
%nReps = 4;
load(sprintf('ax%d',nReps));
%Rules--
rule(1).before = 'g';
rule(1).after = 'd(g)[g)+g)'; 

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

%subplot(1,2,1);
%clf
%hold on

%vertex counter
vNd = 1; 
vNg = 1;


h = [angle 0 -angle 0]; % [Right Left First_branch] branching angle (degrees) 

R = [bRatio 0.826 bRatio binit];

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

alpha = 0; % in degrees

II = 4;
Rb = 1; % initial branch height
R0 = 0.04; % The radius of first d branch
Rdiam = 0.7; % contraction ratio of radius

Ns = 0;
Ng = 0;
N3 = 0;
N4 = 0;
N5 = 0;

beta = -43.75; % the angle that each big branch should rotate relative to the last big branch
CN = 0;
lf = [];
ntip = [];
Itip = [];
smid = repmat('2',1,lfnode);
stip = repmat('2',1,(lfnode-1));

for i=1:length(axiom)
  
    cmdT = axiom(i);
    
    switch cmdT
        case 'd'
            if u == 0 && v == 0
                Rb = R(II)*Rb;
                u = 0;
                v = Rb*sind(h(II));
                w = Rb*cosd(h(II));
                newUVW = rotz(alpha)*[u;v;w];
                alpha = 0;
                u = newUVW(1);
                v = newUVW(2);
                w = newUVW(3);
                newxT = xT + u;
                newyT = yT + v;
                newzT = zT + w;
                
                %cylinder2P(R0, 10, [xT yT zT], [newxT newyT newzT])
                [lfin, NTIP] = plf_nofig(xT, yT, zT, u, v, w, smid, 4, lfnode);
                lf = [lf;lfin];
                ntip = [ntip;NTIP];
                BR(vNd,:) = [true(1) xT yT zT  newxT newyT newzT R0];
                A = repmat(1:lfnode, 4, 1);
                B = reshape(A, [],1);
                B = B + lfnode*(vNd-1);
                Itip = [Itip; B];
                vNd = vNd +1;
                
                CN = CN + 12;
                xT = newxT;
                yT = newyT;
                zT = newzT;
                
            else
            S = 1/sqrt(u^2 + v^2);
            T = sqrt(u^2 + v^2 + w^2);
            U = R(II)*(u*cosd(h(II)) - S*T*v*sind(h(II)));
            V = R(II)*(v*cosd(h(II)) + S*T*u*sind(h(II)));
            W = R(II)*w*cosd(h(II));
            

            newxT = xT + U;
            newyT = yT + V;
            newzT = zT + W;
 
            u = U;
            v = V;
            w = W;
            
            %cylinder2P(R0, 10, [xT yT zT], [newxT newyT newzT])
%             multilf_normrot(4, [xT+u/4, yT+v/4, zT+w/4], [u,v,w], '2', 0)
%             multilf_normrot(4, [xT+2*u/4, yT+2*v/4, zT+2*w/4], [u,v,w], '2', 120)
%             multilf_normrot(4, [xT+3*u/4, yT+3*v/4, zT+3*w/4], [u,v,w], '2', 240)
            [lfin, NTIP] = plf_nofig(xT, yT, zT, u, v, w, smid, 4, lfnode);
            lf = [lf;lfin];
            ntip = [ntip; NTIP];
            %CN = CN + 12;
             BR(vNd,:) = [true(1) xT yT zT  newxT newyT newzT R0];
             A = repmat(1:lfnode, 4, 1);
             B = reshape(A, [],1);
             B = B + lfnode*(vNd-1);
             Itip = [Itip; B];
             vNd = vNd +1;
%             vertsF{vNd} = [xT yT zT ; newxT newyT newzT];
%             vNd = vNd +1;
            
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
            newUVW = rotz(alpha)*[u;v;w];
            alpha = 0;
            u = newUVW(1);
            v = newUVW(2);
            w = newUVW(3);
            newxT = xT + u;
            newyT = yT + v;
            newzT = zT + w;
            %cylinder2P(R0, 10, [xT yT zT], [newxT newyT newzT])

            [lfing, NTIP] = multilf_normrot_nofig(4, [newxT, newyT, newzT], [u,v,w], '1', 0);
            lf = [lf;lfing];
            ntip = [ntip; NTIP];
            [lfin, NTIP] = plf_nofig(xT, yT, zT, u, v, w, stip, 4, lfnode-1);
            ntip = [ntip; NTIP];
            lf = [lf;lfin];
            %CN = CN + 12;
            
            BR(vNd,:) = [false(1) xT yT zT  newxT newyT newzT R0];
            A = repmat(1:lfnode, 4, 1);
            B = reshape(A, [],1);
            B = B + lfnode*(vNd-1);
            Itip = [Itip; B];
            vNd = vNd + 1;
            
            xT = newxT;
            yT = newyT;
            zT = newzT;
            else
            S = 1/sqrt(u^2 + v^2);
            T = sqrt(u^2 + v^2 + w^2);
            U = R(II)*(u*cosd(h(II)) - S*T*v*sind(h(II)));
            V = R(II)*(v*cosd(h(II)) + S*T*u*sind(h(II)));
            W = R(II)*w*cosd(h(II));
            
            newxT = xT + U;
            newyT = yT + V;
            newzT = zT + W;
 
            u = U;
            v = V;
            w = W;
            
            %cylinder2P(R0, 10, [xT yT zT], [newxT newyT newzT])
%             multilf(4, [newxT, newyT, newzT], [u,v,w], '1')
%             multilf_normrot(4, [xT+u/3, yT+v/3, zT+w/3], [u,v,w], '2', 0)
%             multilf_normrot(4, [xT+2*u/3, yT+2*v/3, zT+2*w/3], [u,v,w], '2', 180)
            [lfing, NTIP] = multilf_normrot_nofig(4, [newxT, newyT, newzT], [u,v,w], '1', 0);
            lf = [lf;lfing];
            ntip = [ntip; NTIP];
            [lfin, NTIP] = plf_nofig(xT, yT, zT, u, v, w, stip, 4, lfnode-1);
            lf = [lf;lfin];
            ntip = [ntip; NTIP];
            %CN = CN + 12;
%             vertsG{vNg} = [xT yT zT ; newxT newyT newzT];
%             vNg = vNg +1;
            BR(vNd,:) = [false(1) xT yT zT  newxT newyT newzT R0];
            A = repmat(1:lfnode, 4, 1);
            B = reshape(A, [],1);
            B = B + lfnode*(vNd-1);
            Itip = [Itip; B];
            vNd = vNd + 1;
            xT = newxT;
            yT = newyT;
            zT = newzT;
            end
            
        case '('
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
                alpha = beta*stkPtr;
                
            elseif stkPtr == 2 && Ns == 1
                alpha = beta*stkPtr;         
                
            elseif stkPtr == 3 && Ng == 1
                alpha = beta*stkPtr;
                
            elseif stkPtr == 4 && N3 == 1
                alpha = beta*stkPtr;
            elseif stkPtr == 5 && N4 == 1
                alpha = beta*stkPtr;
            elseif stkPtr == 6 && N5 == 1
                alpha = beta*stkPtr;
            end
            

            stkPtr = stkPtr +1 ;
            II = 3;
            
            
        case '['
            
            if stkPtr == 1
                Ns = 1;
            end
            
            if Ns == 1 && stkPtr == 2
                Ng = 1;
            end
            
            if Ng == 1 && stkPtr == 3
                N3 = 1;
            end
            
            if N3 == 1 && stkPtr == 4
                N4 = 1;
            end
            
            if N4 == 1 && stkPtr == 5
                N5 = 1;
            end
            
            stkPtr = stkPtr +1 ;
            II = 2;
            
        case '+'
            
            
            if stkPtr == 1
                alpha = beta*stkPtr;
                
            elseif stkPtr == 2 && Ns == 1
                alpha = beta*stkPtr;
                Ns = 0;
            
            elseif stkPtr == 3 && Ng == 1
                alpha = beta*stkPtr;
                Ng = 0;
            elseif stkPtr == 4 && N3 == 1
                alpha = beta*stkPtr;
                N3 = 0;
            elseif stkPtr == 5 && N4 == 1
                alpha = beta*stkPtr;
                N4 = 0;
            elseif stkPtr == 6 && N5 == 1
                alpha = beta*stkPtr;
                N5 = 0;
            end
            
            
            stkPtr = stkPtr +1 ;
            II = 1;

        case ')'
            
            stkPtr = stkPtr -1 ;
            xT = stack(stkPtr).xT ;
            yT = stack(stkPtr).yT ;
            zT = stack(stkPtr).zT ;
            u = stack(stkPtr).u ;
            v = stack(stkPtr).v ;
            w = stack(stkPtr).w ;
            R0 = stack(stkPtr).R0;
            Rb = stack(stkPtr).Rb;
    end
    
end


end