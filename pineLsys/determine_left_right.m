
function index = determine(stkPtr)
% input: stkPtr, the vector of all the stkPtr values for '['
% output: index, angle = (-1)^index, vector

N = length(stkPtr);
index = zeros(1,N);
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

for i = 1:N
    if stkPtr(i) == 1
        ns1 = ns1 + 1;
        ns2 = 0;
        index(i) = (-1)^rem(ns1,2);
        
    elseif stkPtr(i) == 2 
        ns2 = ns2 + 1;
        ns3 = 0;
        if rem(ns1,2) == 1
            index(i) = (-1)^rem(ns2,2);
        else
            index(i) = (-1)^(1 + rem(ns2,2));
        end
        
    elseif stkPtr(i) == 3
        ns3 = ns3 + 1;
        ns4 = 0;
        if rem(ns2,2) == 1
            index(i) = (-1)^rem(ns3,2)*(-1)^(1 + rem(ns1,2));
        else
            index(i) = (-1)^(1 + rem(ns3,2))*(-1)^(1 + rem(ns1,2));
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%
    elseif stkPtr(i) == 4
        ns4 = ns4 + 1;
        ns5 = 0;
        if rem(ns3,2) == 1
            index(i) = (-1)^rem(ns4,2)*(-1)^(1 + rem(ns1,2))*(-1)^(1 + rem(ns2,2));
        else
            index(i) = (-1)^(1 + rem(ns4,2))*(-1)^(1 + rem(ns1,2))*(-1)^(1 + rem(ns2,2));
        end
    elseif stkPtr(i) == 5
        ns5 = ns5 + 1;
        ns6 = 0;
        if rem(ns4,2) == 1
            index(i) = (-1)^rem(ns5,2)*(-1)^(1 + rem(ns1,2))*(-1)^(1 + rem(ns2,2))*(-1)^(1 + rem(ns3,2));
        else
            index(i) = (-1)^(1 + rem(ns5,2))*(-1)^(1 + rem(ns1,2))*(-1)^(1 + rem(ns2,2))*(-1)^(1 + rem(ns3,2));
        end
    elseif stkPtr(i) == 6
        ns6 = ns6 + 1;
        ns7 = 0;
        ns = [ns1 ns2 ns3 ns4];
        cor = 1;
            for j = 1:length(ns)
                cor = cor*(-1)^(1 + rem(ns(j),2));
            end
        if rem(ns5,2) == 1
            index(i) = (-1)^rem(ns6,2)*cor;
        else
            index(i) = (-1)^(1 + rem(ns6,2))*cor;
        end
        
    elseif stkPtr(i) == 7
        ns7 = ns7 + 1;
        ns8 = 0;
        cor = 1;
        ns = [ns1 ns2 ns3 ns4 ns5];
            for j = 1:length(ns)
                cor = cor*(-1)^(1 + rem(ns(j),2));
            end
        
        if rem(ns6, 2) == 1
            index(i) = (-1)^rem(ns7,2)*cor;
        else
            index(i) = (-1)^(1 + rem(ns7,2))*cor;
        end
        
    elseif stkPtr(i) == 8
        ns8 = ns8 + 1;
        ns9 = 0;
        ns = [ns1 ns2 ns3 ns4 ns5 ns6];
        cor = 1;
        for j = 1:length(ns)
            cor = cor*(-1)^(1+rem(ns(j),2));
        end
        
        if rem(ns7, 2) == 1
            index(i) = (-1)^rem(ns8,2)*cor;
        else
            index(i) = (-1)^(1 + rem(ns8,2))*cor;
        end
            
            
    elseif stkPtr(i) == 9
        ns9 = ns9 + 1;
        ns10 = 0;
        ns = [ns1 ns2 ns3 ns4 ns5 ns6 ns7];
        cor = 1;
        for j = 1:length(ns)
            cor = cor*(-1)^(1+rem(ns(j),2));
        end
        
        if rem(ns8, 2) == 1
            index(i) = (-1)^rem(ns9,2)*cor;
        else
            index(i) = (-1)^(1 + rem(ns9,2))*cor;
        end
        
    elseif stkPtr(i) == 10
        ns10 = ns10 + 1;
        ns11 = 0;
        ns = [ns1 ns2 ns3 ns4 ns5 ns6 ns7 ns8];
        cor = 1;
        for j = 1:length(ns)
            cor = cor*(-1)^(1+rem(ns(j),2));
        end
        
        if rem(ns9, 2) == 1
            index(i) = (-1)^rem(ns10,2)*cor;
        else
            index(i) = (-1)^(1 + rem(ns10,2))*cor;
        end
        
    elseif stkPtr(i) == 11
        ns11 = ns11 + 1;
        ns12 = 0;
        ns = [ns1 ns2 ns3 ns4 ns5 ns6 ns7 ns8 ns9];
        cor = 1;
        for j = 1:length(ns)
            cor = cor*(-1)^(1+rem(ns(j),2));
        end
        
        if rem(ns10, 2) == 1
            index(i) = (-1)^rem(ns11,2)*cor;
        else
            index(i) = (-1)^(1 + rem(ns11,2))*cor;
        end
        
    elseif stkPtr(i) == 12
        ns12 = ns12 + 1;
        ns13 = 0;
        ns = [ns1 ns2 ns3 ns4 ns5 ns6 ns7 ns8 ns9 ns10];
        
        cor = 1;
        for j = 1:length(ns)
            cor = cor*(-1)^(1+rem(ns(j),2));
        end
        
        if rem(ns11, 2) == 1
            index(i) = (-1)^rem(ns12,2)*cor;
        else
            index(i) = (-1)^(1 + rem(ns12,2))*cor;
        end
        
        
    end
    
end
        
        
       


end