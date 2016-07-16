
setwd("C:\\Users\\anshuman\\Dropbox\\coursera\\c3.prj\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset")

library(plyr)

run_analysis <- function(){

        # Load general activity lables         
        labels <- loadactivitylabels()
        
        # Load features
        frs <- loadfeatures()

        # Create Merged Data Set
        subject_data <- loaddata("subject","subject_id")
        x_data <- loaddata("X")
        y_data <- loaddata("y","activity_id")
        
        processed_x_data <-  split_x_data_to_columns(x_data,frs)

        # Extract Only columns with mean, std
        extracted_x_data <- processed_x_data[,grepl("mean\\(\\)|std\\(\\)",names(processed_x_data),ignore.case=TRUE)]
        
        # Add Subject, Activities and Readings in one data frame
        mdata <- cbind(subject_data,y_data,extracted_x_data)
        
        # Add descriptive activity names
        act_data <- merge(x = labels,y = mdata, by = "activity_id")
        
        # Descriptive variable names
        new_names <- process_names(names(act_data))
        colnames(act_data) <- new_names
        
        # Create summary
        agg_data <- aggregate(act_data, 
                              by = list(subject = act_data$subject,
                                        activity = act_data$activity_name),
                              FUN=mean)
        
        tidydata <- within(agg_data,rm(activity_id, activity_name, subject_id))
        
        # Write out the file
        write.table(tidydata, file="tidy.txt",row.names = FALSE)
        
        tidydata
}


split_x_data_to_columns <- function(f_x, fr){
        
        f_px <- colsplit(sub("^\\s+", "", gsub("\\s{1,2}"," ",unlist(f_x)))," ",fr$feature_name)
}

process_names <- function(current_names){
        
        new_names <- gsub("\\-","_",current_names)
        new_names <- gsub("\\(\\)","",current_names)
        
        new_names <- gsub("^t","timedomain",new_names)
        new_names <- gsub("^f","frequencydomain",new_names)

        new_names <- gsub("-X","_on_x_axis",new_names)
        new_names <- gsub("-Y","_on_y_axis",new_names)
        new_names <- gsub("-Z","_on_z_axis",new_names)
        
        new_names <- gsub("Body","_body",new_names)
        new_names <- gsub("Acc","_acceleration",new_names)
        new_names <- gsub("Gravity","_gravity",new_names)
        
}

loaddata <- function(type,name=type){

        f_test <- loadfile(paste("test/",type,"_test.txt",sep=""),name)
        f_train <- loadfile(paste("train/",type,"_train.txt",sep=""),name) 
        
        rbind(f_test,f_train)
}


loadactivitylabels <- function(){
        l <- read.delim("activity_labels.txt",sep= " ", header=FALSE, col.names = c("activity_id","activity_name"))
        l
}

loadfeatures <- function(){
 
        fr <- read.csv("features.txt",sep=" ", header= FALSE,col.names = c("feature_number","feature_name"))       
        fr
}

loadfile <- function(fname, hdr){
        
        f <- NULL
        
        if(file.exists(fname)){
         
            f <- read.csv(fname, header = FALSE,col.names = c(hdr))           
            print(paste("DIM : ", dim(f), "  Name : ", fname))
            
            
        } else{
                print(paste("File Not Found : ", fname))
        }
        
        f
}

#
# Function to understand the format of the files
#
probeTest <- function(x, s=","){
        
        f <- NULL
        print(paste("Probing : ",x))
        if(file.exists(x)){
                
                f <- read.csv(x, sep = s, header=FALSE)
                print(str(f))
                # cat("\n")
                # print(head(f))
                cat("\n")
                dim(f)
        } else {
                print(paste("File not found : ",x))
        }
        f
}