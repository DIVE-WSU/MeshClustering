function [H1,H2,residual]=co_evol_lin_imp(A,K,mu,repli,niter,torr,warning_msg)


if ismatrix(A)&&~iscell(A)
    A_temp=A;
    A=cell(1,1);
    A{1}=A_temp;
end
time=length(A);

if (size(K,1)-1)*(size(K,2)-1)~=0 || (length(K)-1)*(length(K)-time)~=0
    error('co_evol_nmf_imp: size parameter K must be an array or a scale')
end

if length(K)==1
    temp=K;
    K=temp*ones(size(A));
end
for i=1:time

    K(i)=floor(max(abs(K(i)),1));
end

repli=floor(max(abs(repli),1));
if niter<10
    warning('number of iteration is set to 10');
    niter=10;
else
    niter=floor(niter);
end
torr=abs(torr);
H1=cell(size(A));
H2=cell(size(A));
residual=cell(size(A));


for i=1:time
    Ac=A{i};
    [m,n]=size(Ac);

    k=K(i);
    
    if i==1
        y1=0;
        y2=0;
    else
        h1_previous=H1{i-1};
        h2_previous=H2{i-1};
        y1=h1_previous.*(ones(m,1)*sum(h2_previous,1));
        y2=h2_previous.*(ones(n,1)*sum(h1_previous,1));
    end

    for irepli=1:repli
        
        h1=rand(m,k);
        h2=rand(n,k);
        hw=h1*h2';
        diff=max(1,torr);
        r_best=sum(sum((hw-Ac).^2));
        h1_best=h1;
        h2_best=h2;
        iter=0;
            while diff>=torr && iter<niter
                C=Ac./(h1*h2');
                h1_new=2*h1.*(C*h2)+2*mu*y1;
                h2_new=2*h2.*(C'*h1)+2*mu*y2;
                h1_norm=sqrt(sum(h1_new.^2,1));
                h2_norm=sqrt(sum(h2_new.^2,1));
                h1_new=h1_new./(ones(m,1)*h1_norm);
                h2_new=h2_new./(ones(n,1)*h2_norm);
                
                diff=max(max(abs(h1-h1_new)));
                h1=h1_new;
                h2=h2_new;                
                resi=sum(sum((Ac-h1*h2').^2));
                iter=iter+1; 
            end
            if diff>torr && iter>=niter && strcmpi(warning_msg,'on')
                 warning(['co_evol_nmf_imp: convergence failed after ' num2str(niter) ' iterations'])
            end
            if irepli==1 || (irepli>1 && resi<r_best)
                r_best=resi;
                h1_best=h1;
                h2_best=h2;
                
            end
            H1{i}=h1_best;
            H2{i}=h2_best;
            residual{i}=r_best;
    end
    
    
end