x <- as.data.frame(readxl::read_xlsx("images/MuleyPublications.xlsx"))

y <- lapply(unique(x$Year), function(z) x[x$Year==z,] )
names(y) <- unique(x$Year)

results <- NULL

for(i in 1:length(y)){
  z <- y[[i]]
  results <- c(results, paste("##", names(y)[i]), "\n")
  for(j in 1:nrow(z)){
    v <- sapply(z[j,], as.vector)
    v["Authors"] <- gsub("Muley V,", "Muley VY,", v["Authors"])
    v["Authors"] <- gsub("Muley V.", "Muley VY.", v["Authors"], fixed = T)
    v["Authors"] <- paste(gsub("Muley VY", "**Muley VY**", v["Authors"]), " (", names(y)[i], "): ", sep = "")
    v["Title"] <- paste(v["Authors"], paste("*", v["Title"], "*", sep = ""), sep = "")
    final <- gsub("  ", " ", paste(v["Title"], v["Journal"], v["Details"], sep = ", "))
    
    final <- c(final,"\n", paste("<a href=\"", v["Published"] ,"\" target=\"_blank\" class=\"btn btn-outline-primary btn-sm\" role=\"button\">WebLink</a>", sep = "") ,"\n")
    
    results <- c(results, final)
  }
}

write.table(results, file = "MuleyPublications.txt", col.names = F, row.names = F, quote = F)






