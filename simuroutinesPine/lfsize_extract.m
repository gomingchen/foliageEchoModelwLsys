% To sample leaf radii from truncated normal
% Created by Chen Ming, Date:  11/01/2016
function leaf_dia = lfsize_extract(leaf_param, n_leaf)

leaf_size_dist = leaf_param.leafsize_dist;
mleaf_size = leaf_param.leafsize_supp;
leaf_size_sup = leaf_param.leafsize_supp;

switch leaf_size_dist
    case 'uni'
        
        % Generate the leaf sizes from a uniform distribution
        
        % parameters for uniform distribution
        
        if (length(leaf_size_sup) == 2)
            a_leaf = leaf_size_sup(1);
            b_leaf = leaf_size_sup(2);
        else
            error('Wrong input');
        end
        
        leaf_dia = random('Uniform',a_leaf,b_leaf,n_leaf,1);

    case 'gauss'
        %%% Generate the leaf sizes from a gaussian distribution
        
        % parameters for normal distribution
        
          leaf_rds_mean = mleaf_size;
          leaf_rds_sigma = 0.1*mleaf_size;

          pd = makedist('Normal','mu',leaf_rds_mean,'sigma',leaf_rds_sigma);
          tr = truncate(pd,0,1);
          leaf_dia = random(tr, n_leaf,1);

end
end