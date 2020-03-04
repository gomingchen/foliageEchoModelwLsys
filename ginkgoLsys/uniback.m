function original = uniback( A, B)
% Transform the unit vectors back to original ones
% Inputs: A, N*3, unit vectors
%         B, N*1, norm of each vector
N = length(B);

original = zeros(N,3);
for i = 1: N
original(i,:) = B(i)*A(i,:);
end

end

