

#   
#   use readLines() to read in a list of file names

format.for.condor <- function(list.of.files) {

    formatted.vector <- NULL;
    output.file.names <- NULL;
    #   strip extensions from file names, for output file names
    for(i in 1:length(list.of.files))   {
        output.file.names[i] <-  sub("[.][^.]*$", "", list.of.files[i]);
    }   # for 
  
    for (i in 1:length(list.of.files))   {

       formatted.vector[i] <- paste(
            "output=$(log_dir)stdout_mixcr_export_", i, ".out\n",
            "error=$(log_dir)stderr_mixcr_export_", i, ".out\n",
            "log=$(log_dir)mixcr_export_", i, ".log\n",
            "arguments=-Xmx10g -jar $(script_dir) ",
            "exportClones ",
            "--preset full ",
            "-vHit ",
            "-jHit ",
            "$(data_dir)assemblies/", list.of.files[i], " ",   #   input
            "$(data_dir)exported/", output.file.names[i], "_exported.txt", #  ouput
            "\nqueue 1\n",
            sep=""); 
    }   #   while

    write.table(formatted.vector,
                file="formatted_for_mixcr_export.txt",
                row.names = FALSE,
                col.names = FALSE,
                quote = FALSE);

}   #   format.for.condor()


