server <- function(input, 
                   output,
                   session) {
  observeEvent(input$update, {
    if(!is.null(input$datafile)){
      
      dat <- read.csv(input$datafile$datapath,
                      sep=";"
      )
      if(input$var1 == "Gfap") mark = 'gfap_only'
      if(input$var1 == "Aldh1l1") mark = 'aldh_only' 
      if(input$var1 == "Colocalization") mark = 'both'
      marker <- get.data(data=dat,
                         marker=mark, 
                         diet=c(0, 5, 15),
                         mouse=1:4,
                         arc=1:8,
                         cal_arc=FALSE
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
      output$plot <- renderPlot({
        if(input$analysis == "initial_visualization"){
          
          if(input$var11 == "Gfap") mark = 'gfap_only'
          if(input$var11 == "Aldh1l1") mark = 'aldh_only'
          if(input$var11 == "Colocalization") mark = 'both'
          marker <- get.data(data=dat,
                             marker=mark, 
                             diet=c(0, 5, 15),
                             mouse=1:4,
                             arc=1:8,
                             cal_arc=FALSE
          )
          if(input$var21 == "Chow"){
            dat_mark2 = marker[[1]]
            diet2 = 0
          }
          if(input$var21 == "HFHS 5 days"){
            dat_mark2 = marker[[2]]
            diet2 = 5
          }
          if(input$var21 == "HFHS 15 days"){
            dat_mark2 = marker[[3]]
            diet2 = 15
          }
          p <- gg.aspp(data=dat_mark2,
                       type_plot=input$plt1,
                       title=paste(input$var11, ":", input$var21, 'diet')
          )
          print(p)
        }
        if(input$analysis == "3D_plots"){
          if(input$var12 == "Gfap") mark = 'gfap_only'
          if(input$var12 == "Aldh1l1") mark = 'aldh_only'
          if(input$var12 == "Colocalization") mark = 'both'
          marker <- get.data(data=dat,
                             marker=mark, 
                             diet=c(0, 5, 15),
                             mouse=1:4,
                             arc=1:8,
                             cal_arc=FALSE
          )
          if(input$var22 == "Chow"){
            dat_mark2 = marker[[1]]
            diet2 = 0
          }
          if(input$var22 == "HFHS 5 days"){
            dat_mark2 = marker[[2]]
            diet2 = 5
          }
          if(input$var22 == "HFHS 15 days"){
            dat_mark2 = marker[[3]]
            diet2 = 15
          }
          if(input$plt2 == "3D_dens"){
            d3.aspp(data=dat_mark2,
                    type_plot="3D_plot",
                    window=owin(poly=list(x=c(0, 500, 0), y=c(0, 0, 500))),
                    title=paste(input$var12, ":", input$var22, 'diet'),
                    col="greenyellow",
                    theta=0,
                    phi=60
            )
          } else{
            if(input$plt2 == "3D_scatter"){
              ps <- scatter3D(dat_mark2$X, 
                              dat_mark2$Y,
                              as.numeric(as.factor(paste0(dat_mark2$Mouse, dat_mark2$ARC, dat_mark2$Diet))),
                              pch=20,
                              nticks=5,
                              col="cornflowerblue",
                              ticktype="detailed",
                              theta=50,
                              phi=5, 
                              xlab="X", 
                              ylab="Y", 
                              zlab="Slides", 
                              main="gfap",
                              cex=0.3
              )
              print(ps)
            } else{
              p <- d3.aspp(data=dat_mark2,
                           window=owin(poly=list(x=c(0, 500, 0), y=c(0, 0, 500))),
                           type_plot="3D_plot_interactive",
                           title="Gfap chow diet"
              )
              print(p)
            }
            
          }
        }
        if(input$analysis == "classification_plot"){
          marker1 <- get.data(data=dat,
                              marker='gfap_only', 
                              diet=c(0, 5, 15),
                              mouse=1:4,
                              arc=1:8,
                              cal_arc=FALSE
          )
          marker2 <- get.data(data=dat,
                              marker='aldh_only', 
                              diet=c(0, 5, 15),
                              mouse=1:4,
                              arc=1:8,
                              cal_arc=FALSE
          )
          marker3 <- get.data(data=dat,
                              marker='both', 
                              diet=c(0, 5, 15),
                              mouse=1:4,
                              arc=1:8,
                              cal_arc=FALSE
          )
          if(input$var23 == "Chow") all = rbind(marker1[[1]], marker2[[1]], marker3[[1]]) 
          if(input$var23 == "HFHS 5 days") all = rbind(marker1[[2]], marker2[[2]], marker3[[2]]) 
          if(input$var23 == "HFHS 15 days") all = rbind(marker1[[3]], marker2[[3]], marker3[[3]]) 
          
          moran=test.saptcorr(dataX=all$X,
                              dataY=all$Y, 
                              dataG=all$Gene, 
                              method="Moran.I"
          )
          if(input$plt3 == "random_forest"){
            theme_update(text=element_text(size=20))
            pl=randF.class(dataX=all$X,
                           dataY=all$Y, 
                           dataG=all$Gene) + 
              xlab(expression(paste("Distance ", "(", mu, "m)"))) +
              ylab(expression(paste("Distance ", "(", mu, "m)"))) + 
              scale_fill_manual(values=c("limegreen","dodgerblue","magenta")) +
              xlim(0,500) +
              ylim(0,450) +
              geom_text(x=350, 
                        y=350,
                        label=paste("Moran.I=", as.character(round(moran$observed, 3))),
                        size=7
              )
            print(pl)
          }
          if(input$plt3 == "knn_network"){
            theme_update(text=element_text(size=20))
            pk <- plot.2d.knn(train_labels=all$Gene, 
                              train_data=all[,6:7],
                              k=5,
                              X1="X",
                              X2="Y") + 
              annotate("text", 
                       x=400,
                       y=400, 
                       label=paste("Moran.I=", as.character(round(t$observed, 3))),
                       size=6) + 
              xlab(expression(paste("Distance ", "(", mu, "m)"))) +
              ylab(expression(paste("Distance ", "(", mu, "m)")))
            print(pk)
          }
          
        }
        if(input$analysis == "density_test_plots"){
          if(input$var1 == "Gfap") mark = 'gfap_only'
          if(input$var1 == "Aldh1l1") mark = 'aldh_only' 
          if(input$var1 == "Colocalization") mark = 'both'
          marker <- get.data(data=dat,
                             marker=mark, 
                             diet=c(0, 5, 15),
                             mouse=1:4,
                             arc=1:8,
                             cal_arc=FALSE
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
          if(input$plt == "square_plot"){
            if(input$var3 == "none"){
              dens.aspp(data=dat_mark2, 
                        type_plot="subtraction_square_plot",
                        window=owin(poly=list(x=c(0, 500, 0), y=c(0, 0, 500))),
                        nr_sq=input$num_sqr_x,
                        title=paste(input$var1, ":", input$var2, 'diet'),
                        col=c("grey", "firebrick2", "yellow"),
                        ribbon=input$ribbon,
                        contour=input$contours,
              )
            } else{
              dens.aspp(data=dat_mark2,
                        data1=dat_mark3,
                        type_plot="subtraction_square_plot",
                        window=owin(poly=list(x=c(0, 500, 0), y=c(0, 0, 500))), 
                        nr_sq=input$num_sqr_x,
                        title=paste(input$var1, ":", input$var2, 'vs.', input$var3, 'diet'),
                        col=c("blue", "grey", "firebrick2"),
                        ribbon=input$ribbon,
                        contour=input$contours
              )
            }
          }
          if(input$plt == "density_plot"){
            if(input$var3 == "none"){
              dens.aspp(data=dat_mark2, 
                        type_plot="subtraction_dens_plot",
                        window=owin(poly=list(x=c(0, 500, 0), y=c(0, 0, 500))),
                        nr_sq=input$num_sqr_x,
                        title=paste(input$var1, ":", input$var2, 'diet'),
                        col=c("yellow", "firebrick2", "grey"),
                        ribbon=input$ribbon,
                        contour=input$contours,
              )
            } else{
              dens.aspp(data=dat_mark2,
                        data1=dat_mark3,
                        type_plot="subtraction_dens_plot",
                        window=owin(poly=list(x=c(0, 500, 0), y=c(0, 0, 500))), 
                        nr_sq=input$num_sqr_x,
                        title=paste(input$var1, ":", input$var2, 'vs.', input$var3, 'diet'),
                        col=c("blue", "grey", "firebrick2"),
                        ribbon=input$ribbon,
                        contour=input$contours
              )
            }
          }
          if(input$plt == "test_plot"){
            if(input$var3 == "none"){
              dens.aspp(data=dat_mark2,
                        type_plot="test_plot",
                        window=owin(poly=list(x=c(0, 500, 0), y=c(0, 0, 500))),
                        nr_sq=input$num_sqr_x,
                        title=paste(input$var1, ":", input$var2, 'vs.', input$var3, 'diet'),
                        col=c("grey", "firebrick2", "yellow"),
                        ribbon=input$ribbon,
                        contour=input$contours,
                        cex.axis=1.5,
                        cex.lab=1.2
              )
            } else{
              alt <- get.data(data=dat, 
                              marker=mark, 
                              diet=diet3, 
                              mouse=1:4,
                              arc=1:8, 
                              cal_arc=TRUE
              ) 
              nul <- get.data(data=dat, 
                              marker=mark, 
                              diet=diet2, 
                              mouse=1:4,
                              arc=1:8, 
                              cal_arc=TRUE
              )
              dens.aspp(data=dat_mark2,
                        data1=dat_mark3,
                        test_null=nul,
                        test_alt=alt,
                        type_plot="subtraction_dens_plot",
                        window=owin(poly=list(x=c(0, 500, 0), y=c(0, 0, 500))),
                        nr_sq=input$num_sqr_x,
                        title=paste(input$var1, ":", input$var2, 'vs.', input$var3, 'diet'),
                        col=c("blue", "grey", "firebrick2"),
                        ribbon=input$ribbon,
                        contour=input$contours,
                        cex.axis=1.2,
                        cex.lab=1.2
              )
            }
          }
        }
      })    
    }
  })
}
