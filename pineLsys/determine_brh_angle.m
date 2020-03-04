
% this function is to determine GMT4 linear model
function IND = determine_brh_angle(stkPtr)

N = length(stkPtr);

ns1 = 0;
ns2 = 0;
ns3 = 0;
ns4 = 0;
ns5 = 0;
ns6 = 0;
ns7 = 0;
ns8 = 0;
ns9 = 0;
ns10 = 0;
ns11 = 0;
ns12 = 0;
ns13 = 0;


for i = 1:N
    if stkPtr(i) == 1
        ns1 = ns1 + 1;
        ns2 = 0;
        IND(i) = ns1;
        
    elseif stkPtr(i) == 2
        ns2 = ns2 + 1;
        ns3 = 0;
        IND(i) = ns1 + ns2;
        
    elseif stkPtr(i) == 3
        ns3 = ns3 + 1;
        ns4 = 0;
        IND(i) = ns1 + ns2 + ns3;
        
    elseif stkPtr(i) == 4
        ns4 = ns4 + 1;
        ns5 = 0;
        IND(i) = ns1 + ns2 + ns3 + ns4;
        
    elseif stkPtr(i) == 5
        ns5 = ns5 + 1;
        ns6 = 0;
        IND(i) = ns1 + ns2 + ns3 + ns4 + ns5;
        
    elseif stkPtr(i) == 6
        ns6 = ns6 + 1;
        ns7 = 0;
        IND(i) = ns1 + ns2 + ns3 + ns4 + ns5 + ns6;
        
    elseif stkPtr(i) == 7
        ns7 = ns7 + 1;
        ns8 = 0;
        IND(i) = ns1 + ns2 + ns3 + ns4 + ns5 + ns6 + ns7;
        
    elseif stkPtr(i) == 8
        ns8 = ns8 + 1;
        ns9 = 0;
        IND(i) = ns1 + ns2 + ns3 + ns4 + ns5 + ns6 + ns7 + ns8;
        
    elseif stkPtr(i) == 9
        ns9 = ns9 + 1;
        ns10 = 0;
        IND(i) = ns1 + ns2 + ns3 + ns4 + ns5 + ns6 + ns7 + ns8 + ns9;
        
    elseif stkPtr(i) == 10
        ns10 = ns10 + 1;
        ns11 = 0;
        IND(i) = ns1 + ns2 + ns3 + ns4 + ns5 + ns6 + ns7 + ns8 + ns9 + ns10;
        
    elseif stkPtr(i) == 11
        ns11 = ns11 + 1;
        ns12 = 0;
        IND(i) = ns1 + ns2 + ns3 + ns4 + ns5 + ns6 + ns7 + ns8 + ns9 + ns10 + ns11;
        
    elseif stkPtr(i) == 12
        ns12 = ns12 + 1;
        ns13 = 0;
        IND(i) = ns1 + ns2 + ns3 + ns4 + ns5 + ns6 + ns7 + ns8 + ns9 + ns10 + ns11 + ns12;
        
    end


end