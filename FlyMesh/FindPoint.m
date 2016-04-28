%Daming Feng
%04/09/2013

function p=FindPoint(L, a, b, s0, tol)
x0 = s0(1,1);
y0 = s0(1,2);
x1 = -a;
y1 = 0;
s1=[x1 y1];
while 1
    midx = 0.5 * (x0 + x1);
    midy = b*sqrt(1-midx^2./a^2);
    p=[midx midy];
    % s0 - mid > L
    len=norm(s0-p);
    if (abs(L - len) < tol)
        break
    end
    if (L < len)
        x1 = midx;
    else
        x0 = midx;
    end
end