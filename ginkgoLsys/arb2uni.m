function [q, Norm] = arb2uni(p)
% transfer arbitrary vector to unit vectors
% Input: p, N*3,
% Output: q, N*3
%         Norm, the norm of each vector in column vector

N = size(p,1);
q = zeros(N,3);
Norm = zeros(N,1);
for i = 1: N
    Norm(i) = norm(p(i,:));
    q(i,:) = p(i,:)./Norm(i);
end

