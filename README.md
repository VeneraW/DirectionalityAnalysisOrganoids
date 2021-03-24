# DirectionalityAnalysisOrganoids
Deposit of matlab code written to analyze directions of single cells in fish organoids

This Matlab script provides a quick analysis of tracks in terms of directionality for single cell trajectories in fish organoids. The script is written by no IT specialists. 
The script requires *.xml file with tracks of single cells obtained with Trackmate plugin for Fiji and matlab script for fast loading and analysis of these tracks, called MSDanalyzer. Both tools were developed previously by J-Y Tinevez et al., please find references below for documentation and references. 
The script assumes axis specification in the data such that z coordinate can be omitted, and sample is positioned in X and Y plane.  
The input parameters for the script are:
file – path and filename, i.e. My/Own/Path/Tracks.xml
Centre – X and Y coordinated, corresponding to the centre of an organoid, i.e. [X,Y]
The script returns:
Phi – angle in radians of each track 
Dir – subset of angles which are moving towards the centre of an organoid, selected based on directionality of tracks in each quadrant of a specimen. 

Original tracks, labelled by TrackID

![image](https://user-images.githubusercontent.com/18525857/112373902-c07ed580-8ce1-11eb-8d40-c5b0b7b7368f.png)

Tracks centered with respect to the organoid and labelled based on quadrant of a specimen (black tracks are virtually crossing symmetry line and are ommited in further processing)

![image](https://user-images.githubusercontent.com/18525857/112373979-d8565980-8ce1-11eb-87bb-a6f111c4b5c2.png)

Distribution of tracks in terms of angular direction and direction with respect to the center of an organoid (light gray outward movement, dark gray inward movement)

![image](https://user-images.githubusercontent.com/18525857/112374012-e3a98500-8ce1-11eb-99e1-799c3589b924.png)

The script was developed by: 
Lucie Zilova, Venera Weinhardt, Tinatini Tavhelidse, Thomas Thumberger, Joachim Wittbrodt. Fish primary embryonic stem cells self-assemble into retinal tissue mirroring in vi early eye development. Preprint on bioRxiv: https://doi.org/10.1101/2021.01.28.428593 

Trackmate was developed by:
Jean-Yves Tinevez, Nick Perry, Johannes Schindelin, Genevieve M. Hoopes, Gregory D. Reynolds, Emmanuel Laplantine, Sebastian Y. Bednarek, Spencer L. Shorte, Kevin W. Eliceiri, TrackMate: An open and extensible platform for single-particle tracking, Methods, Available online 3 October 2016, ISSN 1046-2023, http://dx.doi.org/10.1016/j.ymeth.2016.09.016. (http://www.sciencedirect.com/science/article/pii/S1046202316303346)
And can be found here:
https://github.com/fiji/TrackMate
MSDanalyzer was developed by:
Nadine Tarantino, Jean-Yves Tinevez, Elizabeth Faris Crowell, Bertrand Boisson, Ricardo Henriques, Musa Mhlanga, Fabrice Agou, Alain Israël, and Emmanuel Laplantine. TNF and IL-1 exhibit distinct ubiquitin requirements for inducing NEMO-IKK supramolecular structures. J Cell Biol (2014) vol. 204 (2) pp. 231-45
And can be found here:
http://tinevez.github.io/msdanalyzer/
