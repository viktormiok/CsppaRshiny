<img src="https://github.com/viktormiok/viktormiok.wordpress.com/blob/main/software/csppaRshiny.png" align="right" height="200" width="200">

![](https://img.shields.io/badge/language-R-orange.svg) ![version](https://img.shields.io/badge/GiHub_version-1.1.0-519dd9) ![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/viktormiok/tigaR) ![GitHub issues](https://img.shields.io/github/issues/viktormiok/tigaR)

![dependencies](https://img.shields.io/badge/dependencies-up%20to%20date-orange)  	![commit](https://img.shields.io/github/last-commit/viktormiok/tigaR) ![GitHub](https://img.shields.io/github/license/viktormiok/tigaR)

[![Edit with Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/viktormiok/tigaR) 


# CsppaRshiny

- [Overview](#overview)
  * [Application](#application)
- [How to Run the App](#how-to-run-the-app)
- [Data](#data)
- [Tutorials](#tutorials)
- [License](#license)
- [References](#references)

## Overview
The R Shiny app __`CsppaRshiny`__ performs machine learning analysis and visualization of cellular spatial point patterns under hypercaloric diet shifts, and it is based on [__`Csppa`__](https://github.com/viktormiok/Csppa) R-package.

The application visualizes spatial point pattern density plots in 3D and 2D, allowing flexibility in representing the data and emphasizing the question of interest. It also provides for overall and local significance analysis of spatial point pattern densities, employing several statistical approaches.

K-Nearest Neighbour and Random Forest classification algorithms are implemented to compare the grouping of the cells expressing different markers within and between the diets. Additionally, the correlation and spatial autocorrelation of cells expressing different markers can be compared using the Mantel and Moran's I tests, respectively.

<img src="https://user-images.githubusercontent.com/22052679/150276878-dbb3b1b9-105f-4a72-8358-9e019a74b962.png" height="800" width="900">

### Application

Here, we focus on astrocytes from the arcuate nucleus of the mouse brain and the expression of Gfap and Aldh1l1 genes, recovering spatial point patterns under a standard chow (SC), 5-day, and 15-day high-fat high-sugar (HFHS) diets. The R-package __`Csppa`__ allows for assessing whether these astrocyte populations are spatially organized and whether they tend to form local identical clusters in response to an HFHS diet over time. The algorithm evaluates the spatial coherence of each astrocytic subtype—reflecting the similarity between neighbouring cells—under different conditions (SC, 5d, or 15d HFHS diet) by applying Moran’s I spatial autocorrelation coefficient, a recognised measure of spatial dispersion. Additionally, the use of a random forest classifier enables the delineation of feature space partitions shared by astrocytes expressing Gfap and Aldh1l1 across experimental groups.

## How to Run the App
To run the __`CsppaRshiny`__ app locally, ensure all dependencies are installed. Open the app.R file in RStudio and click Run App. Before launching, either load the functions from the R folder into RStudio or install the R-package [__`Csppa`__](https://github.com/viktormiok/Csppa).

## Data
Data required for cellular spatial point pattern analysis will be deposited online soon:
| Data type     | Link to the data | Code to get the data |
| ------------- | ------------- | ------------- |
| Aldh1l1 only  | [link](https://github.com/viktormiok/AstrocytesHeterogenityARC/blob/main/SPP_data_all.csv) | [link](https://github.com/viktormiok/AstrocytesHeterogenityARC/blob/main/Csppa_analysis.ipynb) |
| Gfap only      | [link](https://github.com/viktormiok/AstrocytesHeterogenityARC/blob/main/SPP_data_all.csv) | [link](https://github.com/viktormiok/AstrocytesHeterogenityARC/blob/main/Csppa_analysis.ipynb) |
| Double positive      | [link](https://github.com/viktormiok/AstrocytesHeterogenityARC/blob/main/SPP_data_all.csv) | [link](https://github.com/viktormiok/AstrocytesHeterogenityARC/blob/main/Csppa_analysis.ipynb) |

## Tutorials

Please see the following notebook for detailed examples of what you can do with __`CsppaRshiny`__: 

### CsppaRshiny example:
* [Notebook](https://github.com/viktormiok/Csppa/blob/main/notebooks/asppa_code.ipynb)

## License

__`CsppaRshiny`__ is distributed under the MIT license. Details about the license of __`CsppaRshiny`__ are provided in the `LICENSE` file. Please read the license before using __`CsppaRshiny`__.


## References

Publications related to __`CsppaRshiny`__ include:

- Lutomska, L.M., **Miok, V.**, Krahmer, N., González García, I., Gruber, T., Le Thuc, O., De Bernardis Murat, C., Legutko, B., Sterr, M., Saher, G., Lickert, H., Ussar, S., Tschöp, M., Lutter, D., García-Cáceres, C. (2022), [Diet triggers specific responses of hypothalamic astrocytes in time and region dependent manner](https://onlinelibrary.wiley.com/doi/full/10.1002/glia.24237), *Glia 70 (10), 1795-2008*.
  
- Lutomska, L.M., **Miok, V.**, Krahmer, N., González García, I., Gruber, T., Le Thuc, O., De Bernardis Murat, C., Legutko, B., Sterr, M., Saher, G., Lickert, H., Ussar, S., Tschöp, M., Lutter, D., García-Cáceres, C.(2021), [Hypercaloric diet selectively triggers a transient molecular rearrangement of astrocytes in the arcuate nucleus]( https://www.biorxiv.org/content/10.1101/2022.03.30.486358v1.abstract), bioRxiv, 4(1).
  
Please cite the relevant publications if you use __`CsppaRshiny`__.
