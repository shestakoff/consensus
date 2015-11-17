function bKmeans = bestKmeans(X,Ensemble)

criteria = kmeanscrit(Ensemble,X);

[~,minIdx] = min(criteria);

bKmeans = Ensemble(:,minIdx);
