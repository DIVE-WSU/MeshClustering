function [IDX,IDY,B,ierr,ferr,proX,proY]=exe_co_evol_nmf(varargin)
% co_evol_lin_imp and co_evol_bvd_imp are incorporated into this function

if nargin<1
    error ('no input matrix cell')
end
A=varargin{1};

if ismatrix(A) && ~iscell(A)
    A_temp=cell(1);
    A_temp{1}=A;
    A=A_temp;
end
if ~iscell(A)
    error('input must be a cell or a matrix')
end
nframe=length(A);
B=cell(size(A));

K=0;
L=0;
am=0;               % alpha or mu
repli=0;
niter=0;
torr=0;
pc='';
opt='';
ici=0;
warning_msg='off';

if nargin>1
    for iargin=2:2:nargin
     
        if strcmpi(varargin{iargin},'K')
            K=varargin{iargin+1};
        elseif strcmpi(varargin{iargin},'L')
            L=varargin{iargin+1};
        elseif strcmpi(varargin{iargin},'cluster')
            K=varargin{iargin+1};
            L=K;
        elseif strcmpi(varargin{iargin},'mu')
            mtd='lin';
            am=varargin{iargin+1};
        elseif strcmpi(varargin{iargin},'alpha')
            mtd='bvd';
            am=varargin{iargin+1};
        elseif strcmpi(varargin{iargin},'repli')
            repli=varargin{iargin+1};
        elseif strcmpi(varargin{iargin},'iter')
            niter=varargin{iargin+1};
        elseif strcmpi(varargin{iargin},'torr')
            torr=varargin{iargin+1};    
        elseif strcmpi(varargin{iargin},'mtd')
            mtd=varargin{iargin+1};
        elseif strcmpi(varargin{iargin},'opt')
            opt=varargin{iargin+1};    
        elseif strcmpi(varargin{iargin},'pc')
            mtd='bvd';
            pc=varargin{iargin+1};
        elseif strcmpi(varargin{iargin},'warning')
            warning_msg=varargin{iargin+1};
        elseif strcmpi(varargin{iargin},'cmp')
            CI=varargin{iargin+1};
            if ~(iscell(CI) && ismatrix(CI))
                error('cmp parameter must be a matrix cell')
            elseif size(CI,1)~=length(A) || size(CI,2)~=2
                error('cmp parameter cell dimension is wrong')
            else
                for iframe=1:nframe
                    if ~(length(CI{iframe,1})==size(A{iframe},1) && length(CI{iframe,2})==size(A{iframe},2))
                        error('cmp parameter cell dimension is wrong')
                    end
                end
            end
            ici=1;
        end
    end
end

if ~strcmpi(pc,'pcm')       % default pc is pcq
    pc='pcq';
end
if ~(K>1) && length(K)==1    % default k is 2
    K=2;
end
if ~(L>1) && length(L)==1    % default l is 2
    L=2;
end

if length(K)==1
    temp=K;
    K=temp*ones(size(A));
end
if length(L)==1
    temp=L;
    L=temp*ones(size(A));
end

if strcmpi(mtd,'lin') || ~strcmpi(mtd,'bvd')
    cluster=L;
    L=K;
    if ~strcmpi(mtd,'lin')
        disp('using default method probability model by Lin')
    end
    [H1,H2,~] = co_evol_lin_imp(A,K,am,repli,niter,torr,warning_msg);
elseif strcmpi(mtd,'bvd')
    [R,~,C,~]=co_evol_bvd_imp(A,K,L,am,repli,niter,torr,pc,warning_msg);
    H1=R;
    H2=cell(size(C));
    for i=1:length(C)
        H2{i}=C{i}';
    end
end

row=cell(size(A));          % empty row list
column=cell(size(A));       % empty column list
    

idx=cell(size(H1));
idy=cell(size(H2));
IDX=cell(size(H1));
IDY=cell(size(H2));
proX=cell(size(H1));
proY=cell(size(H2));
for iframe=1:nframe
    [m,n]=size(A{iframe});
    b=zeros(m,n);

    [~,IDX{iframe}]=max(H1{iframe},[],2);
    [~,IDY{iframe}]=max(H2{iframe},[],2);
    
    h1temp=H1{iframe};
    proX{iframe}=h1temp./(sum(h1temp,2)*ones(1,size(h1temp,2)));
    h2temp=H2{iframe};
    proY{iframe}=h2temp./(sum(h2temp,2)*ones(1,size(h2temp,2)));

    % rerange order
    idx{iframe}=zeros(1,m);
    idy{iframe}=zeros(1,n);
    k=0;
    for i=1:K(iframe)
        for j=1:length(IDX{iframe})
            if IDX{iframe}(j)==i
                k=k+1;
                if isempty(row{iframe})
                    idx{iframe}(k)=j;
                else
                    idx{iframe}(k)=row{iframe}(j);
                end
            end
        end
    end

    k=0;
    for i=1:L(iframe)
        for j=1:length(IDY{iframe})
            if IDY{iframe}(j)==i
                k=k+1;
                if isempty(column{iframe})
                    idy{iframe}(k)=j;
                else
                    idy{iframe}(k)=column{iframe}(j);
                end
            end
        end
    end

    
    for i=1:length(IDX{iframe})
        for j=1:length(IDY{iframe})
            b(i,j)=A{iframe}(idx{iframe}(i),idy{iframe}(j));
        end
    end
    B{iframe}=b;
    
    if strcmpi(opt,'f')
        bmax=max(max(b));
        figure;imagesc(bmax-b);colormap(gray);title(['t=' num2str(iframe-1)])
    end
    
end
 
    

ierr=[];
ferr=[];
if ici
    ierr=zeros(nframe,1);
    ferr=zeros(nframe,1);

    for iframe=1:nframe
        for i=1:K(iframe)
            isum=length(CI{iframe,1});
            for j=1:K(iframe)
                isum=min(isum,sum(abs((CI{iframe,1}==i)-(IDX{iframe}==j))));
            end
            ierr(iframe)=ierr(iframe)+isum;
        end        
        ierr(iframe)=0.5*ierr(iframe)/size(A{iframe},1);
        for i=1:L(iframe)
            fsum=length(CI{iframe,2});
            for j=1:L(iframe)
                fsum=min(fsum,sum(abs((CI{iframe,2}==i)-(IDY{iframe}==j))));
            end
            ferr(iframe)=ferr(iframe)+fsum;
        end        
        ferr(iframe)=0.5*ferr(iframe)/size(A{iframe},2);        
    end
end
end
