function distance = compareL1Norm_Manhattan(FeatureVect1, FeatureVect2)
     %  Calculate the L1 distance between two feature vectors.
     distance = sum(abs(FeatureVect1 - FeatureVect2));
return;