load Iris_clusterEnsemlbe_data.mat;
Params.K = 3;

E = base_labels;
[clustIncidence, DebugInfo] = RunBCEScheme(E, Params);