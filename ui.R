#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


inst <- suppressMessages(lapply(c("ggplot2",
                                  "spatstat",
                                  "randomForest",
                                  "plotly",
                                  "mlr3",
                                  "mlr3learners",
                                  "mlr3viz",
                                  "vioplot",
                                  "plot3D",
                                  "shiny"
),
library,
character.only = TRUE)
) 
# load the code
setwd("/Users/viktorian.miok/Documents/git/asppa/R")
source("dens.aspp.R")
source("get.data.R")
source("test.squares.R")
source("diff.aspp.R")
source("gg.aspp.R")
source("d3.aspp.R")
source("test.saptcorr.R")
source("randF.class.R")
source("get.knn.R")
source("plot.2d.classify.R")
source("plot.2d.knn.R")

# working directory
setwd("/Users/viktorian.miok/Documents/consultation/Luiza/SPPA_astrocytes/shiny/asppa/")

ui <- fluidPage(
  titlePanel("Spatial Point Patterns in Astorcytes"),
  sidebarLayout(
    sidebarPanel(
      
      p("This is an application for testing and visualization of astrocyte spatiall point patterns in n the medial Arcuate Nucleus.\n Your file must be in csv format to upload."),
      
      fileInput(inputId = "datafile",
                label = "Upload a data file", 
                multiple = FALSE,
                placeholder = "No file selected", 
                accept = "csv"
      ),
      selectInput(inputId = "analysis", label = "Analysis", choices = c("density_test_plots","initial_visualization",
                                                                        "3D_plots","classification_plot"), width = 200),
      conditionalPanel(
        condition = "input.analysis == 'density_test_plots'",
        selectInput(inputId = "plt", label = "Plot", choices = c("subtraction_square_plot","subtraction_dens_plot",
                                                                 "test_plot"), width = 200),
        selectInput(inputId = "var1", label = "Marker", choices = c("Aldh1l1", "Gfap", "Colocalization"), width = 200),
        selectInput(inputId = "var2", label = "Diet", choices = c("Chow", "HFHS 5 days", "HFHS 15 days"), width = 200),
        selectInput(inputId = "var3", label = "Compare to", choices = c("Chow", "HFHS 5 days", "HFHS 15 days", "none"), width = 200),
        checkboxInput(inputId = "contours", label = "Display contours", value = FALSE),
        checkboxInput(inputId = "squares", label = "Display number of cells per square", value = FALSE),
        numericInput(inputId = "num_sqr_x", label = "Nr. of squares", value = 10, min = 1, max = 20, width = 100),
        checkboxInput(inputId = "ribbon", label = "Display a color bar", value = FALSE),
        actionButton(inputId = "update", label = "Update", width = 130, hight = 5),
      ),      
      conditionalPanel(
        condition = "input.analysis == 'initial_visualization'",
        selectInput(inputId = "plt1", label = "Plot", choices = c("hexagonal_heatmap","scatter_plot","polygon",
                                                                  "density_contour"), width = 200),
        selectInput(inputId = "var11", label = "Marker", choices = c("Aldh1l1", "Gfap", "Colocalization"), width = 200),
        selectInput(inputId = "var21", label = "Diet", choices = c("Chow", "HFHS 5 days", "HFHS 15 days"), width = 200),
        actionButton(inputId = "update", label = "Update", width = 130, hight = 5)
      ),
      conditionalPanel(
        condition = "input.analysis == '3D_plots'",
        selectInput(inputId = "plt2", label = "Plot", choices = c("3D_dens","3D_scatter","3D_dens_interactive"), width = 200),
        selectInput(inputId = "var12", label = "Marker", choices = c("Aldh1l1", "Gfap", "Colocalization"), width = 200),
        selectInput(inputId = "var22", label = "Diet", choices = c("Chow", "HFHS 5 days", "HFHS 15 days"), width = 200),
        actionButton(inputId = "update", label = "Update", width = 130, hight = 5)
      ),
      conditionalPanel(
        condition = "input.analysis == 'classification_plot'",
        selectInput(inputId = "plt3", label = "Plot", choices = c("random_forest","knn_network"), width = 200),
        selectInput(inputId = "var23", label = "Diet", choices = c("Chow", "HFHS 5 days", "HFHS 15 days"), width = 200),
        actionButton(inputId = "update", label = "Update", width = 130, hight = 5)
      )
    ),
    mainPanel(
      h3("Result"),
      plotOutput(outputId = "plot", height = "700px", width = "700px")
    )
  )
)
