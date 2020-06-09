%%谱聚类
X=zscore(B);
N = size(X,1);
squared_X = sum(X.*X,2);
transi_X = X*X';
X_i = repmat(squared_X,1,N);
X_j = repmat(squared_X',N,1);
E = -(X_i + X_j - 2*transi_X );
W = exp(E/(2*4));
W = W - diag(diag(W));
D = diag(sum(W'));
L =D^(-.5)*W*D^(-.5);
K = 4;
[Q,V] = eigs(L,4);
Q = Q./repmat(sqrt(diag(Q'*Q)'),N,1);
idx4= kmeans(Q,4);
histogram(idx4);
%%将idx4矩阵内容复制到B矩阵,并将B矩阵每行分别复制24遍
B(:,6)=idx4(:,1);
B=B;
C=[];
for i=1:791
   C=[C;repmat(B(i,1:6),24,1)]
end
%%由于数据的原因需要将第一天的数据删除一行（手动执行）
%%分离出四个不同类别的样本数据
F=A(:,1:13);
F(:,14:19)=C(:,1:6);
F1=[];F2=[];F3=[];F4=[];
for i=1:18983
    if F(i,19)==1
        F1=[F1;F(i,1:13)]
    elseif F(i,19)==2
        F2=[F2;F(i,1:13)]
    elseif F(i,19)==3
        F3=[F3;F(i,1:13)]
    else
        F4=[F4;F(i,1:13)]
    end
end