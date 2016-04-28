function coordsNew = elastic(coordsOrig, coordsTarget, tris)

% a simple elastic finite element solver
% Andrey Chernikov (achernik@cs.odu.edu)
% April 2012

E = 800.0;
nu = 0.25;
m0 = E / (1.0 - nu * nu);
m1 = m0 * nu;
m2 = m0 * 0.5 * (1.0 - nu);
EM = [ m0,  m1, 0.0;
       m1,  m0, 0.0;
      0.0, 0.0,  m2];
  
n = size(coordsTarget, 1);
n2 = 2 * n;
m = size(coordsOrig, 1);
m2 = 2 * m;

KK = sparse(m2, m2);
I = zeros(6, 1);
for i = 1 : size(tris, 1)
    T = tris(i, :);
    T2 = T * 2;
    C = coordsOrig(T, :);
    C32 = C(3, :) - C(2, :);
    C21 = C(2, :) - C(1, :);
    C13 = C(1, :) - C(3, :);
    d = C(1, 2) * C32(1) + C(2, 2) * C13(1) + C(3, 2) * C21(1);
    B = [-C32(2),     0.0, -C13(2),     0.0, -C21(2),    0.0;
             0.0,  C32(1),     0.0,  C13(1),     0.0,  C21(1);
          C32(1), -C32(2),  C13(1), -C13(2),  C21(1), -C21(2)];
    K = B' * EM * B * (0.5 / d);
    I(1 : 2 : end) = T2 - 1;
    I(2 : 2 : end) = T2;
    KK(I, I) = KK(I, I) + K;
end

for i = 1 : n2
    for j = 1 : m2
        KK(i, j) = 0.0;
    end
    KK(i, i) = 1.0;
end

bb = zeros(m2, 1);
bb(1 : 2 : n2) = coordsTarget(:, 1) - coordsOrig(1 : n, 1);
bb(2 : 2 : n2) = coordsTarget(:, 2) - coordsOrig(1 : n, 2);

uu = KK \ bb;

coordsNew = zeros(size(coordsOrig));
coordsNew(1 : n, :) = coordsTarget;
coordsNew(n + 1 : m, 1) = coordsOrig(n + 1 : m, 1) + ...
                          uu(n2 + 1 : 2 : m2);
coordsNew(n + 1 : m, 2) = coordsOrig(n + 1 : m, 2) + ...
                          uu(n2 + 2 : 2 : m2);

end