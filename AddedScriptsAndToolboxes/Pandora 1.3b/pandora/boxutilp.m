function outlier=boxutilp(x,notch,lb,lf,sym,vert,whis,whissw,props)

% BOXUTILP - Produces a single box plot.
%
% Description:
%   BOXUTILP(X) is a utility function for BOXPLOT, which calls
%   BOXUTILP once for each column of its first argument. Use
%   BOXPLOT rather than BOXUTILP. 

% Modified by Cengiz Gunay <cgunay@emory.edu>, 2004/11/12
%   Made outlier display optional.

%   Copyright 1993-2002 The MathWorks, Inc. 
% $Revision: 1334 $  $Date: 2012-04-19 14:02:13 -0400 (Thu, 19 Apr 2012) $

if ~ exist('props', 'var')
  props = struct([]);
end

% Make sure X is a vector.
if min(size(x)) ~= 1, 
    error('First argument has to be a vector.'); 
end

if nargin < 8
    error('Requires eight input arguments.');
end

% define the median and the quantiles
pctiles = prctile(x,[25;50;75]);
q1 = pctiles(1,:);
med = pctiles(2,:);
q3 = pctiles(3,:);

% find the extreme values (to determine where whiskers appear)
vhi = q3+whis*(q3-q1);
upadj = max(x(x<=vhi));
if (isempty(upadj)), upadj = q3; end

vlo = q1-whis*(q3-q1);
loadj = min(x(x>=vlo));
if (isempty(loadj)), loadj = q1; end

x1 = lb*ones(1,2);
x2 = x1+[-0.25*lf,0.25*lf];
outlier = x<loadj | x > upadj;
yy = x(outlier);

if isempty(yy)
   yy = loadj;
   [a1 a2 a3 a4] = colstyle(sym);
   sym = [a2 '.'];
end

xx = lb*ones(1,length(yy));
    lbp = lb + 0.5*lf;
    lbm = lb - 0.5*lf;

if whissw == 0
   upadj = max(upadj,q3);
   loadj = min(loadj,q1);
end

% Set up (X,Y) data for notches if desired.
if ~notch
    xx2 = [lbm lbp lbp lbm lbm];
    yy2 = [q3 q3 q1 q1 q3];
    xx3 = [lbm lbp];
else
    n1 = med + 1.57*(q3-q1)/sqrt(length(x));
    n2 = med - 1.57*(q3-q1)/sqrt(length(x));
    if n1>q3, n1 = q3; end
    if n2<q1, n2 = q1; end
    lnm = lb-0.25*lf;
    lnp = lb+0.25*lf;
    xx2 = [lnm lbm lbm lbp lbp lnp lbp lbp lbm lbm lnm];
    yy2 = [med n1 q3 q3 n1 med n2 q1 q1 n2 med];
    xx3 = [lnm lnp];
end
yy3 = [med med];

%# Remove outlier vectors if specified
if isfield(props, 'nooutliers'), xx = []; yy = []; end

% Determine if the boxes are vertical or horizontal.
% The difference is the choice of x and y in the plot command.
if vert
    plot(x1,[q3 upadj],'b-',x1,[loadj q1],'b-',...
        x2,[loadj loadj],'k-',...
        x2,[upadj upadj],'k-',xx2,yy2,'b-',xx3,yy3,'r-',xx,yy,sym)
else
    plot([q3 upadj],x1,'b-',[loadj q1],x1,'b-',...
        [loadj loadj],x2,'k-',...
        [upadj upadj],x2,'k-',yy2,xx2,'b-',yy3,xx3,'r-',yy,xx,sym)
end

