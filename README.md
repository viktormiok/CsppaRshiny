![](https://img.shields.io/badge/language-R-orange.svg) ![version](https://img.shields.io/badge/GiHub_version-1.1.0-519dd9) ![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/viktormiok/tigaR) ![GitHub issues](https://img.shields.io/github/issues/viktormiok/tigaR)

![dependencies](https://img.shields.io/badge/dependencies-up%20to%20date-orange)  	![commit](https://img.shields.io/github/last-commit/viktormiok/tigaR) ![GitHub](https://img.shields.io/github/license/viktormiok/tigaR)

[![Edit with Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/viktormiok/tigaR) 


# CsppaRshiny
The R shiny app __`CsppaRshiny`__ performs machine learning analysis and visualisation of cellular spatial point patterns under hypercaloric diet shifts and it is based on [__`Csppa`__](https://github.com/viktormiok/Csppa) R-package.

The application performs 3D and 2D for visualisation of spatial point pattern density plots, allowing flexibility in order to represent the data and emphasize the question of interest. Further it allows for performing overall and local significance analysis of spatial point pattern densities, employing several statistical approaches.

K Nearest Neighbour and Random Forest classification algorithms are implemented to compare the grouping of the cells expressing different markers within and between the diets. On top of the, correlation and spatial auto-correlation of the cells expressing different markets can be compared using Mentel and Moran I test, respectively.

![image](https://user-images.githubusercontent.com/22052679/150276878-dbb3b1b9-105f-4a72-8358-9e019a74b962.png)

## How to Run the App
If you downloaded the __`CsppaRshiny`__ app locally, have all the dependencies, and wish to run it, simply open the app.R file in RStudio and click the Run App button. You need to load functions from the R folder into RStudio before running the __`CsppaRshiny`__ app or you need to install the R-package [__`Csppa`__](https://github.com/viktormiok/Csppa).

## License

__`CsppaRshiny`__ is distributed under the MIT license. The informatoin about the license of __`CsppaRshiny`__ can be finid in the `LICENSE` file. Please read the license before using __`CsppaRshiny`__.


## References

Publications related to __`CsppaRshiny`__ include:

- Lutomska, L.M., Miok, V., Krahmer, N., González García, I., Gruber, T., Le Thuc, O., De Bernardis Murat, C., Legutko, B., Sterr, M., Saher, G., Lickert, H., Ussar, S., Tschöp, M., Lutter, D., García-Cáceres, C. (2022), "Hypercaloric diet triggers transient molecular rearrangements of astrocytes selectively in the arcuate nucleus", *Submitted*.

Please cite the relevant publications if you use __`CsppaRshiny`__.
