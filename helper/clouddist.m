%Tristan Ursell
%Distance Transform for Arbitrary Point Cloud
%March 2012
%
%[Xvec,Yvec,Dist]=clouddist(Xin,Yin,xlim,ylim,res);
%
%The function creates a Euclidean distance transform from an arbitrary set
%of points, which is the in-plane distance to to closest point.  This does
%not require the Image Processing Toolbox, and in fact, can be used as a 
%more versatile version of 'bwdist' transform.
%
%(Xin, Yin) are a list of input points from which to calculate the distance
%transform.
%
%'xlim' and 'ylim' are each two component vectors that specify the extent
%of the distance transform calcualtion.
%
%'res' sets the spatial resolution of the distance transform.  For instance
%is the image goes from -1,1 in both X and Y, you might set res = 0.01,
%giving you 201 points along each dimension.  Generally, good practice is
%the have 'res' set to be much less than the closest distance between any
%two points.
%
%The output vectors 'Xvec' and 'Yvec' specify the exact points at which the
%distance transform 'Dist' has been calculated.
%
%see also: bwdist
%
%Example: general points in 2D
%
%Xin=rand(1,50);
%Yin=rand(1,50);
%xlim=[-1/2,3/2];
%ylim=[-1/2,3/2];
%res=0.01;
%
%[Xvec,Yvec,Dist]=clouddist(Xin,Yin,xlim,ylim,res);
%
%figure;
%hold on
%imagesc(Xvec,Yvec,Dist)
%plot(Xin,Yin,'wx')
%title('Point Cloud Distance Transform')
%xlabel('X')
%ylabel('Y')
%axis equal tight
%box on
%
%Example: mimicing the bwdist transform
%
%Xin=ceil(249*rand(1,50));
%Yin=ceil(199*rand(1,50));
%xlim=[1,250];
%ylim=[1,200];
%res=1;
%
%[Xvec,Yvec,Dist]=clouddist(Xin,Yin,xlim,ylim,res);
%
%figure;
%hold on
%imagesc(Xvec,Yvec,Dist)
%plot(Xin,Yin,'wx')
%title('Point Cloud Distance Transform')
%xlabel('X')
%ylabel('Y')
%axis equal tight
%box on
%

function [Xvec,Yvec,Dist]=clouddist(Xin,Yin,xlim,ylim,res)

%*********PARSE INPUTS**********

%check input lengths
if length(Xin)~=length(Yin)
    error('Input vectors must be the same length.')
end

%check limits
if or(max(size(xlim))~=2,max(size(ylim))~=2)
    error('The limits should be a vector of length two, with the the second value greater than the first.')
end

%get number of input points
npts=length(Xin);

%check res
if npts<2
    error('There must be two or more points.')
end

%get limits
xmin=min(xlim);
xmax=max(xlim);
ymin=min(ylim);
ymax=max(ylim);

%check limits w.r.t. res
if or((xmax-xmin)<=res,(ymax-ymin)<=res)
    error('The maximum limit cannot be less than the minimum limit, and their differences must be greater than the resolution.')
end

%create position vectors
Xvec=xmin:res:xmax;
Yvec=ymin:res:ymax;

%create position matrices
Xmat = ones(length(Yvec),1)*Xvec;
Ymat = Yvec'*ones(1,length(Xvec));
    
Dist=Inf*ones(length(Yvec),length(Xvec));

for i=1:npts
    %calculate current distances and perform replacements
    Dmat = sqrt((Xmat-Xin(i)).^2 + (Ymat-Yin(i)).^2);
    
    %perform replacements
    W=Dmat<Dist;
    Dist(W)=Dmat(W);
end
































