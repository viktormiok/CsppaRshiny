server <- function(input, output, session) {
  
  observeEvent(input$update, {
    if(!is.null(input$datafile)){
      
      dat <- read.csv(input$datafile$datapath, sep=";")
      
      if(input$var1 == "Gfap"){
        mark = 'gfap_only'
      }
      if(input$var1 == "Aldh1l1"){
        mark = 'aldh_only'
      }
      if(input$var1 == "Colocalization"){
        mark = 'both'
      }
      marker <- get.data(data = dat,
                         marker = mark, 
                         diet = c(0, 5, 15),
                         mouse = 1:4,
                         arc = 1:8,
                         cal_arc = FALSE
      )
      if(input$var2 == "Chow"){
        dat_mark2 = marker[[1]]
        diet2 = 0
      }
      if(input$var2 == "HFHS 5 days"){
        dat_mark2 = marker[[2]]
        diet2 = 5
      }
      if(input$var2 == "HFHS 15 days"){
        dat_mark2 = marker[[3]]
        diet2 = 15
      }
      if (input$analysis == "initial_visualization"){
        output$plot <- renderPlot(
          gg.aspp(data = dat_mark2,
                  type_plot = input$plt1,
                  title = paste(input$var1, ":", input$var2, 'diet')
          )
        )
      }
      if (input$analysis == "density_test_plots"){
        if(input$var3 == "none"){
          output$plot <- renderPlot(
            dens.aspp(data = dat_mark2, 
                      #z_lim = z_lim,
                      type_plot = "test_plot",
                      window = owin(poly = list(x = c(0, 500, 0), y = c(0, 0, 500))),
                      nr_sq = input$num_sqr_x,
                      title = paste(input$var1, ":", input$var2, 'diet'),
                      col = c("grey", "firebrick2", "yellow"),
                      ribbon = input$ribbon,
                      contour = input$contours,
                      add_square_counts = input$squares,
                      num_size = 1.2,
            )
          )
        }else{
          if(input$var3 == "Chow"){
            dat_mark3 = marker[[1]]
            diet3 = 0
          }
          if(input$var3 == "HFHS 5 days"){
            dat_mark3 = marker[[2]]
            diet3 = 5
          }
          if(input$var3 == "HFHS 15 days"){
            dat_mark3 = marker[[3]]
            diet3 = 15
          }
          if(input$plt == "test_plot"){
            alt <- get.data(data = dat, 
                            marker = mark, 
                            diet = diet3, 
                            mouse = 1:4,
                            arc = 1:8, 
                            cal_arc = TRUE
            ) 
            nul <- get.data(data = dat, 
                            marker = mark, 
                            diet = diet2, 
                            mouse = 1:4,
                            arc = 1:8, 
                            cal_arc = TRUE
            )
            output$plot <- renderPlot(
              dens.aspp(data = dat_mark3, 
                        test_null = nul,
                        test_alt = alt,
                        #z_lim = z_lim,
                        type_plot = input$plt,
                        window = owin(poly = list(x = c(0, 500, 0), y = c(0, 0, 500))),
                        nr_sq = input$num_sqr_x,
                        title = paste(input$var1, ":", input$var2, 'vs.', input$var3, 'diet'),
                        col = c("grey", "firebrick2", "yellow"),
                        ribbon = input$ribbon,
                        contour = input$contours,
                        add_square_counts = input$squares,
                        num_size = 1.2,
                        num_size_sig = 1.5
              )
            )
          }else{
            output$plot <- renderPlot(
              dens.aspp(data = dat_mark2,
                        data1 = dat_mark3,
                        type_plot = input$plt,
                        window = owin(poly = list(x = c(0, 500, 0), y = c(0, 0, 500))), 
                        title = paste(input$var1, ":", input$var2, 'vs.', input$var3, 'diet'),
                        col = c("blue", "grey", "firebrick2"),
                        ribbon = input$ribbon,
                        contour = input$contours
              )
            )
          }
        }
      }  
    }
  })
}
