

library(DT)
library(data.table)


#setwd("/data/shinyapps/")
#setwd("/srv/shiny-server/")

###############################
# create list of available modules -- should be refreshed outside of this
###############################

# module --terse avail 2>install_modules.txt
# find ~/EasyBuild_user_config/easybuild-easyconfigs -iname '*.eb' | grep -v "__archive__" >easyconfig_list.txt

###############################
# load available modules
###############################

available_modules <- fread("easyconfig_list.txt",header=FALSE,data.table=FALSE,stringsAsFactors=FALSE)
available_module_list <- strsplit(available_modules$V1,"/",fixed=TRUE)
get_last <- function(x_list){
    list_len <- length(x_list)
    name_file <- c(x_list[list_len-1],x_list[list_len])
    return(name_file)
}
available_mod_names <- data.frame(t(sapply(available_module_list,get_last)),stringsAsFactors=FALSE)
colnames(available_mod_names) <- c("program","bundle.version")
attach(available_mod_names)

###############################
# load installed modules
###############################
installed_modules <- fread("grep -v '[:/]$' install_modules.txt",header=FALSE,stringsAsFactors=FALSE, data.table=FALSE)

installed_modules_list <- strsplit(installed_modules$V1,"[/]",perl=TRUE)
installed_modules <- cbind(sapply(installed_modules_list,"[[", 1),installed_modules)
colnames(installed_modules) <- c("program","version installed")


###############################
# mark installed modules
###############################


function(input, output) {
    
    # Filter data based on selections
    output$table1 <- DT::renderDataTable(DT::datatable({
        data <- available_mod_names #mpg
        if (input$repts == "Yes") {
            data <- data[!(duplicated(data$program)),]
        }
        data
    }))
    
    # Filter data based on selections
    output$table2 <- DT::renderDataTable(DT::datatable({
        data <- installed_modules #mpg
        if (input$repts == "Yes") {
            data <- data[!(duplicated(data$program)),]
            #data <- data
        }
        data
    }))
 
    output$value <- renderPrint({ input$text })
    
    ## get value, get action button push and submit a job
    # script will need:
    # - accept eb file name as input
    # - search for eb file
    # - parse to validate file was specified correctly
    # - activate all the stuff via Bill's email
    # - install
    # - send user summary success/fail

    
}

