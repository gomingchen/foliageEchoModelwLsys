# foliageEchoModelwLsys
Instead of uniform distribution, the leaves (scatters/discs) are distributed according to L-system to mimic the lifelike tree geometry
## Ginkgo examples
A ginkgo tree generated from L-system in this model. A leaf is approximated as a disc. Note: the branches are not included in the scattering model. They are plotted for illustration purposes.

![a Ginkgo tree grown in L-system](/figures/ginkgoNreps5.png)


Sonar beam ensonified part of the tree (illustrated in red). The echoes are shown in the top right corner, and the ensonified leaves are shown in top left corner from top view.
![a Ginkgo tree with echoes](/figures/clustered.png)

## Pine examples
![a dense pine tree](/figures/pine_wleafColor.eps)

# How to run the code:
### Ginkgo growth pattern
Run simu_Ginkgo_beamexpand.m or simu_Ginkgo_beamexpand_ellip.m

### Pine growth pattern
Run simu_pine_scan.m

## Citation
[1] Ming C, Zhu H and Mueller R (2017) A simplified model of biosonar echoes from foliage and the
properties of natural foliages. *PLoS ONE* 12(12): e0189824. [(Open article)](https://journals.plos.org/plosone/article/file?type=printable&id=10.1371/journal.pone.0189824)
