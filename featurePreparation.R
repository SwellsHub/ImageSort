source("https://bioconductor.org/biocLite.R")
biocLite("EBImage")
library("EBImage")
library("pracma")

setwd("C:/Users/spenc/Downloads/stMarysML/machineLearning/train/Train")

path <- ("C:/Users/spenc/Downloads/stMarysML/machineLearning/train/Train")

file.names <- dir(path, pattern = ".jpg")

featureNames = list.files(path = 'C:/Users/spenc/Downloads/stMarysML/machineLearning/train/Train/')
featureNames = featureNames[order(as.numeric(sub("([0-9]*).*", "\\1", featureNames)))]




featureNamesCut = sub(pattern = "_.*$", replacement = "", x = featureNames)
featureNamesCut <- as.numeric(featureNamesCut)
featureNamesCutFinal <- sub("^[^_]*_([^_]*).*", "\\1", featureNames)
featureNamesCutFinal = sub(pattern = ".jpg$", replacement = "", x = featureNamesCutFinal)
for (k in 1:length(featureNames)) {
  if(strcmp(featureNamesCutFinal[k], "Sigma.jpg")) {
    file.rename(paste0("C:/Users/spenc/Downloads/stMarysML/machineLearning/train/Train/",featureNames[k]), paste0("C:/Users/spenc/Downloads/stMarysML/machineLearning/train/Train/",gsub("Sigma", "sigmaUp", featureNames[k])))
  }
    
}
featureNamesCutFinal = gsub("Sigma", "sigmaUp", featureNamesCutFinal)
featureNamesCutFactor <- as.numeric(factor(featureNamesCutFinal, ordered = TRUE))
img <- matrix(0:0,length(featureNames),901)
sapply(paste0("C:/Users/spenc/Downloads/stMarysML/machineLearning/directory", unique(featureNamesCutFinal)), dir.create)

for(p in 1:length(featureNames)) {
tempMatrix <- readImage(file.names[p])
tempMatrix <- 1 - tempMatrix
img[p,1:900] <- as.vector(tempMatrix)
img[p,] <- append(featureNamesCutFactor[p], img[p,1:900], after = 1)
file.copy(from = paste0("C:/Users/spenc/Downloads/stMarysML/machineLearning/train/Train/",featureNames[p]), to = paste0("C:/Users/spenc/Downloads/stMarysML/machineLearning/directory", featureNamesCutFinal[p], "/", featureNames[p]))
if(p%%100 == 0) {
  print(p)
}
}


#img <- round(img, digits = 3)
colnames(img) = c("Label", 1:900)
write.table(img, file = "C:/Users/spenc/Downloads/stMarysML/machineLearning/50000Rows.csv", quote = FALSE, row.names = FALSE, col.names = TRUE, sep = ',')




