
ui <- fluidPage(
  headerPanel("Cellular Spatial Point Patterns Analysis"),
  sidebarLayout(
    sidebarPanel(
      
      p("R Shiny App for analysis and visualizing cellular spatial point patterns."),
      
      fileInput(inputId="datafile",
                label=tags$span(style="color: royalblue;","Upload data"), #label="Upload data", 
                multiple=FALSE,
                placeholder="No file selected", 
                accept="csv"
      ),
      hr(style = "border-top: 1px solid #000000;"),
      selectInput(inputId="analysis",
                  label=tags$span(style="color: royalblue;","Analysis"), #label="Analysis",
                  choices=c("initial_visualization", "3D_plots", "density_test_plots", "classification_plot"),
                  width=200
      ),
      conditionalPanel(condition="input.analysis == 'initial_visualization'",
                       selectInput(inputId="plt1",
                                   label=tags$span(style="color: royalblue;","Plot"), #"Plot",
                                   choices=c("hexagonal_heatmap", "scatter_plot", "polygon", "density_contour"), 
                                   width=200
                       ),
                       selectInput(inputId="var11",
                                   label=tags$span(style="color: royalblue;","Marker"), #"Marker", 
                                   choices=c("Aldh1l1", "Gfap", "Colocalization"), 
                                   width=200
                       ),
                       selectInput(inputId="var21", 
                                   label=tags$span(style="color: royalblue;","Diet"), #"Diet",
                                   choices=c("Chow", "HFHS 5 days", "HFHS 15 days"), 
                                   width=200
                       ),
                       hr(),
                       actionButton(inputId="update",
                                    label="Run Analysis",
                                    width=130,
                                    hight=5
                       )
      ),
      conditionalPanel(condition="input.analysis == 'density_test_plots'",
                       selectInput(inputId="plt", 
                                   label=tags$span(style="color: royalblue;","Plot"), #"Plot",
                                   choices=c("square_plot", "density_plot", "test_plot"),
                                   width=200
                       ),
                       selectInput(inputId="var1",
                                   label=tags$span(style="color: royalblue;","Marker"), #"Marker",
                                   choices=c("Aldh1l1", "Gfap", "Colocalization"), 
                                   width=200
                       ),
                       selectInput(inputId="var2",
                                   label=tags$span(style="color: royalblue;","Diet"), #"Diet", 
                                   choices=c("Chow", "HFHS 5 days", "HFHS 15 days"),
                                   width=200
                       ),
                       selectInput(inputId="var3", 
                                   label=tags$span(style="color: royalblue;","Compare to"), #"Compare to",
                                   choices=c("none", "Chow", "HFHS 5 days", "HFHS 15 days"), 
                                   width=200
                       ),
                       numericInput(inputId="num_sqr_x",
                                    label=tags$span(style="color: royalblue;","Plot"), #"Nr. of squares",
                                    value=10, min=1,
                                    max=20, 
                                    width=100
                       ),
                       checkboxInput(inputId="contours", 
                                     label="Display contours",
                                     value=FALSE
                       ),
                       checkboxInput(inputId="ribbon",
                                     label="Display a color bar",
                                     value=FALSE
                       ),
                       hr(),
                       actionButton(inputId="update",
                                    label="Run Analysis",
                                    width=130,
                                    hight=5
                       )
      ),      
      conditionalPanel(condition="input.analysis == '3D_plots'",
                       selectInput(inputId="plt2",
                                   label=tags$span(style="color: royalblue;","Plot"), #"Plot",
                                   choices=c("3D_dens", "3D_scatter", "3D_dens_interactive"),
                                   width=200
                       ),
                       selectInput(inputId="var12", 
                                   label=tags$span(style="color: royalblue;","Marker"), #"Marker",
                                   choices=c("Aldh1l1", "Gfap", "Colocalization"),
                                   width=200
                       ),
                       selectInput(inputId="var22", 
                                   label=tags$span(style="color: royalblue;","Diet"), #"Diet", 
                                   choices=c("Chow", "HFHS 5 days", "HFHS 15 days"),
                                   width=200
                       ),
                       hr(),
                       actionButton(inputId="update",
                                    label="Run Analysis"
                       )
      ),
      conditionalPanel(condition="input.analysis == 'classification_plot'",
                       selectInput(inputId="plt3",
                                   label=tags$span(style="color: royalblue;","Plot"), #"Plot", 
                                   choices=c("random_forest", "knn_network"),
                                   width=200
                       ),
                       selectInput(inputId="var23",
                                   label=tags$span(style="color: royalblue;","Diet"), #"Diet",
                                   choices=c("Chow", "HFHS 5 days", "HFHS 15 days"),
                                   width=200
                       ),
                       hr(),
                       actionButton(inputId="update",
                                    label="Run Analysis"
                       )
      ),
      br(),
      hr(style="border-top: 1px solid #000000;"),
      downloadButton(
        outputId="download_epicurve",
        label="Download plot"
      )
    ),
    mainPanel(
      h3("Figure", align="center"),
      plotOutput(outputId="plot",
                 height="700px",
                 width="700px"
      )
    )
  )
)
